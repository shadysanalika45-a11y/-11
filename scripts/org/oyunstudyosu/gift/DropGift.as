package org.oyunstudyosu.gift
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.SoundEvent;
   import com.oyunstudyosu.sanalika.sound.SoundKey;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1440")]
   public class DropGift extends CoreMovieClip
   {
      
      private var _delay:Number;
      
      private var _lastY:int;
      
      private var _giftType:String;
      
      private var _giftFrame:int;
      
      private var soundEvent:SoundEvent;
      
      private var balance:int;
      
      private var _currencyType:String;
      
      public function DropGift()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function get currencyType() : String
      {
         return this._currencyType;
      }
      
      public function set currencyType(param1:String) : void
      {
         this._currencyType = param1;
         this.gotoAndStop(param1);
      }
      
      public function get delay() : Number
      {
         return this._delay;
      }
      
      public function set delay(param1:Number) : void
      {
         this._delay = param1;
      }
      
      override public function added() : void
      {
         TweenMax.killDelayedCallsTo(this.playSound);
         TweenMax.from(this,2,{
            "y":-500,
            "delay":this.delay,
            "ease":Quad.easeIn,
            "onComplete":this.removeItem
         });
         TweenMax.delayedCall(4.5 + this.delay,this.playSound);
      }
      
      private function playSound() : void
      {
         this.soundEvent = new SoundEvent(SoundEvent.PLAY_SOUND);
         this.soundEvent.soundKey = SoundKey.SANIL;
         Dispatcher.dispatchEvent(this.soundEvent);
      }
      
      private function removeItem() : void
      {
         parent.removeChild(this);
      }
      
      override public function removed() : void
      {
         TweenMax.killDelayedCallsTo(this.playSound);
         TweenMax.killDelayedCallsTo(this.removeItem);
         TweenMax.killTweensOf(this);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

