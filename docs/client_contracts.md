# Client Contracts Report (Sanalika/Marhab Flash Client)

This report documents the runtime contracts observed in the extracted AS3 scripts. Evidence references include file/class/function paths for each behavior and schema.

## A) Hotspots / Relevant AS3 Files

### Networking & Protocol
* `scripts/com/oyunstudyosu/service/ServiceModel.as` — ExtensionRequest sender and response dispatcher (`requestData`, `onExtensionResponse`).  
* `scripts/com/oyunstudyosu/service/ServiceParameters.as` — Builds the SFSObject wrapper with `sn`, `data`, `ts`, and `rid` fields.  
* `scripts/com/smartfoxserver/v2/requests/ExtensionRequest.as` — SmartFox request wrapper.  

### Room Variables / User Variables
* `scripts/com/oyunstudyosu/service/ServiceModel.as` — Listeners for `roomVariablesUpdate` and `userVariablesUpdate` with changed variable list.  
* `scripts/com/oyunstudyosu/room/RoomController.as` — Reads room vars (`roomKey`, `width`, `height`, `doors`, `grid`, etc.) and user vars (gender, clothes, position, direction) during `startload`.  
* `scripts/com/oyunstudyosu/avatar/AvatarController.as` — Processes user var `clothes` and applies to avatar.  

### Map XML + Furniture + Chairs
* `scripts/com/oyunstudyosu/room/RoomModel.as` — Base64 → XMLList decode for map XML.  
* `scripts/com/oyunstudyosu/engine/IsoScene.as` — `processMap` creates `MapEntry` for each node.  
* `scripts/com/oyunstudyosu/engine/core/MapEntry.as` — Node parsing rules (required attrs, optional attrs, special cases, chairs).  
* `scripts/com/oyunstudyosu/engine/scene/components/SceneProcessDataComponent.as` — Resolves `def` to clip via `getMovieClip` and instantiates furniture.  

### Grid Base64
* `scripts/com/oyunstudyosu/model/GridModel.as` — Base64 → ByteArray decode, `readInt` width/height, then read bytes.  
* `scripts/com/oyunstudyosu/engine/IsoScene.as` — Converts grid bytes into `CellType` values (walkable/blocked/etc.).  

### Doors / Teleport / Walk
* `scripts/com/oyunstudyosu/door/DoorModel.as` — Door JSON parsing + target coords/dir.  
* `scripts/com/oyunstudyosu/door/DoorVO.as` — Door property class binding via `cn`.  
* `scripts/com/oyunstudyosu/model/WalkModel.as` — `walkrequest` + `walkfinalrequest` flow.  
* `scripts/com/oyunstudyosu/engine/character/Character.as` — Sends `walkrequest` when user moves.  
* `scripts/com/oyunstudyosu/property/TeleportProperty.as` — `teleport` command payload.  
* `scripts/com/oyunstudyosu/property/FlatExitProperty.as`, `PassageProperty.as` — `usedoor` command payload.  
* `scripts/com/oyunstudyosu/engine/IsoScene.as` / `SceneProcessDataComponent.as` — `roomjoincomplete` request on scene ready.  

### Avatar & Clothes
* `scripts/com/oyunstudyosu/engine/character/Character.as` — `setAccesory` applies clothes and rebuilds avatar clips.  
* `scripts/com/oyunstudyosu/cloth/ClothType.as` — Slot bit definitions (body, hair, hat, etc.).  
* `scripts/com/oyunstudyosu/item/ItemModel.as` — Access to cloth data (`getCloth`).  

### vf / ifile Parsing
* `scripts/com/oyunstudyosu/item/InfoFileParser.as` — Base64 decoded lines and parse schema.  
* `scripts/com/oyunstudyosu/cloth/ClothData.as` — Interprets `placeBit`, `states`, `adjustX`, `adjustY`, version; derives gender/product key.  

---

## B) Network Contracts (Commands + Payloads)

### Extension Request Envelope
All client-to-server extension requests are wrapped by `ServiceParameters.getSFSObject()`:

```
{
  sn: <command string>,
  data: <object payload>,
  ts: <sync timestamp>,
  rid: <incrementing request id>
}
```

Evidence: `ServiceParameters.getSFSObject()` populates `sn`, `data`, `ts`, `rid`.  

### Extension Request Sender
`ServiceModel.requestData(cmd, data, ...)` sends `ExtensionRequest(cmd, sfsObject, room)` where `cmd` is the extension command.  

### Extension Response Handler
`ServiceModel.onExtensionResponse` receives:

```
params.cmd    -> extension command
params.params -> ISFSObject payload
```

The payload is converted via `toObject()` and routed to request callbacks, extension handlers, and listeners.  

---

## C) Room + User Variable Contracts

### Room Variables (Examples)
Room variables read in `RoomController.startload`:
* `roomKey` (string)
* `width` (int)
* `height` (int)
* `source` (string)
* `bots` (JSON string)
* `doors` (JSON string)
* `ownerID` (string)
* `ownerName` (string)
* `roomTitle` (string)
* `flatID` (string)
* `roomID` (int or string)
* `grid` (base64 string)

`roomVariablesUpdate` broadcasts changed variable names; listeners can look up typed values in `RoomVariable`.  

### User Variables (Examples)
User variables read in `RoomController.startload` and avatar updates:
* `gender` (string)
* `clothes` (JSON array string)
* `position` (string `"x,y"` format)
* `direction` (int)
* `speed` (double)
* `status` (string)
* `smiley` (string)
* `avatarSize` (double)
* `hand` (string)
* `roles` (string)
* `platform` (string)

