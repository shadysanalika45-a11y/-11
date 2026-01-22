package feathers.utils
{
   import flash.display.DisplayObject;
   
   public class DisplayObjectFactory
   {
      
      public var destroy:Function;
      
      public var create:Function;
      
      public function DisplayObjectFactory()
      {
         if(!create)
         {
            create = function():DisplayObject
            {
               return null;
            };
         }
         if(!destroy)
         {
            destroy = function(param1:DisplayObject):void
            {
            };
         }
      }
      
      public static function withDisplayObject(param1:DisplayObject, param2:Object = undefined) : DisplayObjectFactory
      {
         var displayObject:DisplayObject = param1;
         var _loc3_:DisplayObjectFactory = new DisplayObjectFactory();
         _loc3_.create = function():DisplayObject
         {
            return displayObject;
         };
         _loc3_.destroy = param2;
         return _loc3_;
      }
      
      public static function withClass(param1:Class, param2:Object = undefined) : DisplayObjectFactory
      {
         var displayObjectType:Class = param1;
         var _loc3_:DisplayObjectFactory = new DisplayObjectFactory();
         _loc3_.create = function():DisplayObject
         {
            return Type.createInstance(displayObjectType,[]);
         };
         _loc3_.destroy = param2;
         return _loc3_;
      }
      
      public static function withFunction(param1:Function, param2:Object = undefined) : DisplayObjectFactory
      {
         var _loc3_:DisplayObjectFactory = new DisplayObjectFactory();
         _loc3_.create = param1;
         _loc3_.destroy = param2;
         return _loc3_;
      }
   }
}

