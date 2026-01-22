package feathers.core
{
   public interface ITextControl extends IUIControl
   {
      
      function set_text(param1:String) : String;
      
      function set text(param1:String) : void;
      
      function get_text() : String;
      
      function get text() : String;
      
      function get_baseline() : Number;
      
      function get baseline() : Number;
   }
}

