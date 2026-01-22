# TRACE/LOGGING SYSTEM - Complete Implementation Guide

## Overview

This is a **FULL, NON-LOSSY, END-TO-END TRACE/LOGGING SYSTEM** for SmartFoxServer 2X + Flash/AIR desktop client (AS3).

The system captures **EVERYTHING** from app start to exit, enabling you to:
- Reconstruct backend contracts strictly from observed traces
- Debug avatar/clothes rendering issues
- Track all network traffic (raw + decoded)
- Monitor asset loading and resolution
- Analyze game state changes

## Architecture

```
TraceManager (main coordinator)
  ├── TraceLogger (core NDJSON logging)
  ├── DeepSerializer (non-lossy serialization)
  ├── SFSNetworkInterceptor (all SFS2X traffic)
  ├── ExtensionInterceptor (extension requests/responses)
  ├── AssetLoadingInterceptor (asset loads & resolution)
  ├── AvatarCheckpoints (avatar/clothes state tracking)
  └── TraceConsole (live UI viewer)
```

## Files Created

### Core System
- `scripts/com/oyunstudyosu/trace/TraceLogger.as` - Core logger with NDJSON output
- `scripts/com/oyunstudyosu/trace/TraceRecord.as` - Record structure
- `scripts/com/oyunstudyosu/trace/TraceManager.as` - Main coordinator
- `scripts/com/oyunstudyosu/trace/serializers/DeepSerializer.as` - Deep serialization (no truncation)

### Interceptors
- `scripts/com/oyunstudyosu/trace/interceptors/SFSNetworkInterceptor.as` - All SFS events
- `scripts/com/oyunstudyosu/trace/interceptors/ExtensionInterceptor.as` - Extension traffic
- `scripts/com/oyunstudyosu/trace/interceptors/AssetLoadingInterceptor.as` - Asset tracking
- `scripts/com/oyunstudyosu/trace/interceptors/AvatarCheckpoints.as` - Avatar/clothes checkpoints

### UI
- `scripts/com/oyunstudyosu/trace/ui/TraceConsole.as` - Live trace viewer

### Fixes
- `scripts/com/oyunstudyosu/trace/fixes/AvatarVisibilityFix.as` - Avatar visibility diagnostics

### Integration
- `scripts/com/oyunstudyosu/trace/INTEGRATION.as` - Integration guide (14 hook points)

### Modified Files
- `scripts/Sanalika.as` - Added TraceManager initialization

## Log Files

### Location
```
File.applicationStorageDirectory/logs/
```

On Windows (AIR):
```
C:\Users\<username>\AppData\Roaming\<appname>\Local Store\logs\
```

### File Format
```
session_<YYYYMMDD>_<HHMMSS>_<pid>.ndjson   - Main trace log (JSON lines)
session_<YYYYMMDD>_<HHMMSS>_<pid>.raw      - Raw binary data (optional)
session_<YYYYMMDD>_<HHMMSS>_<pid>_chunk1.ndjson  - Rotation chunks (if > 200MB)
```

### NDJSON Schema
Each line is a JSON object with this structure:

