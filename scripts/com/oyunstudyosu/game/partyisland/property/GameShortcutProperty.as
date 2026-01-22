package com.oyunstudyosu.game.partyisland.property
{
   public class GameShortcutProperty extends EmptyPartyProperty
   {
      
      public function GameShortcutProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         setText("Shortcut item received");
      }
   }
}

