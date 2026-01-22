package org.oyunstudyosu.components.hud
{
   import com.oyunstudyosu.chat.ChatColorTemplate;
   import com.oyunstudyosu.events.ChatBalloonEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1198")]
   public class ChatColorPanel extends MovieClip
   {
      
      public var bg:MovieClip;
      
      private var colorItem:ChatColorItem;
      
      private var colorContainer:MovieClip;
      
      private var space:int = 6;
      
      private var len:int;
      
      public function ChatColorPanel()
      {
         super();
         this.colorContainer = new MovieClip();
         addChild(this.colorContainer);
         this.colorContainer.y = this.space;
         this.addBalloons();
         Dispatcher.addEventListener(ChatBalloonEvent.BALLOONS_CHANGED,this.reloadBalloons);
      }
      
      public function addBalloons() : void
      {
         var _loc1_:ChatColorTemplate = null;
         var _loc2_:int = 0;
         while(_loc2_ < Connectr.instance.chatBalloonModel.activeBalloons.length)
         {
            _loc1_ = Connectr.instance.chatBalloonModel.getTemplateByID(Connectr.instance.chatBalloonModel.activeBalloons[_loc2_].id);
            if(_loc1_ != null)
            {
               this.colorItem = new ChatColorItem();
               this.colorItem.id = _loc1_.bgFrame;
               this.colorItem.color = _loc1_.boxColor;
               this.colorItem.tipKey = _loc1_.tipKey;
               this.colorItem.x = _loc2_ * (this.space + this.colorItem.width);
               this.colorContainer.addChild(this.colorItem);
            }
            _loc2_++;
         }
         this.bg.width = this.colorContainer.width + this.space * 3;
         this.colorContainer.x = (this.bg.width - this.colorContainer.width) / 2;
         this.x = -this.width / 2;
         this.len = this.colorContainer.numChildren;
      }
      
      private function reloadBalloons(param1:ChatBalloonEvent) : void
      {
         this.colorContainer.removeChildren();
         this.addBalloons();
      }
   }
}

