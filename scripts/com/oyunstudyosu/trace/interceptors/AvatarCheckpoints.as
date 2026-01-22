package com.oyunstudyosu.trace.interceptors
{
	import com.oyunstudyosu.trace.TraceLogger;

	/**
	 * AvatarCheckpoints - Explicit avatar/clothes rendering checkpoints
	 *
	 * Tracks:
	 * - Avatar initialization (default clothes)
	 * - Clothes application (each layer: body/face/shirt/pants/shoes/hair)
	 * - Render layer visibility
	 * - Missing items/assets
	 * - Clothes editor operations
	 */
	public class AvatarCheckpoints
	{
		private var _logger:TraceLogger;

		public function AvatarCheckpoints()
		{
			_logger = TraceLogger.instance;
		}

		/**
		 * Log avatar initialization
		 */
		public function logAvatarInit(avatarId:*, gender:String, defaultClothes:Array):void
		{
			var checklist:Object = {
				body: false,
				face: false,
				shirt: false,
				pants: false,
				shoes: false,
				hair: false
			};

			// Check which items are present in default clothes
			if (defaultClothes != null)
			{
				for each (var item:Object in defaultClothes)
				{
					var category:String = inferCategory(item);
					if (category && checklist.hasOwnProperty(category))
					{
						checklist[category] = true;
					}
				}
			}

			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "BEFORE_APPLY",
				cmd: "AVATAR_INIT",
				user: {id: avatarId},
				decoded: {
					type: "AvatarInit",
					avatarId: avatarId,
					gender: gender,
					defaultClothes: defaultClothes
				},
				checkpoints: {
					AVATAR_RENDER_CHECKLIST: checklist
				},
				notes: [
					"Avatar initialized",
					"Gender: " + gender,
					"Default clothes count: " + (defaultClothes ? defaultClothes.length : 0),
					"Missing items: " + getMissingItems(checklist)
				]
			});
		}

		/**
		 * Log single clothes item application
		 */
		public function logClothesApply(clothItem:Object, category:String, result:Object):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "BEFORE_APPLY",
				cmd: "CLOTHES_APPLY",
				decoded: {
					type: "ClothesApply",
					clothItem: clothItem,
					category: category,
					result: result
				},
				checkpoints: {
					CLOTHES_APPLY_RESULT: {
						category: category,
						clothId: clothItem ? clothItem.id : null,
						productId: clothItem ? clothItem.productId : null,
						subType: clothItem ? clothItem.subType : null,
						clip: result ? result.clip : null,
						color: result ? result.color : null,
						asset_resolved: result ? result.assetResolved : false,
						success: result ? result.success : false,
						error: result ? result.error : null
					}
				},
				notes: [
					"Clothes item applied: " + category,
					result && result.success ? "Success" : "Failed",
					result && result.error ? "Error: " + result.error : "",
					result && !result.assetResolved ? "Asset not resolved" : ""
				]
			});
		}

		/**
		 * Log full avatar render state
		 */
		public function logAvatarRenderState(avatarId:*, layers:Object, visibleItems:Array):void
		{
			var checklist:Object = {
				body: layers && layers.body ? true : false,
				face: layers && layers.face ? true : false,
				shirt: layers && layers.shirt ? true : false,
				pants: layers && layers.pants ? true : false,
				shoes: layers && layers.shoes ? true : false,
				hair: layers && layers.hair ? true : false
			};

			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_APPLY",
				cmd: "AVATAR_RENDER_STATE",
				user: {id: avatarId},
				decoded: {
					type: "AvatarRenderState",
					layers: layers,
					visibleItems: visibleItems
				},
				checkpoints: {
					AVATAR_RENDER_CHECKLIST: checklist
				},
				notes: [
					"Avatar render state captured",
					"Visible layers: " + getVisibleLayers(checklist),
					"Missing layers: " + getMissingItems(checklist),
					"Total visible items: " + (visibleItems ? visibleItems.length : 0)
				]
			});
		}

		/**
		 * Log clothes editor operations
		 */
		public function logClothesEditorOpen(availableItems:Array):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "BEFORE_PARSE",
				cmd: "CLOTHES_EDITOR_OPEN",
				decoded: {
					type: "ClothesEditorOpen",
					availableItems: availableItems
				},
				notes: [
					"Clothes editor opened",
					"Available items: " + (availableItems ? availableItems.length : 0)
				]
			});
		}

		public function logClothesEditorSelect(itemId:*, category:String):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "BEFORE_APPLY",
				cmd: "CLOTHES_EDITOR_SELECT",
				decoded: {
					type: "ClothesEditorSelect",
					itemId: itemId,
					category: category
				},
				notes: ["Item selected: " + itemId + " (category: " + category + ")"]
			});
		}

		public function logClothesEditorPreview(itemId:*, previewData:Object):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_PARSE",
				cmd: "CLOTHES_EDITOR_PREVIEW",
				decoded: {
					type: "ClothesEditorPreview",
					itemId: itemId,
					previewData: previewData
				},
				notes: ["Preview rendered for item: " + itemId]
			});
		}

		public function logClothesEditorSave(savedItems:Array):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "BEFORE_APPLY",
				cmd: "CLOTHES_EDITOR_SAVE",
				decoded: {
					type: "ClothesEditorSave",
					savedItems: savedItems
				},
				notes: [
					"Clothes editor save",
					"Items saved: " + (savedItems ? savedItems.length : 0)
				]
			});
		}

		public function logClothesEditorReload(reloadedItems:Array):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_APPLY",
				cmd: "CLOTHES_EDITOR_RELOAD",
				decoded: {
					type: "ClothesEditorReload",
					reloadedItems: reloadedItems
				},
				notes: [
					"Clothes reloaded after save",
					"Items reloaded: " + (reloadedItems ? reloadedItems.length : 0)
				]
			});
		}

		/**
		 * Log missing item/asset reason
		 */
		public function logMissingItem(category:String, reason:String, details:Object = null):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_PARSE",
				cmd: "MISSING_ITEM",
				decoded: {
					type: "MissingItem",
					category: category,
					reason: reason,
					details: details
				},
				notes: [
					"Missing item: " + category,
					"Reason: " + reason
				]
			});
		}

		// Helper methods

		private function inferCategory(item:Object):String
		{
			// Infer category from item properties
			// This is a simplified version - adjust based on actual ClothModel logic

			if (!item)
			{
				return null;
			}

			// Check common category indicators
			if (item.hasOwnProperty("category"))
			{
				return item.category;
			}

			if (item.hasOwnProperty("subType"))
			{
				var subType:String = String(item.subType).toLowerCase();
				if (subType.indexOf("body") >= 0) return "body";
				if (subType.indexOf("face") >= 0) return "face";
				if (subType.indexOf("shirt") >= 0 || subType.indexOf("top") >= 0) return "shirt";
				if (subType.indexOf("pant") >= 0 || subType.indexOf("bottom") >= 0) return "pants";
				if (subType.indexOf("shoe") >= 0 || subType.indexOf("feet") >= 0) return "shoes";
				if (subType.indexOf("hair") >= 0) return "hair";
			}

			if (item.hasOwnProperty("type"))
			{
				var type:String = String(item.type).toLowerCase();
				if (type.indexOf("body") >= 0) return "body";
				if (type.indexOf("face") >= 0) return "face";
				if (type.indexOf("shirt") >= 0) return "shirt";
				if (type.indexOf("pant") >= 0) return "pants";
				if (type.indexOf("shoe") >= 0) return "shoes";
				if (type.indexOf("hair") >= 0) return "hair";
			}

			return "unknown";
		}

		private function getMissingItems(checklist:Object):String
		{
			var missing:Array = [];
			for (var key:String in checklist)
			{
				if (!checklist[key])
				{
					missing.push(key);
				}
			}
			return missing.length > 0 ? missing.join(", ") : "none";
		}

		private function getVisibleLayers(checklist:Object):String
		{
			var visible:Array = [];
			for (var key:String in checklist)
			{
				if (checklist[key])
				{
					visible.push(key);
				}
			}
			return visible.length > 0 ? visible.join(", ") : "none";
		}
	}
}
