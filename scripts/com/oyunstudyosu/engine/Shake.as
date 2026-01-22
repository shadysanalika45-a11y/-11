package com.oyunstudyosu.engine
{
   public class Shake
   {
      
      private var duration:int;
      
      private var frequency:int;
      
      private var samples:Array;
      
      private var startTime:*;
      
      public var isShaking:Boolean;
      
      private var t:*;
      
      public function Shake(param1:int, param2:int)
      {
         super();
         this.duration = param1;
         this.frequency = param2;
         var _loc3_:int = int(param1 / 1000 * param2);
         this.samples = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.samples.push(Math.random() * 2 - 1);
            _loc4_++;
         }
         this.startTime = null;
         this.t = null;
         this.isShaking = false;
      }
      
      public function start() : *
      {
         this.startTime = int(new Date().getTime());
         this.t = 0;
         this.isShaking = true;
      }
      
      public function update() : void
      {
         this.t = int(new Date().getTime()) - this.startTime;
         if(this.t > this.duration)
         {
            this.isShaking = false;
         }
      }
      
      public function amplitude(param1:* = null) : Number
      {
         if(param1 == null)
         {
            if(!this.isShaking)
            {
               return 0;
            }
            param1 = this.t;
         }
         var _loc2_:* = param1 / 1000 * this.frequency;
         var _loc3_:* = Math.floor(_loc2_);
         var _loc4_:* = _loc3_ + 1;
         var _loc5_:* = this.decay(param1);
         return (this.noise(_loc3_) + (_loc2_ - _loc3_) * (this.noise(_loc4_) - this.noise(_loc3_))) * _loc5_;
      }
      
      public function noise(param1:int) : Number
      {
         if(param1 >= this.samples.length)
         {
            return 0;
         }
         return this.samples[param1];
      }
      
      public function decay(param1:int) : Number
      {
         if(param1 >= this.duration)
         {
            return 0;
         }
         return (this.duration - param1) / this.duration;
      }
   }
}

