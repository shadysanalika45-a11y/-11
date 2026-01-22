package feathers.layout._AnchorLayout
{
   import feathers.layout.Anchor;
   import flash.display.DisplayObject;
   
   public final class AbstractAnchor_Impl_
   {
      
      public function AbstractAnchor_Impl_()
      {
      }
      
      public static function fromPixels(param1:Number) : Anchor
      {
         return new Anchor(param1);
      }
      
      public static function fromDisplayObject(param1:DisplayObject) : Anchor
      {
         return new Anchor(0,param1);
      }
   }
}

