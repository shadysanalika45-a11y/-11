package feathers.controls.supportClasses
{
   import feathers.core.IMeasureObject;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   
   public interface IViewPort extends IMeasureObject, IValidating, IUIControl
   {
      
      function set_visibleWidth(param1:Object) : Object;
      
      function set visibleWidth(param1:Object) : void;
      
      function set_visibleHeight(param1:Object) : Object;
      
      function set visibleHeight(param1:Object) : void;
      
      function set_scrollY(param1:Number) : Number;
      
      function set scrollY(param1:Number) : void;
      
      function set_scrollX(param1:Number) : Number;
      
      function set scrollX(param1:Number) : void;
      
      function set_minVisibleWidth(param1:Object) : Object;
      
      function set minVisibleWidth(param1:Object) : void;
      
      function set_minVisibleHeight(param1:Object) : Object;
      
      function set minVisibleHeight(param1:Object) : void;
      
      function set_maxVisibleWidth(param1:Object) : Object;
      
      function set maxVisibleWidth(param1:Object) : void;
      
      function set_maxVisibleHeight(param1:Object) : Object;
      
      function set maxVisibleHeight(param1:Object) : void;
      
      function get_visibleWidth() : Object;
      
      function get visibleWidth() : Object;
      
      function get_visibleHeight() : Object;
      
      function get visibleHeight() : Object;
      
      function get_scrollY() : Number;
      
      function get scrollY() : Number;
      
      function get_scrollX() : Number;
      
      function get scrollX() : Number;
      
      function get_minVisibleWidth() : Object;
      
      function get minVisibleWidth() : Object;
      
      function get_minVisibleHeight() : Object;
      
      function get minVisibleHeight() : Object;
      
      function get_maxVisibleWidth() : Object;
      
      function get maxVisibleWidth() : Object;
      
      function get_maxVisibleHeight() : Object;
      
      function get maxVisibleHeight() : Object;
   }
}

