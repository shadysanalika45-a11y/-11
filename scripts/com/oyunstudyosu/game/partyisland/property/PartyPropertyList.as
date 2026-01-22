package com.oyunstudyosu.game.partyisland.property
{
   import flash.utils.Dictionary;
   
   public class PartyPropertyList
   {
      
      private static var list:Dictionary = null;
      
      public function PartyPropertyList()
      {
         super();
      }
      
      public static function init() : void
      {
         list = new Dictionary();
         list["BackOrForthWalkProperty"] = BackOrForthWalkProperty;
         list["FinishPartyProperty"] = FinishPartyProperty;
         list["LuckyCardProperty"] = LuckyCardProperty;
         list["PunishCardProperty"] = PunishCardProperty;
         list["PunishTurnProperty"] = PunishTurnProperty;
         list["RewardCardProperty"] = RewardCardProperty;
         list["RollDiceAgainProperty"] = RollDiceAgainProperty;
         list["SanilRewardProperty"] = SanilRewardProperty;
         list["GameShortcutProperty"] = GameShortcutProperty;
         list["InventoryItemRewardProperty"] = InventoryItemRewardProperty;
         list["BackWalkCard"] = BackWalkProperty;
         list["ForwardWalkCard"] = ForwardWalkProperty;
         list["SanilPunishCard"] = SanilPunishProperty;
         list["SanilRewardCard"] = SanilRewardProperty;
         list["GameShortcutCard"] = GameShortcutProperty;
      }
      
      public static function _SafeStr_2(param1:String) : Class
      {
         if(list == null)
         {
            init();
         }
         return list[param1];
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
