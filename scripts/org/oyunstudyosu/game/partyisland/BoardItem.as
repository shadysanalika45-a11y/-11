package org.oyunstudyosu.game.partyisland
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1382")]
   public class BoardItem extends MovieClip
   {
      
      public var txtAvatarName:TextField;
      
      public var txtBalance:TextField;
      
      public var txtPool:TextField;
      
      public var txtPosition:TextField;
      
      public function BoardItem()
      {
         super();
         this.txtBalance.text = "0";
         this.txtPool.text = "0";
      }
   }
}

