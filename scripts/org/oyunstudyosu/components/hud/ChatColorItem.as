package org.oyunstudyosu.components.hud
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1195")]
   public class ChatColorItem extends CoreMovieClip
   {
      
      private var _id:int;
      
      private var _color:uint;
      
      private var _tipKey:String;
      
      private var myColor:ColorTransform;
      
      private var hudEvent:HudEvent;
      
      public var clip:MovieClip;
      
      public function ChatColorItem()
      {
         super();
      }
      
      override public function added() : void
      {
         this.buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandler);
         Connectr.instance.toolTipModel.addTip(this,this.tipKey);
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         this.hudEvent = new HudEvent(HudEvent.CHAT_COLOR_CHANGE_REQUEST);
         this.hudEvent.colorId = this.id;
         Dispatcher.dispatchEvent(this.hudEvent);
      }
      
      public function get tipKey() : String
      {
         return this._tipKey;
      }
      
      public function set tipKey(param1:String) : void
      {
         this._tipKey = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         this._color = param1;
         this.myColor = this.clip.transform.colorTransform;
         this.myColor.color = param1;
         this.clip.transform.colorTransform = this.myColor;
      }
      
      override public function removed() : void
      {
         Connectr.instance.toolTipModel.removeTip(this);
         removeEventListener(MouseEvent.CLICK,this.clickHandler);
      }
   }
}

