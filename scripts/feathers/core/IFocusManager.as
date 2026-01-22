package feathers.core
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   
   public interface IFocusManager extends IEventDispatcher
   {
      
      function set_focus(param1:IFocusObject) : IFocusObject;
      
      function set focus(param1:IFocusObject) : void;
      
      function set_enabled(param1:Boolean) : Boolean;
      
      function set enabled(param1:Boolean) : void;
      
      function get_showFocusIndicator() : Boolean;
      
      function get showFocusIndicator() : Boolean;
      
      function get_root() : DisplayObject;
      
      function get root() : DisplayObject;
      
      function get_focusPane() : DisplayObjectContainer;
      
      function get focusPane() : DisplayObjectContainer;
      
      function get_focus() : IFocusObject;
      
      function get focus() : IFocusObject;
      
      function get_enabled() : Boolean;
      
      function get enabled() : Boolean;
      
      function findNextFocus(param1:Boolean = undefined) : IFocusObject;
      
      function dispose() : void;
   }
}

