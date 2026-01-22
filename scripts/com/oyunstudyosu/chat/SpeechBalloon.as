package com.oyunstudyosu.chat
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import org.oyunstudyosu.assets.buttons.ReportUserButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   public class SpeechBalloon extends MovieClip
   {
      
      public static const DISAPPEARED:String = "disappeared";
      
      public var ts:int;
      
      public var targetY:Number;
      
      public var targetAlpha:Number;
      
      public var ticks:int;
      
      public var isMoving:Boolean;
      
      public var isDisappering:Boolean;
      
      public var isStatic:Boolean;
      
      public var isChecked:Boolean;
      
      public var id:String;
      
      private var char:ICharacter;
      
      private var lastMessage:String;
      
      private var timeoutId:uint;
      
      private var bubble:ISpeechBubble;
      
      private var speechAlpha:Number = 1;
      
      private var lastType:int = -1;
      
      private var delayMax:Number;
      
      private var reportButton:ReportUserButton;
      
      public function SpeechBalloon()
      {
         super();
      }
      
      public static function updateIntersectingSpeechBalloons(param1:Rectangle) : void
      {
         var _loc4_:SpeechBalloon = null;
         var _loc2_:Rectangle = null;
         var _loc3_:int = Sanalika.instance.engine.scene.speechBalloons.length - 1;
         while(_loc3_ >= 0 && _loc3_ < 30)
         {
            _loc4_ = Sanalika.instance.engine.scene.speechBalloons[_loc3_];
            if(!_loc4_.isChecked)
            {
               if(param1.intersects(_loc4_.getRect(Sanalika.instance.engine.scene.container)))
               {
                  _loc2_ = _loc4_.getRect(Sanalika.instance.engine.scene.container);
                  _loc4_.flyTo(_loc4_.y - (_loc2_.y + _loc2_.height - param1.y));
                  _loc2_.y -= _loc2_.y + _loc2_.height - param1.y;
                  if(_loc3_ < 15)
                  {
                     updateIntersectingSpeechBalloons(_loc2_);
                  }
               }
            }
            _loc3_--;
         }
      }
      
      public function initUI(param1:int, param2:int, param3:Point, param4:String, param5:String, param6:Number = 1) : void
      {
         var _loc8_:MovieClip = null;
         ts = getTimer();
         this.speechAlpha = param6;
         isChecked = false;
         this.x = this.y = 0;
         lastMessage = param5;
         if(bubble)
         {
            if(lastType == 11 && !char.isMe)
            {
               bubble.speech(param4,"(" + $("whispering") + ") " + param5);
            }
            else
            {
               bubble.speech(param4,param5);
            }
         }
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         if(this.char && this.char.avatarSize != 1)
         {
            _loc7_ = this.width;
            this.scaleX /= this.char.avatarSize;
            _loc7_ = (_loc7_ - this.width) / 2;
            _loc9_ = this.height;
            this.scaleY /= this.char.avatarSize;
            _loc9_ -= this.height;
         }
         if(bubble)
         {
            _loc8_ = (bubble as CoreMovieClip).getChildByName("bg") as MovieClip;
            this.x = _loc7_ + (int(param1 - _loc8_.width / 2));
            this.y = _loc9_ + (int(param2 - (bubble as CoreMovieClip).height));
         }
         this.alpha = speechAlpha;
         TweenLite.killDelayedCallsTo(completeDelay);
         TweenLite.killTweensOf(this);
         delayMax = Math.min((param4.length + param5.length) / 4,7);
         TweenLite.delayedCall(Math.max(delayMax,4),completeDelay);
      }
      
      public function completeDelay() : void
      {
         TweenLite.killDelayedCallsTo(completeDelay);
         TweenLite.killTweensOf(this);
         isChecked = true;
         flyTo(this.y - 50,0,true);
      }
      
      public function setType(param1:int, param2:ICharacter = null, param3:Boolean = true) : void
      {
         var _loc6_:MovieClip = null;
         var _loc4_:Matrix = null;
         if(param2 != null)
         {
            this.char = param2;
         }
         var _loc5_:ChatColorTemplate = Sanalika.instance.chatBalloonModel.getTemplateByID(param1);
         if(lastType != param1 && _loc5_)
         {
            lastType = param1;
            if(bubble != null && this.contains(bubble as CoreMovieClip))
            {
               this.removeChild(bubble as CoreMovieClip);
            }
            bubble = Sanalika.instance.chatBalloonModel.getBubbleByID(param1);
            _loc6_ = bubble as MovieClip;
            _loc6_.cacheAsBitmap = true;
            if(Connectr.instance.airModel.isAir())
            {
               _loc4_ = new Matrix();
               _loc4_.scale(1.75,1.75);
               _loc6_["cacheAsBitmapMatrix"] = _loc4_;
            }
            this.addChild(_loc6_);
         }
         if(param2 != null && !param2.isMe && param3)
         {
            reportButton = new ReportUserButton();
            reportButton.name = "reportBtn";
            reportButton.visible = false;
            reportButton.x = (bubble as CoreMovieClip).x;
            reportButton.y = ((bubble as CoreMovieClip).getChildByName("bg") as MovieClip).y;
            (bubble as CoreMovieClip).addChild(reportButton);
            (bubble as CoreMovieClip).addEventListener("mouseOver",overMessage);
            (bubble as CoreMovieClip).addEventListener("mouseOut",outMessage);
            reportButton.addEventListener("click",reportClicked);
         }
      }
      
      protected function outMessage(param1:MouseEvent) : void
      {
         reportButton.visible = false;
      }
      
      protected function overMessage(param1:MouseEvent) : void
      {
         reportButton.visible = true;
      }
      
      private function reportClicked(param1:MouseEvent) : void
      {
         var _loc2_:PanelVO = null;
         param1.stopPropagation();
         if(char != null && lastMessage != null && !Sanalika.instance.avatarModel.guest)
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "ReportPanel";
            _loc2_.type = "hud";
            _loc2_.params = {};
            _loc2_.params.avatarId = char.id;
            _loc2_.params.lastMessage = lastMessage;
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      public function flyTo(param1:Number, param2:Number = 1, param3:Boolean = false) : void
      {
         TweenLite.killTweensOf(this);
         var _loc4_:Number = 0.4;
         if(param3)
         {
            TweenLite.killDelayedCallsTo(completeDelay);
            TweenLite.to(this,_loc4_,{
               "y":param1,
               "alpha":0,
               "onComplete":dispose,
               "ease":Quad.easeOut
            });
         }
         else
         {
            TweenLite.to(this,_loc4_,{
               "y":param1,
               "alpha":this.alpha,
               "ease":Quad.easeOut
            });
         }
      }
      
      public function reset() : void
      {
      }
      
      public function dispose() : void
      {
         TweenLite.killDelayedCallsTo(completeDelay);
         TweenLite.killTweensOf(this);
         this.char = null;
         if(bubble)
         {
            (bubble as CoreMovieClip).removeEventListener("mouseOver",overMessage);
            (bubble as CoreMovieClip).removeEventListener("mouseOut",outMessage);
         }
         if(reportButton)
         {
            reportButton.removeEventListener("click",reportClicked);
         }
         (bubble as CoreMovieClip).removeChildren();
         bubble = null;
         removeChildren();
         if(this != null)
         {
            if(this.parent != null)
            {
               this.parent.removeChild(this);
            }
         }
         this.dispatchEvent(new Event("disappeared"));
      }
   }
}

