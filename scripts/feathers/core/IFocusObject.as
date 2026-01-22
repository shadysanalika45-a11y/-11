package feathers.core
{
   public interface IFocusObject extends IDisplayObject, IFocusManagerAware
   {
      
      function showFocus(param1:Boolean) : void;
      
      function set_focusOwner(param1:IFocusObject) : IFocusObject;
      
      function set focusOwner(param1:IFocusObject) : void;
      
      function set_focusEnabled(param1:Boolean) : Boolean;
      
      function set focusEnabled(param1:Boolean) : void;
      
      function get_focusOwner() : IFocusObject;
      
      function get focusOwner() : IFocusObject;
      
      function get_focusEnabled() : Boolean;
      
      function get focusEnabled() : Boolean;
   }
}

