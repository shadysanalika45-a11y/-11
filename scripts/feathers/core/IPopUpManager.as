package feathers.core
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public interface IPopUpManager
   {
      
      function set_root(param1:DisplayObjectContainer) : DisplayObjectContainer;
      
      function set root(param1:DisplayObjectContainer) : void;
      
      function set_overlayFactory(param1:Function) : Function;
      
      function set overlayFactory(param1:Function) : void;
      
      function removePopUp(param1:DisplayObject) : DisplayObject;
      
      function removeAllPopUps() : void;
      
      function isTopLevelPopUp(param1:DisplayObject) : Boolean;
      
      function isPopUp(param1:DisplayObject) : Boolean;
      
      function isModal(param1:DisplayObject) : Boolean;
      
      function hasModalPopUps() : Boolean;
      
      function get_topLevelPopUpCount() : int;
      
      function get topLevelPopUpCount() : int;
      
      function get_root() : DisplayObjectContainer;
      
      function get root() : DisplayObjectContainer;
      
      function get_popUpCount() : int;
      
      function get popUpCount() : int;
      
      function get_overlayFactory() : Function;
      
      function get overlayFactory() : Function;
      
      function getPopUpAt(param1:int) : DisplayObject;
      
      function centerPopUp(param1:DisplayObject) : void;
      
      function addPopUp(param1:DisplayObject, param2:Boolean = undefined, param3:Boolean = undefined, param4:Object = undefined) : DisplayObject;
   }
}

