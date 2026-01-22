package feathers.skins
{
   import feathers.controls.IToggle;
   import feathers.core.IStateContext;
   import feathers.core.IStateObserver;
   import feathers.core.IUIControl;
   import feathers.core.InvalidationFlag;
   import feathers.core.MeasureSprite;
   import feathers.events.FeathersEvent;
   import flash.Boot;
   import flash.events.Event;
   
   public class ProgrammaticSkin extends MeasureSprite implements IStateObserver, IProgrammaticSkin
   {
      
      public var _uiContext:IUIControl;
      
      public var _stateContext:IStateContext;
      
      public function ProgrammaticSkin()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         mouseChildren = false;
         tabEnabled = false;
         tabChildren = false;
      }
      
      override public function update() : void
      {
      }
      
      public function uiContext_stateChangeHandler(param1:FeathersEvent) : void
      {
         checkForStateChange();
      }
      
      public function uiContextToggle_changeHandler(param1:Event) : void
      {
         checkForStateChange();
      }
      
      public function stateContext_stateChangeHandler(param1:FeathersEvent) : void
      {
         checkForStateChange();
      }
      
      public function stateContextToggle_changeHandler(param1:Event) : void
      {
         checkForStateChange();
      }
      
      public function set_uiContext(param1:IUIControl) : IUIControl
      {
         if(_uiContext == param1)
         {
            return _uiContext;
         }
         if(_uiContext != null)
         {
            _uiContext.removeEventListener("stateChange",uiContext_stateChangeHandler);
            if(_uiContext is IToggle)
            {
               _uiContext.removeEventListener(Event.CHANGE,uiContextToggle_changeHandler);
            }
            onRemoveUIContext();
         }
         _uiContext = param1;
         if(_uiContext != null)
         {
            _uiContext.addEventListener("stateChange",uiContext_stateChangeHandler,false,0,true);
            if(_uiContext is IToggle)
            {
               _uiContext.addEventListener(Event.CHANGE,uiContextToggle_changeHandler);
            }
            onAddUIContext();
         }
         setInvalid(InvalidationFlag.DATA);
         return _uiContext;
      }
      
      public function set uiContext(param1:IUIControl) : void
      {
         set_uiContext(param1);
      }
      
      public function set_stateContext(param1:IStateContext) : IStateContext
      {
         if(_stateContext == param1)
         {
            return _stateContext;
         }
         if(_stateContext != null)
         {
            _stateContext.removeEventListener("stateChange",stateContext_stateChangeHandler);
         }
         _stateContext = param1;
         if(_stateContext != null)
         {
            _stateContext.addEventListener("stateChange",stateContext_stateChangeHandler,false,0,true);
         }
         setInvalid(InvalidationFlag.DATA);
         return _stateContext;
      }
      
      public function set stateContext(param1:IStateContext) : void
      {
         set_stateContext(param1);
      }
      
      public function onRemoveUIContext() : void
      {
      }
      
      public function onAddUIContext() : void
      {
      }
      
      public function needsStateUpdate() : Boolean
      {
         return true;
      }
      
      public function get_uiContext() : IUIControl
      {
         return _uiContext;
      }
      
      public function get uiContext() : IUIControl
      {
         return get_uiContext();
      }
      
      public function get_stateContext() : IStateContext
      {
         return _stateContext;
      }
      
      public function get stateContext() : IStateContext
      {
         return get_stateContext();
      }
      
      public function checkForStateChange() : void
      {
         if(!needsStateUpdate())
         {
            return;
         }
         setInvalid(InvalidationFlag.STATE);
      }
   }
}

