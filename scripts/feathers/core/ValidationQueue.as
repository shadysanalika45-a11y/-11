package feathers.core
{
   import flash.Boot;
   import flash.display.Stage;
   import flash.events.Event;
   import haxe.IMap;
   
   public class ValidationQueue
   {
      
      public static var STAGE_TO_VALIDATION_QUEUE:IMap = new ObjectMap();
      
      public var _validating:Boolean;
      
      public var _stage:Stage;
      
      public var _queue:Array;
      
      public function ValidationQueue(param1:Stage = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _validating = false;
         _queue = [];
         _stage = null;
         _stage = param1;
         _stage.addEventListener(Event.RENDER,validationQueue_stage_renderHandler,false,-1000,true);
      }
      
      public static function forStage(param1:Stage) : ValidationQueue
      {
         if(param1 == null)
         {
            return null;
         }
         if(ValidationQueue.STAGE_TO_VALIDATION_QUEUE[param1] == null)
         {
            ValidationQueue.STAGE_TO_VALIDATION_QUEUE[param1] = new ValidationQueue(param1);
         }
         return ValidationQueue.STAGE_TO_VALIDATION_QUEUE[param1];
      }
      
      public function validationQueue_stage_renderHandler(param1:Event) : void
      {
         validateNow();
      }
      
      public function validateNow() : void
      {
         var _loc2_:* = null as IValidating;
         if(_validating)
         {
            return;
         }
         var _loc1_:int = int(_queue.length);
         if(_loc1_ == 0)
         {
            return;
         }
         _validating = true;
         if(_loc1_ > 1)
         {
            _queue.sort(function(param1:IValidating, param2:IValidating):int
            {
               var _loc3_:* = param2.get_depth() - param1.get_depth();
               if(_loc3_ > 0)
               {
                  return -1;
               }
               if(_loc3_ < 0)
               {
                  return 1;
               }
               return 0;
            });
         }
         while(int(_queue.length) > 0)
         {
            _loc2_ = _queue.shift();
            if(_loc2_.get_depth() >= 0)
            {
               _loc2_.validateNow();
            }
         }
         _validating = false;
      }
      
      public function get_validating() : Boolean
      {
         return _validating;
      }
      
      public function get validating() : Boolean
      {
         return get_validating();
      }
      
      public function dispose() : void
      {
         if(_stage == null)
         {
            return;
         }
         _stage.removeEventListener(Event.RENDER,validationQueue_stage_renderHandler);
         _stage = null;
      }
      
      public function addControl(param1:IValidating) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = null as IValidating;
         var _loc6_:int = 0;
         var _loc7_:* = null as Stage;
         var _loc8_:* = null;
         if(int(_queue.indexOf(param1)) != -1)
         {
            return;
         }
         var _loc2_:int = int(_queue.length);
         if(_validating)
         {
            _loc3_ = param1.get_depth();
            _loc4_ = _loc2_ - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = _queue[_loc4_];
               _loc6_ = _loc5_.get_depth();
               if(_loc3_ >= _loc6_)
               {
                  break;
               }
               _loc4_--;
            }
            _loc4_++;
            _queue.insert(_loc4_,param1);
         }
         else
         {
            _queue[_loc2_] = param1;
            _loc7_ = _stage;
            if(_loc7_ is Stage)
            {
               _loc8_ = Reflect.field(_loc7_,"invalidate");
               _loc8_.apply(_loc8_,[]);
            }
         }
      }
   }
}

import haxe.ds.ObjectMap;

