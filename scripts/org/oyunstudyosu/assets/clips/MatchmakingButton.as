package org.oyunstudyosu.assets.clips
{
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.events.Event;
   import flash.text.TextField;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol594")]
   public class MatchmakingButton extends CoreMovieClip
   {
      
      private var createdAt:Date;
      
      public var txtTime:TextField;
      
      public var txtTitle:TextField;
      
      public var sTxtTitle:STextField;
      
      public function MatchmakingButton()
      {
         super();
         this.createdAt = new Date();
      }
      
      override public function added() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(this.sTxtTitle == null)
         {
            this.sTxtTitle = TextFieldManager.convertAsArabicTextField(this.getChildByName("txtTitle") as TextField,false,false);
            this.sTxtTitle.text = $("searching");
         }
      }
      
      override public function removed() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Date = new Date();
         var _loc3_:int = Math.floor((_loc2_.getTime() - this.createdAt.getTime()) / 1000);
         var _loc4_:String = this.lpad(Math.floor(_loc3_ / 60) + "","0",2);
         var _loc5_:String = this.lpad(_loc3_ % 60 + "","0",2);
         this.txtTime.text = _loc4_ + ":" + _loc5_;
      }
      
      private function lpad(param1:String, param2:String, param3:int) : String
      {
         while(param1.length < param3)
         {
            param1 = param2 + param1;
         }
         return param1;
      }
   }
}

