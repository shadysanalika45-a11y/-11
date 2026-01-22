package feathers.layout
{
   import flash.events.IEventDispatcher;
   
   public interface ILayoutObject extends IEventDispatcher
   {
      
      function set_layoutData(param1:ILayoutData) : ILayoutData;
      
      function set layoutData(param1:ILayoutData) : void;
      
      function set_includeInLayout(param1:Boolean) : Boolean;
      
      function set includeInLayout(param1:Boolean) : void;
      
      function get_layoutData() : ILayoutData;
      
      function get layoutData() : ILayoutData;
      
      function get_includeInLayout() : Boolean;
      
      function get includeInLayout() : Boolean;
   }
}

