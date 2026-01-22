package feathers.core
{
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import haxe.IMap;
   import haxe.ds.ObjectMap;
   import openfl.display._internal.FlashGraphics;
   
   public class DefaultPopUpManager implements IPopUpManager
   {
      
      public var popUps:Array;
      
      public var _root:DisplayObjectContainer;
      
      public var _popUpToOverlay:IMap;
      
      public var _overlayFactory:Function;
      
      public var _ignoreRemoval:Boolean;
      
      public var _centeredPopUps:Array;
      
      public function DefaultPopUpManager(param1:DisplayObjectContainer = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _popUpToOverlay = new ObjectMap();
         _centeredPopUps = [];
         popUps = [];
         _ignoreRemoval = false;
         set_root(param1);
      }
      
      public static function defaultOverlayFactory() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Graphics = _loc1_.graphics;
         var _loc3_:BitmapData = null;
         FlashGraphics.bitmapFill[_loc2_] = _loc3_;
         _loc2_.beginFill(8421504,0.75);
         _loc1_.graphics.drawRect(0,0,1,1);
         _loc2_ = _loc1_.graphics;
         _loc3_ = null;
         FlashGraphics.bitmapFill[_loc2_] = _loc3_;
         _loc2_.endFill();
         return _loc1_;
      }
      
      public function set_root(param1:DisplayObjectContainer) : DisplayObjectContainer
      {
         var _loc5_:* = null as DisplayObject;
         var _loc6_:* = null as DisplayObject;
         if(_root == param1)
         {
            return _root;
         }
         if(param1.stage == null)
         {
            throw new ArgumentError("DefaultPopUpManager root\'s stage property must not be null.");
         }
         var _loc2_:Boolean = _ignoreRemoval;
         _ignoreRemoval = true;
         var _loc3_:int = 0;
         var _loc4_:Array = popUps;
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            _root.removeChild(_loc5_);
            _loc6_ = _popUpToOverlay[_loc5_];
            if(_loc6_ != null)
            {
               _root.removeChild(_loc6_);
            }
         }
         _ignoreRemoval = _loc2_;
         _root = param1;
         _loc3_ = 0;
         _loc4_ = popUps;
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            _loc6_ = _popUpToOverlay[_loc5_];
            if(_loc6_ != null)
            {
               _root.addChild(_loc6_);
            }
            _root.addChild(_loc5_);
         }
         return _root;
      }
      
      public function set root(param1:DisplayObjectContainer) : void
      {
         set_root(param1);
      }
      
      public function set_overlayFactory(param1:Function) : Function
      {
         if(Reflect.compareMethods(_overlayFactory,param1))
         {
            return _overlayFactory;
         }
         _overlayFactory = param1;
         return _overlayFactory;
      }
      
      public function set overlayFactory(param1:Function) : void
      {
         set_overlayFactory(param1);
      }
      
      public function removePopUp(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = int(popUps.indexOf(param1));
         if(_loc2_ == -1)
         {
            return param1;
         }
         return _root.removeChild(param1);
      }
      
      public function removeAllPopUps() : void
      {
         var _loc3_:* = null as DisplayObject;
         var _loc1_:Array = popUps.copy();
         var _loc2_:int = 0;
         while(_loc2_ < int(_loc1_.length))
         {
            _loc3_ = _loc1_[_loc2_];
            _loc2_++;
            if(isPopUp(_loc3_))
            {
               removePopUp(_loc3_);
            }
         }
      }
      
      public function isTopLevelPopUp(param1:DisplayObject) : Boolean
      {
         var _loc3_:* = null as DisplayObject;
         var _loc4_:* = null as DisplayObject;
         var _loc2_:* = int(popUps.length) - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = popUps[_loc2_];
            if(_loc3_ == param1)
            {
               return true;
            }
            _loc4_ = _popUpToOverlay[_loc3_];
            if(_loc4_ != null)
            {
               return false;
            }
            _loc2_--;
         }
         return false;
      }
      
      public function isPopUp(param1:DisplayObject) : Boolean
      {
         return int(popUps.indexOf(param1)) != -1;
      }
      
      public function isModal(param1:DisplayObject) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return _popUpToOverlay[param1] != null;
      }
      
      public function hasModalPopUps() : Boolean
      {
         var _loc1_:IMap = _popUpToOverlay;
         var _loc2_:IMap = _loc1_;
         var _loc3_:* = _loc1_.keys();
         return Boolean(_loc3_.hasNext());
      }
      
      public function get_topLevelPopUpCount() : int
      {
         var _loc3_:* = null as DisplayObject;
         var _loc4_:* = null as DisplayObject;
         var _loc1_:int = 0;
         var _loc2_:* = int(popUps.length) - 1;
         while(_loc2_ >= 0)
         {
            _loc1_++;
            _loc3_ = popUps[_loc2_];
            _loc4_ = _popUpToOverlay[_loc3_];
            if(_loc4_ != null)
            {
               return _loc1_;
            }
            _loc2_--;
         }
         return _loc1_;
      }
      
      public function get topLevelPopUpCount() : int
      {
         return get_topLevelPopUpCount();
      }
      
      public function get_root() : DisplayObjectContainer
      {
         return _root;
      }
      
      public function get root() : DisplayObjectContainer
      {
         return get_root();
      }
      
      public function get_popUpCount() : int
      {
         return int(popUps.length);
      }
      
      public function get popUpCount() : int
      {
         return get_popUpCount();
      }
      
      public function get_overlayFactory() : Function
      {
         return _overlayFactory;
      }
      
      public function get overlayFactory() : Function
      {
         return get_overlayFactory();
      }
      
      public function getPopUpAt(param1:int) : DisplayObject
      {
         return popUps[param1];
      }
      
      public function defaultPopUpManager_stage_resizeHandler(param1:Event) : void
      {
         var _loc7_:* = null as DisplayObject;
         var _loc8_:* = null as DisplayObject;
         var _loc2_:Stage = param1.currentTarget;
         var _loc3_:Point = _root.globalToLocal(new Point());
         var _loc4_:Point = _root.globalToLocal(new Point(_loc2_.stageWidth,_loc2_.stageHeight));
         var _loc5_:int = 0;
         var _loc6_:Array = popUps;
         while(_loc5_ < int(_loc6_.length))
         {
            _loc7_ = _loc6_[_loc5_];
            _loc5_++;
            _loc8_ = _popUpToOverlay[_loc7_];
            if(_loc8_ != null)
            {
               _loc8_.x = _loc3_.x;
               _loc8_.y = _loc3_.y;
               _loc8_.width = _loc4_.x - _loc3_.x;
               _loc8_.height = _loc4_.y - _loc3_.y;
            }
         }
         _loc5_ = 0;
         _loc6_ = _centeredPopUps;
         while(_loc5_ < int(_loc6_.length))
         {
            _loc7_ = _loc6_[_loc5_];
            _loc5_++;
            centerPopUp(_loc7_);
         }
      }
      
      public function defaultPopUpManager_popUp_resizeHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget;
         centerPopUp(_loc2_);
      }
      
      public function defaultPopUpManager_popUp_removedFromStageHandler(param1:Event) : void
      {
         if(_ignoreRemoval)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.currentTarget;
         _loc2_.removeEventListener(Event.REMOVED_FROM_STAGE,defaultPopUpManager_popUp_removedFromStageHandler);
         popUps.remove(_loc2_);
         cleanupOverlay(_loc2_);
         if(int(popUps.length) == 0)
         {
            _root.stage.removeEventListener(Event.RESIZE,defaultPopUpManager_stage_resizeHandler);
         }
      }
      
      public function cleanupOverlay(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObject = _popUpToOverlay[param1];
         if(_loc2_ == null)
         {
            return;
         }
         _root.removeChild(_loc2_);
         _popUpToOverlay.remove(param1);
      }
      
      public function centerPopUp(param1:DisplayObject) : void
      {
         if(param1 is IValidating)
         {
            param1.validateNow();
         }
         var _loc2_:Stage = _root.stage;
         var _loc3_:Point = _root.globalToLocal(new Point());
         var _loc4_:Point = _root.globalToLocal(new Point(_loc2_.stageWidth,_loc2_.stageHeight));
         param1.x = _loc3_.x + (_loc4_.x - _loc3_.x - param1.width) / 2;
         param1.y = _loc3_.y + (_loc4_.y - _loc3_.y - param1.height) / 2;
      }
      
      public function addPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = true, param4:Object = undefined) : DisplayObject
      {
         var _loc6_:* = null as DisplayObject;
         var _loc7_:* = null as Stage;
         var _loc8_:* = null as Point;
         var _loc9_:* = null as Point;
         var _loc10_:* = null as IMeasureObject;
         var _loc5_:int = int(popUps.indexOf(param1));
         if(_loc5_ != -1)
         {
            cleanupOverlay(param1);
            popUps.splice(_loc5_,1);
         }
         if(param2)
         {
            if(param4 == null)
            {
               param4 = _overlayFactory;
            }
            if(param4 == null)
            {
               param4 = DefaultPopUpManager.defaultOverlayFactory;
            }
            _loc6_ = param4();
            _loc7_ = _root.stage;
            _loc8_ = _root.globalToLocal(new Point());
            _loc9_ = _root.globalToLocal(new Point(_loc7_.stageWidth,_loc7_.stageHeight));
            _loc6_.x = _loc8_.x;
            _loc6_.y = _loc8_.y;
            _loc6_.width = _loc9_.x - _loc8_.x;
            _loc6_.height = _loc9_.y - _loc8_.y;
            _root.addChild(_loc6_);
            _popUpToOverlay[param1] = _loc6_;
         }
         popUps.push(param1);
         _loc6_ = _root.addChild(param1);
         if(param1.parent == null)
         {
            cleanupOverlay(param1);
            popUps.remove(param1);
            return null;
         }
         param1.addEventListener(Event.REMOVED_FROM_STAGE,defaultPopUpManager_popUp_removedFromStageHandler);
         if(int(popUps.length) == 1)
         {
            _root.stage.addEventListener(Event.RESIZE,defaultPopUpManager_stage_resizeHandler,false,0,true);
         }
         if(param3)
         {
            if(param1 is IMeasureObject)
            {
               _loc10_ = param1;
               _loc10_.addEventListener(Event.RESIZE,defaultPopUpManager_popUp_resizeHandler);
            }
            _centeredPopUps.push(param1);
            centerPopUp(param1);
         }
         return _loc6_;
      }
   }
}