```json
{
  "t_ms": 1674123456789,
  "mono_ms": 123456,
  "seq": 42,
  "thread": "main",
  "frame": 0,
  "source": "CLIENT|SERVER",
  "dir": "IN|OUT|INTERNAL",
  "phase": "BEFORE_PARSE|AFTER_PARSE|BEFORE_APPLY|AFTER_APPLY|APP_START|APP_EXIT",
  "cmd": "EXTENSION_REQUEST_walkfinalrequest",
  "rid": 123,
  "sn": 0,
  "ts": 0,
  "correlation_id": "ext_walkfinalrequest_123_1674123456789",
  "user": {"id": 12345, "name": "player1"},
  "room": {"id": 1, "name": "MainRoom"},
  "raw": {
    "hex": "deadbeef...",
    "b64": "3q2+7w==...",
    "len": 1024
  },
  "decoded": {
    "type": "SFSObject",
    "value": { /* FULL object, no truncation */ }
  },
  "client_transform": {
    "before": { /* state before */ },
    "after": { /* state after */ }
  },
  "state_diff": { /* changes applied */ },
  "checkpoints": {
    "AVATAR_RENDER_CHECKLIST": {
      "body": true,
      "face": true,
      "shirt": false,
      "pants": true,
      "shoes": true,
      "hair": true
    },
    "CLOTHES_APPLY_RESULT": [
      {
        "category": "shirt",
        "clothId": 5001,
        "productId": 5001,
        "clip": "shirt_casual_01",
        "color": 0xFF0000,
        "asset_resolved": false,
        "success": false,
        "error": "Asset not found"
      }
    ]
  },
  "data_sources": [
    {
      "type": "asset_loaded",
      "assetId": "clothes/shirt_01.swf",
      "source": "http://cdn.example.com/assets/clothes/shirt_01.swf",
      "bytes": 12345
    }
  ],
  "notes": [
    "Extension request: walkfinalrequest",
    "Additional context here"
  ],
  "file": {
    "name": "session_20240122_143025_12345.ndjson",
    "chunk": 0,
    "byteOffset": 524288
  }
}
```

## Usage

### 1. Build and Run

After the code changes are integrated, build and run your AIR application normally.

The trace system initializes automatically on startup.

### 2. Viewing Traces

#### Live Console (In-App)
Press **Ctrl+Shift+T** to toggle the trace console.

The console shows:
- Live event stream (one-line summaries)
- Last 100 events
- Button to open full log file

#### Log Files
Click "Open Log File" in the console, or navigate to:
```
File.applicationStorageDirectory/logs/
```

Open the `.ndjson` file in any text editor or JSON viewer.

#### Analyzing Logs
```bash
# View live tail
tail -f session_*.ndjson

# Filter by command
grep '"cmd":"EXTENSION_REQUEST_' session_*.ndjson

# Filter by user
grep '"user":{"id":12345' session_*.ndjson

# Pretty print a single record
head -1 session_*.ndjson | jq '.'

# Count events by command
grep -o '"cmd":"[^"]*"' session_*.ndjson | sort | uniq -c | sort -rn

# Extract all avatar checkpoints
grep 'AVATAR_RENDER_CHECKLIST' session_*.ndjson | jq '.checkpoints.AVATAR_RENDER_CHECKLIST'
```

### 3. Reproduce a Session

To generate a complete trace session for analysis:

1. **Open app** → Wait for "Trace system initialized" message
2. **Login** → Watch console for CONNECTION, LOGIN events
3. **Join room** → ROOM_JOIN, MAP_PARSED, GRID_INITIALIZED
4. **Walk around** → WALK_REQUEST, WALK_BROADCAST events
5. **Open clothes editor** → CLOTHES_EDITOR_OPEN
6. **Change clothes** → CLOTHES_EDITOR_SELECT, CLOTHES_EDITOR_PREVIEW
7. **Save changes** → CLOTHES_EDITOR_SAVE, CLOTHES_EDITOR_RELOAD
8. **Send chat** → CHAT_MESSAGE events
9. **Exit** → SESSION_END

The resulting log will contain a complete trace of all these operations.

### 4. Debug Missing Avatar Parts

The system includes diagnostics for the "missing face/body/shirt" issue:

#### Check Avatar State
The trace automatically logs:
- `AVATAR_INIT` - Initial clothes loaded
- `AVATAR_RENDER_CHECKLIST` - Which layers are visible
- `CLOTHES_APPLY_RESULT` - Each item application result
- `MISSING_ITEM` - Why specific items are missing

