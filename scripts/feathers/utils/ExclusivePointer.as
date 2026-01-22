package feathers.utils
{
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.utils.Dictionary;
   import haxe.IMap;
   import haxe.ds.IntMap;
   
   public class ExclusivePointer
   {
      
      public static var stageToObject:IMap = new ObjectMap();
      
      public var _touchClaims:IMap;
      
      public var _stageListenerCount:int;
      
      public var _stage:Stage;
      
      public var _mouseClaim:DisplayObject;
      
      public function ExclusivePointer(param1:Stage = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _touchClaims = new IntMap();
         _mouseClaim = null;
         _stageListenerCount = 0;
         if(param1 == null)
         {
            throw new ArgumentError("Stage cannot be null.");
         }
         _stage = param1;
      }
      
      public static function forStage(param1:Stage) : ExclusivePointer
      {
         if(param1 == null)
         {
            throw new ArgumentError("Stage cannot be null.");
         }
         var _loc2_:ExclusivePointer = ExclusivePointer.stageToObject[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = new ExclusivePointer(param1);
         ExclusivePointer.stageToObject[param1] = _loc2_;
         return _loc2_;
      }
      
      public static function disposeForStage(param1:Stage) : void
      {
         var _loc2_:ExclusivePointer = ExclusivePointer.stageToObject[param1];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.dispose();
         ExclusivePointer.stageToObject.remove(param1);
      }
      
      public function removeTouchClaim(param1:int) : void
      {
         var _loc2_:DisplayObject = _touchClaims.h[param1];
         if(_loc2_ == null)
         {
            return;
         }
         _touchClaims.remove(param1);
         if(!hasClaimOn(_loc2_))
         {
            _loc2_.removeEventListener(Event.REMOVED_FROM_STAGE,exclusivePointer_target_removedFromStageHandler);
         }
         --_stageListenerCount;
         if(_stageListenerCount == 0)
         {
            _stage.removeEventListener(MouseEvent.MOUSE_UP,exclusivePointer_stage_mouseUpHandler);
            _stage.removeEventListener(TouchEvent.TOUCH_END,exclusivePointer_stage_touchEndHandler);
         }
      }
      
      public function removeMouseClaim() : void
      {
         var _loc1_:DisplayObject = _mouseClaim;
         if(_loc1_ == null)
         {
            return;
         }
         _mouseClaim = null;
         if(!hasClaimOn(_loc1_))
         {
            _loc1_.removeEventListener(Event.REMOVED_FROM_STAGE,exclusivePointer_target_removedFromStageHandler);
         }
         --_stageListenerCount;
         if(_stageListenerCount == 0)
         {
            _stage.removeEventListener(MouseEvent.MOUSE_UP,exclusivePointer_stage_mouseUpHandler);
            _stage.removeEventListener(TouchEvent.TOUCH_END,exclusivePointer_stage_touchEndHandler);
         }
      }
      
      public function removeAllClaims() : void
      {
         var _loc7_:* = null as Dictionary;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:Dictionary = _touchClaims.h;
         var _loc2_:int = 0;
         var _loc3_:Dictionary = _loc1_;
         var _loc4_:int = _loc2_;
         var _loc5_:Boolean = §§hasnext(_loc3_,_loc4_);
         var _loc6_:int = _loc4_;
         while(true)
         {
            _loc7_ = _loc1_;
            _loc8_ = _loc2_;
            _loc9_ = §§hasnext(_loc7_,_loc8_);
            _loc6_ = _loc8_;
            if(!_loc9_)
            {
               break;
            }
            _loc10_ = §§nextname(_loc6_,_loc1_);
            _loc2_ = _loc6_;
            _loc11_ = _loc10_;
            removeTouchClaim(_loc11_);
         }
         removeMouseClaim();
      }
      
      public function hasClaimOn(param1:DisplayObject) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as DisplayObject;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as DisplayObject;
         if(_mouseClaim == param1)
         {
            return true;
         }
         var _loc2_:IMap = _touchClaims;
         var _loc3_:IMap = _loc2_;
         var _loc4_:* = _loc2_.keys();
         while(_loc4_.hasNext())
         {
            _loc5_ = int(_loc4_.next());
            _loc6_ = _loc3_._SafeStr_2(_loc5_);
            _loc8_ = _loc7_ = _loc5_;
            _loc9_ = _loc6_;
            if(_loc9_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasClaim() : Boolean
      {
         var _loc7_:* = null as Dictionary;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(_mouseClaim != null)
         {
            return true;
         }
         var _loc1_:Dictionary = _touchClaims.h;
         var _loc2_:int = 0;
         var _loc3_:Dictionary = _loc1_;
         var _loc4_:int = _loc2_;
         var _loc5_:Boolean = §§hasnext(_loc3_,_loc4_);
         var _loc6_:int = _loc4_;
         _loc7_ = _loc1_;
         _loc8_ = _loc2_;
         _loc9_ = §§hasnext(_loc7_,_loc8_);
         _loc6_ = _loc8_;
         if(_loc9_)
         {
            _loc10_ = §§nextname(_loc6_,_loc1_);
            _loc2_ = _loc6_;
            _loc11_ = _loc10_;
            return true;
         }
         return false;
      }
      
      public function getTouchClaim(param1:int) : DisplayObject
      {
         return _touchClaims.h[param1];
      }
      
      public function getMouseClaim() : DisplayObject
      {
         return _mouseClaim;
      }
      
      public function exclusivePointer_target_removedFromStageHandler(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as DisplayObject;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as DisplayObject;
         var _loc2_:DisplayObject = param1.currentTarget;
         if(_mouseClaim == _loc2_)
         {
            removeMouseClaim();
         }
         var _loc3_:IMap = _touchClaims;
         var _loc4_:IMap = _loc3_;
         var _loc5_:* = _loc3_.keys();
         while(_loc5_.hasNext())
         {
            _loc6_ = int(_loc5_.next());
            _loc7_ = _loc4_._SafeStr_2(_loc6_);
            _loc9_ = _loc8_ = _loc6_;
            _loc10_ = _loc7_;
            if(_loc10_ == _loc2_)
            {
               removeTouchClaim(_loc9_);
            }
         }
      }
      
      public function exclusivePointer_stage_touchEndHandler(param1:TouchEvent) : void
      {
         removeTouchClaim(param1.touchPointID);
      }
      
      public function exclusivePointer_stage_mouseUpHandler(param1:MouseEvent) : void
      {
         removeMouseClaim();
      }
      
      public function dispose() : void
      {
         removeAllClaims();
      }
      
      public function claimTouch(param1:int, param2:DisplayObject) : Boolean
      {
         if(param2 == null)
         {
            throw new ArgumentError("Target cannot be null.");
         }
         if(param2.stage != _stage)
         {
            throw new ArgumentError("Target cannot claim a pointer on the selected stage because it appears on a different stage.");
         }
         var _loc3_:DisplayObject = _touchClaims.h[param1];
         if(_loc3_ != null)
         {
            return false;
         }
         _touchClaims.h[param1] = param2;
         param2.addEventListener(Event.REMOVED_FROM_STAGE,exclusivePointer_target_removedFromStageHandler,false,0,true);
         if(_stageListenerCount == 0)
         {
            _stage.addEventListener(MouseEvent.MOUSE_UP,exclusivePointer_stage_mouseUpHandler,false,0,true);
            _stage.addEventListener(TouchEvent.TOUCH_END,exclusivePointer_stage_touchEndHandler,false,0,true);
         }
         ++_stageListenerCount;
         return true;
      }
      
      public function claimMouse(param1:DisplayObject) : Boolean
      {
         if(param1 == null)
         {
            throw new ArgumentError("Target cannot be null.");
         }
         if(param1.stage != _stage)
         {
            throw new ArgumentError("Target cannot claim a pointer on the selected stage because it appears on a different stage.");
         }
         if(_mouseClaim != null)
         {
            return false;
         }
         _mouseClaim = param1;
         param1.addEventListener(Event.REMOVED_FROM_STAGE,exclusivePointer_target_removedFromStageHandler,false,0,true);
         if(_stageListenerCount == 0)
         {
            _stage.addEventListener(MouseEvent.MOUSE_UP,exclusivePointer_stage_mouseUpHandler,false,0,true);
            _stage.addEventListener(TouchEvent.TOUCH_END,exclusivePointer_stage_touchEndHandler,false,0,true);
         }
         ++_stageListenerCount;
         return true;
      }
   }
}

import haxe.ds.ObjectMap;


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
