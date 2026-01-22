package feathers.core
{
   public interface IFocusContainer extends IFocusObject
   {
      
      function set_childFocusEnabled(param1:Boolean) : Boolean;
      
      function set childFocusEnabled(param1:Boolean) : void;
      
      function get_childFocusEnabled() : Boolean;
      
      function get childFocusEnabled() : Boolean;
   }
}