#### Search Logs
```bash
# Find avatar initialization
grep 'AVATAR_INIT' session_*.ndjson | jq '.'

# Find missing items
grep 'MISSING_ITEM' session_*.ndjson | jq '.decoded'

# Find failed clothes applications
grep 'CLOTHES_APPLY_RESULT' session_*.ndjson | jq 'select(.checkpoints.CLOTHES_APPLY_RESULT.success == false)'

# Check what layers are visible
grep 'AVATAR_RENDER_CHECKLIST' session_*.ndjson | jq '.checkpoints.AVATAR_RENDER_CHECKLIST' | tail -1
```

#### Manual Diagnostics
Add this code to any point in your application:

```actionscript
import com.oyunstudyosu.trace.fixes.AvatarVisibilityFix;

// Print full avatar state
AvatarVisibilityFix.diagnoseAvatar(
    Sanalika.instance.avatarModel,
    Sanalika.instance.clothModel
);

// Ensure defaults are loaded
AvatarVisibilityFix.ensureDefaultClothes(
    Sanalika.instance.avatarModel,
    Sanalika.instance.clothModel,
    Sanalika.instance.avatarModel.gender
);

// Validate render state
var result:Object = AvatarVisibilityFix.validateRenderState(
    Sanalika.instance.avatarModel.avatarId,
    ["body", "face", "shirt", "pants", "shoes", "hair"]
);

if (!result.valid) {
    trace("Missing layers: " + result.missingLayers.join(", "));
}
```

## Event Coverage

The system captures:

### Network (All Automatic)
- ✅ CONNECTION, CONNECTION_LOST, CONNECTION_RETRY
- ✅ LOGIN, LOGIN_ERROR, LOGOUT
- ✅ ROOM_JOIN, USER_ENTER_ROOM, USER_EXIT_ROOM
- ✅ USER_VARIABLES_UPDATE (clothes, position, etc.)
- ✅ ROOM_VARIABLES_UPDATE
- ✅ EXTENSION_REQUEST_* / EXTENSION_RESPONSE_*
- ✅ PUBLIC_MESSAGE, PRIVATE_MESSAGE, MODERATOR_MESSAGE
- ✅ BUDDY_* events
- ✅ PING_PONG, SOCKET_ERROR

### Game State (Automatic + Manual Hooks)
- ✅ APP_START, SESSION_START, SESSION_END
- ✅ CONFIG loaded
- ✅ INIT_QUEUE
- ✅ MAP_PARSED (full XML, no truncation)
- ✅ GRID_INITIALIZED (full grid data)
- ✅ AVATAR_INIT, AVATAR_RENDER_STATE
- ✅ CLOTHES_APPLY, CLOTHES_EDITOR_* events
- ⚠️ WALK_REQUEST, WALK_BROADCAST (requires manual hook - see INTEGRATION.as)
- ⚠️ CHAT_MESSAGE (requires manual hook - see INTEGRATION.as)

### Assets (Automatic)
- ✅ ASSET_REQUEST - All asset loads initiated
- ✅ ASSET_LOADED - Load completion (success/failure)
- ✅ DATA_SOURCE_PARSED - VF/IFILE data
- ✅ CLASS_RESOLUTION - Embedded class lookups

## Advanced Integration

### Manual Logging

You can add custom trace records anywhere in your code:

```actionscript
import com.oyunstudyosu.trace.TraceManager;

// Simple log
TraceManager.instance.logger.logRecord({
    source: "CLIENT",
    dir: "INTERNAL",
    phase: "BEFORE_APPLY",
    cmd: "CUSTOM_EVENT",
    notes: ["My custom event", "With details"]
});

// Full log with all fields
TraceManager.instance.logger.logRecord({
    source: "CLIENT",
    dir: "OUT",
    phase: "BEFORE_PARSE",
    cmd: "MY_CUSTOM_REQUEST",
    user: {id: userId, name: userName},
    room: {id: roomId, name: roomName},
    decoded: {
        type: "CustomRequest",
        params: myParams
    },
    notes: ["Custom request", "More context"]
});
```

### Avatar Checkpoints

