package feathers.core
{
   import flash.display.InteractiveObject;
   
   public interface IStageFocusDelegate extends IFocusObject
   {
      
      function get_stageFocusTarget() : InteractiveObject;
      
      function get stageFocusTarget() : InteractiveObject;
   }
}

