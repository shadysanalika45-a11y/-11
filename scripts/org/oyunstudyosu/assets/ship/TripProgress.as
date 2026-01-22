package org.oyunstudyosu.assets.ship
{
   import com.oyunstudyosu.timer.SyncTimer;
   import com.oyunstudyosu.utils.TimeConverter;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol957")]
   public class TripProgress extends MovieClip
   {
      
      public var bar:MovieClip;
      
      public var barEnd:MovieClip;
      
      public var txtArrival:TextField;
      
      public var txtDestination:TextField;
      
      public var txtRemaining:TextField;
      
      public var mcInfo:MovieClip;
      
      public var maxValue:int = 0;
      
      private var _goalTimestamp:int = 0;
      
      public function TripProgress()
      {
         super();
      }
      
      public function get goalTimestamp() : int
      {
         return this._goalTimestamp;
      }
      
      public function set goalTimestamp(param1:int) : *
      {
         this.maxValue = param1 - SyncTimer.timestamp;
         return this._goalTimestamp = param1;
      }
      
      public function update() : void
      {
         var _loc1_:int = this.goalTimestamp - SyncTimer.timestamp;
         this.txtRemaining.text = TimeConverter.toTime(_loc1_ * 1000);
         this.txtRemaining.visible = _loc1_ >= 0;
         var _loc2_:int = 280;
         var _loc3_:Number = (this.maxValue - _loc1_) * _loc2_ / this.maxValue;
         if(_loc3_ > _loc2_)
         {
            _loc3_ = _loc2_;
         }
         this.bar.width = _loc3_;
         this.barEnd.x = _loc3_ + this.bar.x - 2;
      }
   }
}

