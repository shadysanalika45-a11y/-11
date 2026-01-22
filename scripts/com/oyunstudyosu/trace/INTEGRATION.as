/**
 * INTEGRATION GUIDE FOR TRACE SYSTEM
 *
 * This file shows EXACT code changes needed to integrate the trace system into Sanalika.as
 *
 * Hook Points:
 * 1. Sanalika.as - init() method
 * 2. Sanalika.as - initCommandsCompleted() method
 * 3. AssetModel - request() wrapper calls
 * 4. AvatarController - avatar render calls
 * 5. ClothModel - clothes apply calls
 */

// ============================================
// HOOK POINT 1: Sanalika.as - Add import
// ============================================
// Location: Top of Sanalika.as, after existing imports

import com.oyunstudyosu.trace.TraceManager;

// ============================================
// HOOK POINT 2: Sanalika.as - Add property
// ============================================
// Location: Sanalika class properties (around line 270)

public var traceManager:TraceManager;

// ============================================
// HOOK POINT 3: Sanalika.as - init() method
// ============================================
// Location: Sanalika.init() method, BEFORE the SerialCommand chain (around line 416)
// ADD THIS CODE:

// Initialize trace system EARLY (before any network activity)
traceManager = TraceManager.instance;
// Note: Full initialization happens later after models are ready

// ============================================
// HOOK POINT 4: Sanalika.as - initCommandsCompleted() method
// ============================================
// Location: Sanalika.initCommandsCompleted() method, AFTER controllers are created (around line 450)
// ADD THIS CODE AFTER ALL CONTROLLERS:

// Initialize trace system with all dependencies
if (traceManager && serviceModel && serviceModel.sfs && assetModel)
{
	traceManager.init(
		serviceModel.sfs,        // SmartFox instance
		serviceModel,            // ServiceModel instance
		assetModel,              // AssetModel instance (cast to concrete type)
		layerModel.systemLayer   // UI container for TraceConsole
	);

	trace("[Sanalika] Trace system initialized successfully");
	trace("[Sanalika] Press Ctrl+Shift+T to open trace console");
	trace("[Sanalika] Logs: " + traceManager.logger.getCurrentLogFile().nativePath);
}
else
{
	trace("[Sanalika] Warning: Trace system not initialized - missing dependencies");
}

// ============================================
// HOOK POINT 5: AvatarController.as - Avatar initialization
// ============================================
// Location: AvatarController - wherever avatar is initialized/rendered
// ADD THIS CODE when avatar is initialized:

if (Sanalika.instance.traceManager)
{
	Sanalika.instance.traceManager.avatarCheckpoints.logAvatarInit(
		avatarModel.avatarId,
		avatarModel.gender,
		avatarModel.baseClothes
	);
}

// ============================================
// HOOK POINT 6: AvatarController.as - Avatar render state
// ============================================
// Location: AvatarController - after avatar render layers are updated
// ADD THIS CODE after rendering:

if (Sanalika.instance.traceManager)
{
	Sanalika.instance.traceManager.avatarCheckpoints.logAvatarRenderState(
		avatarModel.avatarId,
		{
			body: bodyLayer,      // Replace with actual layer references
			face: faceLayer,
			shirt: shirtLayer,
			pants: pantsLayer,
			shoes: shoesLayer,
			hair: hairLayer
		},
		visibleClothesArray   // Array of visible clothing items
	);
}

// ============================================
// HOOK POINT 7: ClothModel.as / Avatar rendering - Clothes apply
// ============================================
// Location: Wherever individual clothing items are applied to avatar
// ADD THIS CODE for each clothing item applied:

if (Sanalika.instance.traceManager)
{
	var applyResult:Object = {
		clip: clipName,           // Clip/asset name
		color: colorValue,        // Color applied
		assetResolved: assetFound, // Whether asset was found
		success: applySuccess,    // Whether application succeeded
		error: errorMessage       // Error message if failed
	};

	Sanalika.instance.traceManager.avatarCheckpoints.logClothesApply(
		clothItem,     // Clothing item object {id, productId, subType, etc.}
		category,      // "body", "face", "shirt", "pants", "shoes", "hair"
		applyResult
	);
}

// ============================================
// HOOK POINT 8: Missing item tracking
// ============================================
// Location: Wherever you detect a missing clothing item or asset
// ADD THIS CODE when item is missing:

if (Sanalika.instance.traceManager)
{
	Sanalika.instance.traceManager.avatarCheckpoints.logMissingItem(
		category,  // "body", "face", "shirt", etc.
		reason,    // "missing_default_item", "asset_not_found", "mapping_missing", etc.
		{
			itemId: itemId,
			expectedAsset: expectedAssetPath,
			searchedPaths: attemptedPaths
		}
	);
}

