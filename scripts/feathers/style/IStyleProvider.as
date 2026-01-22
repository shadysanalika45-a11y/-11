package feathers.style
{
   import flash.events.IEventDispatcher;
   
   public interface IStyleProvider extends IEventDispatcher
   {
      
      function applyStyles(param1:IStyleObject) : void;
   }
}

