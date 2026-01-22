package feathers.layout
{
   import flash.Boot;
   
   public class LayoutBoundsResult
   {
      
      public var viewPortWidth:Number;
      
      public var viewPortHeight:Number;
      
      public var contentY:Number;
      
      public var contentX:Number;
      
      public var contentWidth:Number;
      
      public var contentMinWidth:Number;
      
      public var contentMinHeight:Number;
      
      public var contentMaxWidth:Number;
      
      public var contentMaxHeight:Number;
      
      public var contentHeight:Number;
      
      public function LayoutBoundsResult()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         reset();
      }
      
      public function reset() : void
      {
         contentX = 0;
         contentY = 0;
         contentWidth = 0;
         contentHeight = 0;
         contentMinWidth = 0;
         contentMinHeight = 0;
         contentMaxWidth = 1 / 0;
         contentMaxHeight = 1 / 0;
         viewPortWidth = 0;
         viewPortHeight = 0;
      }
   }
}