// ============================================
// HOOK POINT 9: Map/Grid parsing
// ============================================
// Location: RoomModel.checkMap() or wherever map XML is parsed
// ADD THIS CODE after map is parsed:

if (Sanalika.instance.traceManager)
{
	// Log full map XML
	Sanalika.instance.traceManager.logger.logRecord({
		source: "CLIENT",
		dir: "IN",
		phase: "AFTER_PARSE",
		cmd: "MAP_PARSED",
		room: {id: roomModel.roomID, name: roomModel.roomName},
		decoded: {
			type: "MapXML",
			xml: mapXML.toXMLString(),  // FULL XML, no truncation
			entries: mapEntries.length
		},
		notes: [
			"Map parsed for room: " + roomModel.roomName,
			"Total entries: " + mapEntries.length
		]
	});
}

// ============================================
// HOOK POINT 10: Grid data
// ============================================
// Location: GridManager - after grid is initialized
// ADD THIS CODE:

if (Sanalika.instance.traceManager)
{
	// Serialize grid data (non-zero cells only to reduce size, but NO truncation)
	var gridData:Array = [];
	for (var x:int = 0; x < gridWidth; x++)
	{
		for (var y:int = 0; y < gridHeight; y++)
		{
			for (var z:int = 0; z < gridDepth; z++)
			{
				var cell:* = grid[x][y][z];
				if (cell != null && cell != 0)
				{
					gridData.push({x: x, y: y, z: z, value: cell});
				}
			}
		}
	}

	Sanalika.instance.traceManager.logger.logRecord({
		source: "CLIENT",
		dir: "INTERNAL",
		phase: "AFTER_PARSE",
		cmd: "GRID_INITIALIZED",
		room: {id: roomModel.roomID, name: roomModel.roomName},
		decoded: {
			type: "Grid",
			dimensions: {width: gridWidth, height: gridHeight, depth: gridDepth},
			nonZeroCells: gridData  // FULL array, no truncation
		},
		notes: [
			"Grid initialized",
			"Dimensions: " + gridWidth + "x" + gridHeight + "x" + gridDepth,
			"Non-zero cells: " + gridData.length
		]
	});
}

// ============================================
// HOOK POINT 11: Chat messages
// ============================================
// Location: ChatController - when sending/receiving chat
// ADD THIS CODE:

if (Sanalika.instance.traceManager)
{
	Sanalika.instance.traceManager.logger.logRecord({
		source: direction,  // "CLIENT" for send, "SERVER" for receive
		dir: direction == "CLIENT" ? "OUT" : "IN",
		phase: "BEFORE_APPLY",
		cmd: "CHAT_MESSAGE",
		user: {id: senderId, name: senderName},
		room: {id: roomId, name: roomName},
		decoded: {
			type: chatType,  // "public", "private", "mod", "admin"
			message: messageText,
			success: !rejected,
			rejection: rejectionReason
		},
		notes: [
			"Chat: " + chatType,
			rejected ? "Rejected: " + rejectionReason : "Success"
		]
	});
}

// ============================================
// HOOK POINT 12: Walking
// ============================================
// Location: Walk handler - both request and broadcast
// ADD THIS CODE:

if (Sanalika.instance.traceManager)
{
	Sanalika.instance.traceManager.logger.logRecord({
		source: isRequest ? "CLIENT" : "SERVER",
		dir: isRequest ? "OUT" : "IN",
		phase: "BEFORE_APPLY",
		cmd: isRequest ? "WALK_REQUEST" : "WALK_BROADCAST",
		user: {id: userId, name: userName},
		room: {id: roomId, name: roomName},
		decoded: {
			type: "Walk",
			from: {x: fromX, y: fromY},
			to: {x: toX, y: toY},
			path: pathArray,  // Full path, no truncation
			speed: speed
		},
		notes: ["Walk: " + fromX + "," + fromY + " -> " + toX + "," + toY]
	});
}

// ============================================
// HOOK POINT 13: VF/IFILE data sources
// ============================================
// Location: Wherever VF/IFILE tools data is parsed
// ADD THIS CODE:

if (Sanalika.instance.traceManager && Sanalika.instance.traceManager.assetInterceptor)
{
	Sanalika.instance.traceManager.assetInterceptor.logDataSource(
		"VF_CLOTHING_DATA",  // or "IFILE_DATA"
		{
			source: sourceFilePath,
			data: parsedData,  // FULL data, no truncation
			mappings: clipToProductMappings,
			genderVariants: genderVariantData
		}
	);
}

// ============================================
// HOOK POINT 14: Application shutdown
// ============================================
// Location: Sanalika - wherever app exits
// ADD THIS CODE before exit:

if (traceManager)
{
	traceManager.shutdown();
}
