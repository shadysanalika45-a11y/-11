package com.oyunstudyosu.trace.fixes
{
	import com.oyunstudyosu.avatar.AvatarModel;
	import com.oyunstudyosu.cloth.ClothModel;
	import com.oyunstudyosu.trace.TraceManager;

	/**
	 * AvatarVisibilityFix - Ensures all avatar layers are visible
	 *
	 * Problem: Hair/pants/shoes visible, but face/body/shirt missing
	 *
	 * Fix approach:
	 * 1. Verify default clothing items exist for all categories
	 * 2. Ensure items are applied at initialization
	 * 3. Check asset resolution for each layer
	 * 4. Log detailed diagnostics
	 *
	 * Integration:
	 * - Call ensureDefaultClothes() after avatar initialization
	 * - Hook into avatar render pipeline
	 */
	public class AvatarVisibilityFix
	{
		/**
		 * Ensure all required avatar layers have default items
		 *
		 * @param avatarModel Avatar model instance
		 * @param clothModel Cloth model instance
		 * @param gender "m" or "f"
		 */
		public static function ensureDefaultClothes(avatarModel:AvatarModel, clothModel:ClothModel, gender:String):void
		{
			trace("[AvatarVisibilityFix] Ensuring default clothes for gender: " + gender);

			// Define required categories and their default items
			// These IDs are PLACEHOLDERS - replace with actual IDs from your game data
			var requiredDefaults:Object = {
				// Male defaults
				m: {
					body: 1001,    // Default male body
					face: 1002,    // Default male face
					shirt: 1003,   // Default male shirt
					pants: 1004,   // Default male pants
					shoes: 1005,   // Default male shoes
					hair: 1006     // Default male hair
				},
				// Female defaults
				f: {
					body: 2001,    // Default female body
					face: 2002,    // Default female face
					shirt: 2003,   // Default female shirt
					pants: 2004,   // Default female pants
					shoes: 2005,   // Default female shoes
					hair: 2006     // Default female hair
				}
			};

			var defaults:Object = requiredDefaults[gender];
			if (!defaults)
			{
				trace("[AvatarVisibilityFix] ERROR: Unknown gender: " + gender);
				return;
			}

			// Get current clothes
			var currentClothes:Array = avatarModel.clothesOn || [];
			var clothesById:Object = {};

			for each (var item:Object in currentClothes)
			{
				if (item && item.id)
				{
					clothesById[item.id] = item;
				}
			}

			// Check each required category
			var missing:Array = [];
			for (var category:String in defaults)
			{
				var defaultId:int = defaults[category];
				var found:Boolean = false;

				// Check if any item in this category exists
				// This check is simplified - you'll need to use ClothModel.isMemberOfCategory()
				if (clothesById[defaultId])
				{
					found = true;
				}
				else
				{
					// Search by category using ClothModel
					for each (var existingItem:Object in currentClothes)
					{
						if (matchesCategory(existingItem, category, clothModel))
						{
							found = true;
							break;
						}
					}
				}

				if (!found)
				{
					missing.push(category);

					// Try to add default item
					var added:Boolean = addDefaultItem(avatarModel, clothModel, category, defaultId, gender);

					// Log the issue
					if (TraceManager.instance && TraceManager.instance.avatarCheckpoints)
					{
						TraceManager.instance.avatarCheckpoints.logMissingItem(
							category,
							added ? "default_added" : "default_missing",
							{
								defaultId: defaultId,
								gender: gender,
								currentClothes: currentClothes.length,
								attempted: true,
								success: added
							}
						);
					}

					trace("[AvatarVisibilityFix] " + (added ? "ADDED" : "MISSING") + " default " + category + " (ID: " + defaultId + ")");
				}
			}

			if (missing.length > 0)
			{
				trace("[AvatarVisibilityFix] Missing categories: " + missing.join(", "));
			}
			else
			{
				trace("[AvatarVisibilityFix] All required categories present");
			}
		}

		/**
		 * Check if item matches category
		 */
		private static function matchesCategory(item:Object, category:String, clothModel:ClothModel):Boolean
		{
			if (!item || !item.id)
			{
				return false;
			}

			// Map category to ClothModel bit flags
			// These constants are PLACEHOLDERS - use actual ClothModel constants
			var categoryFlags:Object = {
				body: 0x07,      // BIT00-02 (example)
				face: 0x08,      // BIT03 (example)
				shirt: 0x200,    // BIT09 (example)
				pants: 0x40,     // BIT06 (example)
				shoes: 0x10,     // BIT04 (example)
				hair: 0x100000   // BIT20 (example)
			};

			var flag:uint = categoryFlags[category];
			if (flag == undefined)
			{
				return false;
			}

			// Use ClothModel.isMemberOfCategory if available
			try
			{
				return clothModel.isMemberOfCategory(item.id, flag);
			}
			catch (e:Error)
			{
				trace("[AvatarVisibilityFix] Error checking category: " + e.message);
				return false;
			}
		}

		/**
		 * Add default item to avatar
		 */
		private static function addDefaultItem(avatarModel:AvatarModel, clothModel:ClothModel, category:String, itemId:int, gender:String):Boolean
		{
			try
			{
				// Create default item object
				var defaultItem:Object = {
					id: itemId,
					productId: itemId,
					category: category,
					gender: gender,
					active: true,
					quantity: 1,
					lifeTime: -1,  // Permanent
					timeLeft: -1,
					key: gender + "_" + category
				};

				// Add to avatar's clothes
				if (avatarModel.clothesOn == null)
				{
					avatarModel.clothesOn = [];
				}

				avatarModel.clothesOn.push(defaultItem);

				trace("[AvatarVisibilityFix] Added default item: " + category + " (ID: " + itemId + ")");

				return true;
			}
			catch (e:Error)
			{
				trace("[AvatarVisibilityFix] Failed to add default item " + category + ": " + e.message);
				return false;
			}
		}

		/**
		 * Validate avatar render state
		 * Call this after avatar is rendered to verify all layers
		 */
		public static function validateRenderState(avatarId:*, expectedLayers:Array):Object
		{
			var result:Object = {
				valid: true,
				missingLayers: [],
				presentLayers: []
			};

			// TODO: Implement actual layer visibility check
			// This would inspect the display list to see which sprite layers exist

			// For now, just log what we expect
			trace("[AvatarVisibilityFix] Validating render state for avatar: " + avatarId);
			trace("[AvatarVisibilityFix] Expected layers: " + expectedLayers.join(", "));

			// Log to trace system
			if (TraceManager.instance && TraceManager.instance.avatarCheckpoints)
			{
				TraceManager.instance.avatarCheckpoints.logAvatarRenderState(
					avatarId,
					{}, // Actual layer references would go here
					expectedLayers
				);
			}

			return result;
		}

		/**
		 * Diagnostic function - print full avatar state
		 */
		public static function diagnoseAvatar(avatarModel:AvatarModel, clothModel:ClothModel):void
		{
			trace("[AvatarVisibilityFix] ========== AVATAR DIAGNOSTICS ==========");
			trace("[AvatarVisibilityFix] Avatar ID: " + avatarModel.avatarId);
			trace("[AvatarVisibilityFix] Gender: " + avatarModel.gender);
			trace("[AvatarVisibilityFix] Total clothes: " + (avatarModel.clothesOn ? avatarModel.clothesOn.length : 0));

			if (avatarModel.clothesOn)
			{
				for each (var item:Object in avatarModel.clothesOn)
				{
					trace("[AvatarVisibilityFix]   - Item ID: " + item.id + ", Active: " + item.active + ", Key: " + item.key);
				}
			}

			trace("[AvatarVisibilityFix] Base clothes: " + (avatarModel.baseClothes ? avatarModel.baseClothes.length : 0));

			if (avatarModel.baseClothes)
			{
				for each (var baseItem:Object in avatarModel.baseClothes)
				{
					trace("[AvatarVisibilityFix]   - Base Item ID: " + baseItem);
				}
			}

			trace("[AvatarVisibilityFix] ========================================");

			// Log to trace system
			if (TraceManager.instance && TraceManager.instance.logger)
			{
				TraceManager.instance.logger.logRecord({
					source: "CLIENT",
					dir: "INTERNAL",
					phase: "AFTER_PARSE",
					cmd: "AVATAR_DIAGNOSTICS",
					user: {id: avatarModel.avatarId},
					decoded: {
						type: "AvatarDiagnostics",
						avatarId: avatarModel.avatarId,
						gender: avatarModel.gender,
						clothesOn: avatarModel.clothesOn,
						baseClothes: avatarModel.baseClothes
					},
					notes: ["Full avatar state dump for diagnostics"]
				});
			}
		}
	}
}
