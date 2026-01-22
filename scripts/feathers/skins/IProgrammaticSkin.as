package feathers.skins
{
   import feathers.core.IMeasureObject;
   import feathers.core.IUIControl;
   
   public interface IProgrammaticSkin extends IMeasureObject
   {
      
      function set_uiContext(param1:IUIControl) : IUIControl;
      
      function set uiContext(param1:IUIControl) : void;
      
      function get_uiContext() : IUIControl;
      
      function get uiContext() : IUIControl;
   }
}

