package feathers.layout
{
   import flash.events.IEventDispatcher;
   
   public interface ILayout extends IEventDispatcher
   {
      
      function layout(param1:Array, param2:Measurements, param3:LayoutBoundsResult = undefined) : LayoutBoundsResult;
   }
}

