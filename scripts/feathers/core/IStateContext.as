package feathers.core
{
   import flash.events.IEventDispatcher;
   
   public interface IStateContext extends IEventDispatcher
   {
      
      function get_currentState() : *;
      
      function get currentState() : *;
   }
}

