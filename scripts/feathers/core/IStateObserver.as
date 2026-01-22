package feathers.core
{
   public interface IStateObserver
   {
      
      function set_stateContext(param1:IStateContext) : IStateContext;
      
      function set stateContext(param1:IStateContext) : void;
      
      function get_stateContext() : IStateContext;
      
      function get stateContext() : IStateContext;
   }
}