```actionscript
import com.oyunstudyosu.trace.TraceManager;

var checkpoints:AvatarCheckpoints = TraceManager.instance.avatarCheckpoints;

// Log avatar init
checkpoints.logAvatarInit(avatarId, gender, defaultClothes);

// Log clothes apply
checkpoints.logClothesApply(clothItem, "shirt", {
    clip: "shirt_01",
    color: 0xFF0000,
    assetResolved: true,
    success: true,
    error: null
});

// Log render state
checkpoints.logAvatarRenderState(avatarId, layersObject, visibleItems);

// Log clothes editor
checkpoints.logClothesEditorOpen(availableItems);
checkpoints.logClothesEditorSelect(itemId, category);
checkpoints.logClothesEditorPreview(itemId, previewData);
checkpoints.logClothesEditorSave(savedItems);

// Log missing item
checkpoints.logMissingItem("face", "asset_not_found", {
    expectedAsset: "face_01.swf",
    searchedPaths: [...]
});
```

### Asset Tracking

```actionscript
import com.oyunstudyosu.trace.TraceManager;

var assetInterceptor:AssetLoadingInterceptor = TraceManager.instance.assetInterceptor;

// Log data source parsing
assetInterceptor.logDataSource("VF_CLOTHING_DATA", {
    source: "tools/vf/clothes.xml",
    items: clothingItemsArray,
    mappings: clipToProductMap
});

// Log class resolution
assetInterceptor.logClassResolution(
    "clothes/shirt_01",
    "com.assets.clothes.Shirt01",
    true,  // success
    null   // error
);
```

## Troubleshooting

### Trace system not initializing

Check console for:
```
[TraceManager] Initializing trace system...
[SFSNetworkInterceptor] Installed
[ExtensionInterceptor] Installed
[AssetLoadingInterceptor] Installed
[AvatarCheckpoints] initialized
[TraceConsole UI] initialized
[TraceManager] Trace system ready
```

If missing, ensure:
1. TraceManager import added to Sanalika.as
2. `traceManager = TraceManager.instance;` in init()
3. Full initialization in initCommandsCompleted()
4. All dependencies (sfs, serviceModel, assetModel) are available

### Console not opening (Ctrl+Shift+T)

- Ensure app has focus
- Try clicking on the app window first
- Check if systemLayer exists: `trace(Sanalika.instance.layerModel.systemLayer);`

### Empty/missing logs

- Check applicationStorageDirectory: `trace(File.applicationStorageDirectory.nativePath);`
- Verify logs folder exists
- Check file permissions (AIR should auto-create)
- Look for errors in Flash console

### Performance impact

The trace system is designed for minimal impact:
- Buffered writes (100ms flush interval)
- Background serialization
- Console only updates when visible
- No synchronous blocking

But for production, you may want to:
- Disable trace system (comment out init)
- Reduce buffer size
- Filter specific events

## Sample Session Log

Here's what a typical session looks like:

