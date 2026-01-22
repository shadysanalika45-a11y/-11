package org.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.timer.SyncTimer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1390")]
   public class DiceBg extends CoreMovieClip
   {
      
      public var rotateAnim:MovieClip;
      
      public var border:MovieClip;
      
      private var totalTime:int;
      
      private var totalFrame:int;
      
      private var targetTimestamp:int;
      
      public function DiceBg()
      {
         super();
      }
      
      override public function added() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onUpdate);
      }
      
      override public function removed() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onUpdate);
      }
      
      public function setTimer(param1:int) : void
      {
         this.rotateAnim.gotoAndStop(0);
         this.totalTime = param1 - SyncTimer.timestamp;
         this.totalFrame = this.rotateAnim.totalFrames;
         this.targetTimestamp = param1;
      }
      
      private function onUpdate(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = this.targetTimestamp - SyncTimer.timestamp;
         if(_loc2_ >= 0)
         {
            _loc3_ = Math.round((this.totalTime - _loc2_) / this.totalTime * this.totalFrame);
            this.rotateAnim.gotoAndStop(_loc3_);
         }
         else
         {
            this.rotateAnim.gotoAndStop(0);
         }
      }
      
      public function processTurn(param1:Boolean) : void
      {
         this.buttonMode = param1;
         if(param1)
         {
            this.border.filters = [new GlowFilter(16773494,1,14,14,6,1)];
         }
         else
         {
            this.border.filters = [];
         }
      }
   }
}

