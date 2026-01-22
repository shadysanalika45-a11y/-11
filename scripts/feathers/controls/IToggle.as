package feathers.controls
{
   import feathers.core.IUIControl;
   
   public interface IToggle extends IUIControl
   {
      
      function set_selected(param1:Boolean) : Boolean;
      
      function set selected(param1:Boolean) : void;
      
      function get_selected() : Boolean;
      
      function get selected() : Boolean;
   }
}

