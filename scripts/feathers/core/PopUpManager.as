package feathers.core
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import haxe.IMap;
   import haxe.ds.ObjectMap;
   
   public class PopUpManager
   {
      
      public static var popUpManagerFactory:Function;
      
      public static var stageToManager:IMap = new ObjectMap();
      
      public function PopUpManager()
      {
      }
      
      public static function set_root(param1:DisplayObjectContainer) : DisplayObjectContainer
      {
         var _loc2_:IPopUpManager = PopUpManager.forStage(param1.stage);
         _loc2_.set_root(param1);
         return param1;
      }
      
      public static function get_popUpCount() : int
      {
         var _loc3_:* = null as IPopUpManager;
         var _loc1_:* = 0;
         var _loc2_:* = PopUpManager.stageToManager.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            _loc1_ += _loc3_.get_popUpCount();
         }
         return _loc1_;
      }
      
      public static function forStage(param1:Stage) : IPopUpManager
      {
         var _loc3_:* = null as Function;
         if(param1 == null)
         {
            throw new ArgumentError("PopUpManager stage argument must not be null.");
         }
         var _loc2_:IPopUpManager = PopUpManager.stageToManager[param1];
         if(_loc2_ == null)
         {
            _loc3_ = PopUpManager.popUpManagerFactory;
            if(_loc3_ == null)
            {
               _loc3_ = PopUpManager.defaultPopUpManagerFactory;
            }
            _loc2_ = _loc3_(param1);
            PopUpManager.stageToManager[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function dispose() : void
      {
         var _loc2_:* = null as Stage;
         PopUpManager.removeAllPopUps();
         var _loc1_:* = PopUpManager.stageToManager.keys();
         while(_loc1_.hasNext())
         {
            _loc2_ = _loc1_.next();
            PopUpManager.stageToManager.remove(_loc2_);
         }
      }
      
      public static function addPopUp(param1:DisplayObject, param2:DisplayObject, param3:Boolean = true, param4:Boolean = true, param5:Object = undefined) : DisplayObject
      {
         if(param2 == null)
         {
            throw new ArgumentError("The pop-up\'s parent must not be null.");
         }
         var _loc6_:Stage = param2.stage;
         if(_loc6_ == null)
         {
            throw new ArgumentError("The stage property of a pop-up\'s parent must not be null.");
         }
         var _loc7_:IPopUpManager = PopUpManager.forStage(_loc6_);
         return _loc7_.addPopUp(param1,param3,param4,param5);
      }
      
      public static function removePopUp(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:Stage = param1.stage;
         if(_loc2_ == null)
         {
            return param1;
         }
         var _loc3_:IPopUpManager = PopUpManager.forStage(_loc2_);
         return _loc3_.removePopUp(param1);
      }
      
      public static function removeAllPopUps() : void
      {
         var _loc2_:* = null as IPopUpManager;
         var _loc1_:* = PopUpManager.stageToManager.iterator();
         while(_loc1_.hasNext())
         {
            _loc2_ = _loc1_.next();
            _loc2_.removeAllPopUps();
         }
      }
      
      public static function centerPopUp(param1:DisplayObject) : void
      {
         var _loc2_:Stage = param1.stage;
         if(_loc2_ == null)
         {
            throw new ArgumentError("A pop-up\'s stage property must not be null.");
         }
         var _loc3_:IPopUpManager = PopUpManager.forStage(_loc2_);
         _loc3_.centerPopUp(param1);
      }
      
      public static function isPopUp(param1:DisplayObject) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Stage = param1.stage;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IPopUpManager = PopUpManager.forStage(_loc2_);
         return _loc3_.isPopUp(param1);
      }
      
      public static function isModal(param1:DisplayObject) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Stage = param1.stage;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IPopUpManager = PopUpManager.forStage(_loc2_);
         return _loc3_.isModal(param1);
      }
      
      public static function isTopLevelPopUp(param1:DisplayObject) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Stage = param1.stage;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IPopUpManager = PopUpManager.forStage(_loc2_);
         return _loc3_.isTopLevelPopUp(param1);
      }
      
      public static function defaultPopUpManagerFactory(param1:Stage) : IPopUpManager
      {
         return new DefaultPopUpManager(param1);
      }
   }
}

import haxe.ds.ObjectMap;

