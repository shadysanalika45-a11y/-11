package com.oyunstudyosu.update
{
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdate;
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdateGroup;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class UpdateGroup implements IUpdateGroup
   {
      
      private var updateObjectList:Vector.<IUpdate>;
      
      private var updateFunctionList:Vector.<Function>;
      
      private var duration:uint;
      
      private var lastTimeStamp:int;
      
      private var _timer:Timer;
      
      private var stage:Stage;
      
      private var item:IUpdate;
      
      private var func:Function;
      
      private var currentTime:int;
      
      public function UpdateGroup(param1:Stage, param2:Number)
      {
         super();
         this.updateObjectList = new Vector.<IUpdate>();
         this.updateFunctionList = new Vector.<Function>();
         this.duration = param2;
         this.stage = param1;
         if(param2 > 0)
         {
            this._timer = new Timer(param2);
            this._timer.addEventListener(TimerEvent.TIMER,this.onUpdate);
            this._timer.start();
         }
         else if(param2 == -1)
         {
            param1.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function onUpdate(param1:TimerEvent) : void
      {
         this.update();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.update();
      }
      
      private function update() : void
      {
         this.currentTime = getTimer();
         for each(this.item in this.updateObjectList)
         {
            this.item.update(this.currentTime,this.currentTime - this.lastTimeStamp);
         }
         for each(this.func in this.updateFunctionList)
         {
            this.func(this.currentTime,this.currentTime - this.lastTimeStamp);
         }
         this.lastTimeStamp = this.currentTime;
      }
      
      public function addFunction(param1:Function) : void
      {
         if(this.updateFunctionList.indexOf(param1) == -1)
         {
            this.updateFunctionList.push(param1);
         }
      }
      
      public function removeFunction(param1:Function) : void
      {
         if(this.updateFunctionList.indexOf(param1) > -1)
         {
            this.updateFunctionList.splice(this.updateFunctionList.indexOf(param1),1);
         }
      }
      
      public function add(param1:IUpdate) : void
      {
         if(this.updateObjectList.indexOf(param1) == -1)
         {
            this.updateObjectList.push(param1);
         }
      }
      
      public function remove(param1:IUpdate) : void
      {
         if(this.updateObjectList.indexOf(param1) > -1)
         {
            this.updateObjectList.splice(this.updateObjectList.indexOf(param1),1);
         }
      }
   }
}