---

## D) Map XML Contract

### Decode Path
* Map XML is Base64 decoded into `XMLList` in `RoomModel.map` setter.  
* `RoomModel.getMap()` converts `XMLList` → `XMLDocument` → `XMLNode`.  

### Root Attributes
* `xOrigin` and `yOrigin` are read from root attributes in `SceneProcessDataComponent.load`.  

### Entry Nodes
Each child node becomes a `MapEntry` unless filtered by `"if"` expression (BooleanEvaluator).

Common required attributes parsed in `MapEntry`:
* `x`, `y`, `z` (int)
* `w`, `h`, `d` (width, height, depth)
* `f`, `s`, `fx`, `lc`, `st`, `sv`
* `def` (clip definition/class name)
* `dir`

Optional attributes:
* `id`, `enabled`, `mask`, `arg`, `ext`, `v`, `gamezoneid`, `type`

Special node types & behavior:
* `stuff` — `a` (action) + `tc` (target cell array) parsed with JSON.
* `cencor` — `count` attribute.
* `chairs` child node — reserves chair grids: `x`, `z`, `dir`, optional `h` + `mask`.

The resolved `def` is used to instantiate a clip via `scene.getMovieClip(def)` in `SceneProcessDataComponent.processEntry`.  

---

## E) Grid Base64 Contract

The grid variable is Base64 decoded in `GridModel.load()`:

```
int width
int height
byte[width * height] cells
```

`IsoScene.processGrid()` maps byte values into `CellType`:
* `-1` → TYPE_WALK_ONLY  
* `0` or `2` → TYPE_EMPTY  
* `1` → TYPE_DISABLED  
* `4` → TYPE_DIAMOND  
* `5` → TYPE_ADMIN  
* `7` → TYPE_FISH  
* `8` → TYPE_SANALIKAX  
* `10` → TYPE_SHORTCUT  
* `11` → TYPE_NPC  
* `12` → TYPE_STAGE  
* `13` → TYPE_FURNITURE_ONLY  

(Mapping per `switch(cell.bit - -1)` in code.)  

---

## F) Doors / Teleport / Walk Contracts

### Doors JSON
Room var `doors` is JSON parsed to an array of objects in `DoorModel.loadJSON`, and for each entry:
* `key`
* `targetX`
* `targetY`
* `targetDir`
* `property` (object with `cn` class name; other fields passed through)

`DoorVO.setProperty` loads `com.oyunstudyosu.property.<cn>` and assigns `property.data`.

### Commands & Payloads (examples)
* `usedoor` — sent from `FlatExitProperty` / `PassageProperty` with door key and optional payload.
* `usehousedoor` — sent from `DoorModel.useHouseDoor` with `{ flatID, password, avatarID }`.
* `teleport` — sent from `TeleportProperty` with `{ roomKey }`.
* `walkrequest` — sent from `Character` with `{ position, direction, speed, step }`.
* `walkfinalrequest` — sent from `WalkModel` (empty payload).
* `roomjoincomplete` — sent from `SceneProcessDataComponent` after scene ready.

---

## G) Avatar + Clothes Contract

### Clothes List Format
User var `clothes` is a JSON array of strings (keys) and is passed to `Character.setAccesory`.  
`ItemModel.getCloth(sex + "_" + <key>)` resolves each entry to `ClothData`:
* `placeBit` (slot bitmask)
* `states`
* `adjustX`, `adjustY`
* `version`
* `placeBitIndexes` (bit positions)

Clothing slots are defined by `ClothType` bit constants (e.g., `BIT00_BODY_BOTTOM`, `BIT09_SHIRT`, `BIT17_HAIR`, `BIT20_HAT`, `BIT22_HANDITEM`, etc.).  

### Rendering
`Character.setAccesory` rebuilds character clips and applies clothing layers. Hair/hat special-casing occurs in Character logic for slot conflicts.

---

## H) vf / ifile Parsing

The info files are Base64-encoded lists of `|`-delimited lines (`InfoFileParser`):

* **Length = 7** → Clothes line:
  * `baseKey | colorList | placeBit | states | adjustX | adjustY | version`
  * Client expands this to gendered and colored keys: `<gender>_<baseKey>_<color>`

* **Length = 4** → Inventory item:
  * `baseKey | field1 | field2 | version`
  * Client expands to `<gender>_<baseKey>`

* **Length = 2** → Smiley:
  * `key | version`

### Tooling
Use `tools/parse_item_files.py` to parse vf/ifile data:

```
python tools/parse_item_files.py /path/to/ifile --json-out parsed_items.json --text-out parsed_items.txt
```

The tool outputs:
* mapping of clip → productKey → gender → placeBit metadata
* a per-placeBit subtype index
* counts and summary

---

## I) Runtime Logging / Instrumentation

Runtime contract logs are written in two formats:

* `client_contracts.log` (plain text)
* `client_contracts.json` (structured JSON events)

Instrumentation is added at:
* Network send/receive (`ServiceModel`)
* Room/user variable updates (`ServiceModel`) and reads (`RoomController`)
* Map decode and entry parsing (`RoomModel`, `MapEntry`, `SceneProcessDataComponent`)
* Grid decode and cell type mapping (`GridModel`, `IsoScene`)
* Door parsing and property binding (`DoorModel`, `DoorVO`)
* Clothes updates/apply (`AvatarController`, `Character`)

Logs can be saved using the `SAVE CONTRACTS` button on the debug console overlay.
