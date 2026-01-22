package feathers.events
{
   import flash.Boot;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   
   public class TriggerEvent extends Event
   {
      
      public static var TRIGGER:String = "trigger";
      
      public var touchPointID:int;
      
      public var stageY:Number;
      
      public var stageX:Number;
      
      public var sizeY:Number;
      
      public var sizeX:Number;
      
      public var shiftKey:Boolean;
      
      public var relatedObject:InteractiveObject;
      
      public var pressure:Number;
      
      public var localY:Number;
      
      public var localX:Number;
      
      public var isPrimaryTouchPoint:Boolean;
      
      public var ctrlKey:Boolean;
      
      public var controlKey:Boolean;
      
      public var commandKey:Boolean;
      
      public var altKey:Boolean;
      
      public function TriggerEvent(param1:String = undefined, param2:Boolean = false, param3:Boolean = false, param4:int = 0, param5:Boolean = false, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 1, param11:InteractiveObject = undefined, param12:Boolean = false, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2,param3);
         touchPointID = param4;
         isPrimaryTouchPoint = param5;
         localX = param6;
         localY = param7;
         stageX = Number(Math.NaN);
         stageY = Number(Math.NaN);
         sizeX = param8;
         sizeY = param9;
         pressure = param10;
         relatedObject = param11;
         ctrlKey = param12;
         altKey = param13;
         shiftKey = param14;
         commandKey = param15;
      }
      
      public static function dispatchFromMouseEvent(param1:IEventDispatcher, param2:MouseEvent) : Boolean
      {
         var _loc3_:TriggerEvent = TriggerEvent.fromMouseEvent(param2);
         return Boolean(param1.dispatchEvent(_loc3_));
      }
      
      public static function dispatchFromTouchEvent(param1:IEventDispatcher, param2:TouchEvent) : Boolean
      {
         var _loc3_:TriggerEvent = TriggerEvent.fromTouchEvent(param2);
         return Boolean(param1.dispatchEvent(_loc3_));
      }
      
      public static function fromMouseEvent(param1:MouseEvent, param2:TriggerEvent = undefined) : TriggerEvent
      {
         if(param1.type != MouseEvent.CLICK)
         {
            throw new ArgumentError("TriggerEvent.fromMouseEvent() requires MouseEvent.CLICK");
         }
         var _loc3_:TriggerEvent = new TriggerEvent("trigger",false,param1.cancelable,-1,false,param1.localX,param1.localY,0,0,1,param1.relatedObject,param1.ctrlKey,param1.altKey,param1.shiftKey,Reflect.hasField(param1,"commandKey") && Reflect.field(param1,"commandKey"));
         _loc3_.stageX = param1.stageX;
         _loc3_.stageY = param1.stageY;
         return _loc3_;
      }
      
      public static function fromTouchEvent(param1:TouchEvent, param2:TriggerEvent = undefined) : TriggerEvent
      {
         if(param1.type != TouchEvent.TOUCH_TAP)
         {
            throw new ArgumentError("TriggerEvent.fromTouchEvent() requires TouchEvent.TOUCH_TAP");
         }
         var _loc3_:TriggerEvent = new TriggerEvent("trigger",false,param1.cancelable,param1.touchPointID,param1.isPrimaryTouchPoint,param1.localX,param1.localY,param1.sizeX,param1.sizeY,param1.pressure,param1.relatedObject,param1.ctrlKey,param1.altKey,param1.shiftKey,Reflect.hasField(param1,"commandKey") && Reflect.field(param1,"commandKey"));
         _loc3_.stageX = param1.stageX;
         _loc3_.stageY = param1.stageY;
         return _loc3_;
      }
      
      override public function clone() : Event
      {
         var _loc1_:TriggerEvent = new TriggerEvent(type,bubbles,cancelable,touchPointID,isPrimaryTouchPoint,localX,localY,sizeX,sizeY,pressure,relatedObject,ctrlKey,altKey,shiftKey,commandKey);
         _loc1_.stageX = stageX;
         _loc1_.stageY = stageY;
         return _loc1_;
      }
   }
}

