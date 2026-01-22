package feathers.core
{
   public interface IUIControl extends IDisplayObject
   {
      
      function set_toolTip(param1:String) : String;
      
      function set toolTip(param1:String) : void;
      
      function set_enabled(param1:Boolean) : Boolean;
      
      function set enabled(param1:Boolean) : void;
      
      function initializeNow() : void;
      
      function get_toolTip() : String;
      
      function get toolTip() : String;
      
      function get_enabled() : Boolean;
      
      function get enabled() : Boolean;
   }
}

