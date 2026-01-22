package feathers.controls
{
   public interface IScrollBar extends IRange
   {
      
      function set_step(param1:Number) : Number;
      
      function set step(param1:Number) : void;
      
      function set_page(param1:Number) : Number;
      
      function set page(param1:Number) : void;
      
      function get_step() : Number;
      
      function get step() : Number;
      
      function get_page() : Number;
      
      function get page() : Number;
   }
}

