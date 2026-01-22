package feathers.controls
{
   import feathers.core.IUIControl;
   
   public interface IRange extends IUIControl
   {
      
      function set_value(param1:Number) : Number;
      
      function set value(param1:Number) : void;
      
      function set_minimum(param1:Number) : Number;
      
      function set minimum(param1:Number) : void;
      
      function set_maximum(param1:Number) : Number;
      
      function set maximum(param1:Number) : void;
      
      function get_value() : Number;
      
      function get value() : Number;
      
      function get_minimum() : Number;
      
      function get minimum() : Number;
      
      function get_maximum() : Number;
      
      function get maximum() : Number;
   }
}

