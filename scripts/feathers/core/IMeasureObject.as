package feathers.core
{
   public interface IMeasureObject extends IDisplayObject
   {
      
      function set_minWidth(param1:Number) : Number;
      
      function set minWidth(param1:Number) : void;
      
      function set_minHeight(param1:Number) : Number;
      
      function set minHeight(param1:Number) : void;
      
      function set_maxWidth(param1:Number) : Number;
      
      function set maxWidth(param1:Number) : void;
      
      function set_maxHeight(param1:Number) : Number;
      
      function set maxHeight(param1:Number) : void;
      
      function resetWidth() : void;
      
      function resetMinWidth() : void;
      
      function resetMinHeight() : void;
      
      function resetMaxWidth() : void;
      
      function resetMaxHeight() : void;
      
      function resetHeight() : void;
      
      function get_minWidth() : Number;
      
      function get minWidth() : Number;
      
      function get_minHeight() : Number;
      
      function get minHeight() : Number;
      
      function get_maxWidth() : Number;
      
      function get maxWidth() : Number;
      
      function get_maxHeight() : Number;
      
      function get maxHeight() : Number;
      
      function get_explicitWidth() : Object;
      
      function get explicitWidth() : Object;
      
      function get_explicitMinWidth() : Object;
      
      function get explicitMinWidth() : Object;
      
      function get_explicitMinHeight() : Object;
      
      function get explicitMinHeight() : Object;
      
      function get_explicitMaxWidth() : Object;
      
      function get explicitMaxWidth() : Object;
      
      function get_explicitMaxHeight() : Object;
      
      function get explicitMaxHeight() : Object;
      
      function get_explicitHeight() : Object;
      
      function get explicitHeight() : Object;
   }
}

