package feathers.core
{
   import feathers.utils.DisplayUtil;
   import flash.Boot;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import haxe.IMap;
   import haxe.ds.EnumValueMap;
   
   public class ValidatingSprite extends Sprite implements IValidating
   {
      
      public var _validationQueue:ValidationQueue;
      
      public var _validating:Boolean;
      
      public var _setInvalidCount:int;
      
      public var _invalidationFlags:IMap;
      
      public var _ignoreInvalidationFlags:Boolean;
      
      public var _depth:int;
      
      public var _delayedInvalidationFlags:IMap;
      
      public var _allInvalidDelayed:Boolean;
      
      public var _allInvalid:Boolean;
      
      public function ValidatingSprite()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _ignoreInvalidationFlags = false;
         _depth = -1;
         _validationQueue = null;
         _setInvalidCount = 0;
         _delayedInvalidationFlags = new EnumValueMap();
         _invalidationFlags = new EnumValueMap();
         _allInvalidDelayed = false;
         _allInvalid = false;
         _validating = false;
         super();
         addEventListener(Event.ADDED_TO_STAGE,validatingSprite_addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,validatingSprite_removedFromStageHandler);
      }
      
      public function validatingSprite_removedFromStageHandler(param1:Event) : void
      {
         _depth = -1;
         _validationQueue = null;
      }
      
      public function validatingSprite_addedToStageHandler(param1:Event) : void
      {
         _depth = DisplayUtil.getDisplayObjectDepthFromStage(this);
         _validationQueue = ValidationQueue.forStage(stage);
         if(_validationQueue != null && isInvalid())
         {
            _setInvalidCount = 0;
            _validationQueue.addControl(this);
         }
      }
      
      public function validateNow() : void
      {
         var _loc2_:* = null as InvalidationFlag;
         if(!isInvalid())
         {
            return;
         }
         if(_validating)
         {
            return;
         }
         _validating = true;
         update();
         var _loc1_:* = _invalidationFlags.keys();
         while(_loc1_.hasNext())
         {
            _loc2_ = _loc1_.next();
            _invalidationFlags.remove(_loc2_);
         }
         _allInvalid = _allInvalidDelayed;
         _loc1_ = _delayedInvalidationFlags.keys();
         while(_loc1_.hasNext())
         {
            _loc2_ = _loc1_.next();
            if(_loc2_ == null)
            {
               _allInvalid = true;
            }
            else
            {
               _invalidationFlags._SafeStr_1(_loc2_,true);
            }
            _delayedInvalidationFlags.remove(_loc2_);
         }
         _validating = false;
      }
      
      public function update() : void
      {
      }
      
      public function setInvalidationFlag(param1:InvalidationFlag) : void
      {
         if(_ignoreInvalidationFlags)
         {
            return;
         }
         if(_invalidationFlags.exists(param1))
         {
            return;
         }
         _invalidationFlags._SafeStr_1(param1,true);
      }
      
      public function setInvalid(param1:InvalidationFlag = undefined) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null as InvalidationFlag;
         if(_ignoreInvalidationFlags)
         {
            return;
         }
         var _loc2_:Boolean = isInvalid();
         var _loc3_:Boolean = false;
         if(_validating)
         {
            _loc4_ = _delayedInvalidationFlags.keys();
            if(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               _loc3_ = true;
            }
         }
         if(param1 == null)
         {
            if(_validating)
            {
               _allInvalidDelayed = true;
            }
            else
            {
               _allInvalid = true;
            }
         }
         else if(_validating)
         {
            _delayedInvalidationFlags._SafeStr_1(param1,true);
         }
         else if(param1 != null && !_invalidationFlags.exists(param1))
         {
            _invalidationFlags._SafeStr_1(param1,true);
         }
         if(_validationQueue == null)
         {
            return;
         }
         if(_validating)
         {
            if(_loc3_)
            {
               return;
            }
            ++_setInvalidCount;
            if(_setInvalidCount >= 10)
            {
               throw new IllegalOperationError(Type.getClassName(Type.getClass(this)) + " returned to validation queue too many times during validation. This may be an infinite loop. Try to avoid doing anything that calls setInvalid() during validation.");
            }
            _validationQueue.addControl(this);
            return;
         }
         if(_loc2_)
         {
            return;
         }
         _setInvalidCount = 0;
         _validationQueue.addControl(this);
      }
      
      public function runWithoutInvalidation(param1:Function) : void
      {
         var _loc2_:Boolean = _ignoreInvalidationFlags;
         _ignoreInvalidationFlags = true;
         param1();
         _ignoreInvalidationFlags = _loc2_;
      }
      
      public function isInvalid(param1:InvalidationFlag = undefined) : Boolean
      {
         if(_allInvalid)
         {
            return true;
         }
         if(param1 == null)
         {
            return Boolean(_invalidationFlags.keys().hasNext());
         }
         return _invalidationFlags.exists(param1);
      }
      
      public function get_validating() : Boolean
      {
         return _validating;
      }
      
      public function get validating() : Boolean
      {
         return get_validating();
      }
      
      public function get_depth() : int
      {
         return _depth;
      }
      
      public function get depth() : int
      {
         return get_depth();
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 */