```json
{"t_ms":1674123456789,"mono_ms":0,"seq":0,"thread":"main","frame":0,"source":"CLIENT","dir":"INTERNAL","phase":"APP_START","cmd":"SESSION_START","notes":["TraceLogger initialized","Session ID: 20240122_143025_12345","PID: 12345","Start time: Mon Jan 22 14:30:25 GMT 2024"]}

{"t_ms":1674123456890,"mono_ms":101,"seq":1,"thread":"main","frame":0,"source":"CLIENT","dir":"INTERNAL","phase":"APP_START","cmd":"TRACE_SYSTEM_INIT","notes":["Trace system initializing","TraceManager version 1.0","Full non-lossy trace enabled"]}

{"t_ms":1674123457000,"mono_ms":211,"seq":2,"thread":"main","frame":0,"source":"CLIENT","dir":"OUT","phase":"BEFORE_PARSE","cmd":"LoginRequest","correlation_id":"req_0_1674123457000","decoded":{"type":"LoginRequest","zoneName":"","userName":"player1","password":"***"}}

{"t_ms":1674123457123,"mono_ms":334,"seq":3,"thread":"main","frame":0,"source":"SERVER","dir":"IN","phase":"BEFORE_PARSE","cmd":"LOGIN","correlation_id":"req_0_1674123457000","user":{"id":12345,"name":"player1"},"decoded":{"type":"SFSEvent","eventType":"LOGIN","params":{"user":{...},"data":{...}}}}

{"t_ms":1674123458000,"mono_ms":1211,"seq":10,"thread":"main","frame":0,"source":"CLIENT","dir":"OUT","phase":"BEFORE_PARSE","cmd":"EXTENSION_REQUEST_initQueue","rid":5,"correlation_id":"ext_initQueue_5_1674123458000","user":{"id":12345,"name":"player1"},"decoded":{"type":"ExtensionRequest","cmd":"initQueue","params":{}}}

{"t_ms":1674123458234,"mono_ms":1445,"seq":11,"thread":"main","frame":0,"source":"SERVER","dir":"IN","phase":"BEFORE_PARSE","cmd":"EXTENSION_RESPONSE_initQueue","correlation_id":"ext_initQueue_5_1674123458000","user":{"id":12345,"name":"player1"},"decoded":{"type":"ExtensionResponse","cmd":"initQueue","params":{"clothes":[{"id":1001,"active":true,...},{"id":1002,"active":true,...}],"balance":{"gold":1000,"silver":500}}}}

{"t_ms":1674123459000,"mono_ms":2211,"seq":15,"thread":"main","frame":0,"source":"CLIENT","dir":"INTERNAL","phase":"BEFORE_APPLY","cmd":"AVATAR_INIT","user":{"id":12345},"decoded":{"type":"AvatarInit","avatarId":12345,"gender":"m","defaultClothes":[...]},"checkpoints":{"AVATAR_RENDER_CHECKLIST":{"body":true,"face":true,"shirt":false,"pants":true,"shoes":true,"hair":true}},"notes":["Avatar initialized","Gender: m","Default clothes count: 6","Missing items: shirt"]}

{"t_ms":1674123459567,"mono_ms":2778,"seq":20,"thread":"main","frame":0,"source":"SERVER","dir":"IN","phase":"AFTER_PARSE","cmd":"MAP_PARSED","room":{"id":1,"name":"MainRoom"},"decoded":{"type":"MapXML","xml":"<map><box id=\"1\" x=\"0\" y=\"0\" z=\"0\" width=\"1\" height=\"1\" depth=\"1\">...</box>...</map>","entries":150},"notes":["Map parsed for room: MainRoom","Total entries: 150"]}

...more events...

{"t_ms":1674123500000,"mono_ms":43211,"seq":500,"thread":"main","frame":0,"source":"CLIENT","dir":"INTERNAL","phase":"APP_EXIT","cmd":"SESSION_END","notes":["TraceLogger shutting down","Total records: 501","End time: Mon Jan 22 14:31:40 GMT 2024"]}
```

## Next Steps

1. **Run the application** and verify trace system initializes
2. **Press Ctrl+Shift+T** to open the console
3. **Perform actions** (login, walk, change clothes, chat)
4. **Open log file** and analyze the traces
5. **Search for missing items** to debug avatar visibility
6. **Add custom hooks** as needed (see INTEGRATION.as for all 14 hook points)

## Notes

- **NO TRUNCATION**: All data is logged in full. Large payloads are written completely.
- **File rotation**: Logs rotate at 200MB chunks (configurable in TraceLogger.as)
- **Correlation IDs**: Request/response pairs are correlated for easy tracking
- **Strict ordering**: All events have sequence numbers for timeline reconstruction
- **Full raw bytes**: Coming soon - raw network bytes capture (requires BitSwarm access)

## Contact

For issues or questions about this trace system implementation, refer to the code comments or search the logs for `TRACE_SYSTEM` events.
