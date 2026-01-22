package org.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.cloth.ICharPreview;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1407")]
   public class LobbyUIItem extends MovieClip
   {
      
      public var preview:MovieClip;
      
      public var txtAvatarName:TextField;
      
      public var txtStatus:TextField;
      
      public var sTxtStatus:TextField;
      
      public var vo:PartyPlayerVo;
      
      public var charPreview:ICharPreview;
      
      public function LobbyUIItem()
      {
         super();
      }
      
      public function get character() : ICharacter
      {
         return this.vo.character;
      }
      
      public function init(param1:PartyPlayerVo = null) : void
      {
         var _loc2_:MovieClip = null;
         this.y = 0;
         this.vo = param1;
         if(this.sTxtStatus == null)
         {
            this.sTxtStatus = TextFieldManager.convertAsArabicTextField(getChildByName("txtStatus") as TextField,true,false);
         }
         if(param1 == null)
         {
            this.txtAvatarName.text = "";
            this.sTxtStatus.text = Connectr.instance.localizationModel.translate("Waiting Player");
         }
         else
         {
            this.txtAvatarName.text = param1.character.avatarName;
            _loc2_ = new MovieClip();
            this.charPreview = Connectr.instance.clothModel.getNewCharPreview(_loc2_,this.character,true);
            this.charPreview.rotate(3);
            _loc2_.x = 20;
            _loc2_.y = 54;
            this.preview.holder.addChild(_loc2_);
         }
      }
   }
}

