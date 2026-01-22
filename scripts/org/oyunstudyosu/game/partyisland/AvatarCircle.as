package org.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.cloth.ICharPreview;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1370")]
   public class AvatarCircle extends MovieClip
   {
      
      public var mcMask:MovieClip;
      
      public var holder:MovieClip;
      
      public var vo:PartyPlayerVo;
      
      public var charPreview:ICharPreview;
      
      public function AvatarCircle()
      {
         super();
      }
      
      public function get character() : ICharacter
      {
         return this.vo.character;
      }
      
      public function init(param1:PartyPlayerVo) : void
      {
         this.y = -4;
         this.vo = param1;
         var _loc2_:MovieClip = new MovieClip();
         this.charPreview = Connectr.instance.clothModel.getNewCharPreview(_loc2_,this.character,true);
         this.charPreview.rotate(3);
         _loc2_.x = 20;
         _loc2_.y = 54;
         this.holder.addChild(_loc2_);
      }
   }
}

