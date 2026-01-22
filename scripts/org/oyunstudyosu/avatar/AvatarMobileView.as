package org.oyunstudyosu.avatar
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.ProfileEvent;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1006")]
   public class AvatarMobileView extends CoreMovieClip
   {
      
      public var avatarName:String;
      
      public var sAvatarName:STextField;
      
      public function AvatarMobileView()
      {
         super();
         this.sAvatarName = TextFieldManager.convertAsArabicTextField(this.getChildByName("avatarName") as TextField,false);
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      override public function added() : void
      {
         this.sAvatarName.text = this.avatarName;
      }
      
      protected function onRemoved() : void
      {
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:ProfileEvent = new ProfileEvent(ProfileEvent.SHOW_PROFILE);
         _loc2_.avatarID = name;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      public function dispose() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         this.parent.removeChild(this);
      }
   }
}

