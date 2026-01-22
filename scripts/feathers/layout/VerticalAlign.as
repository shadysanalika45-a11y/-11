package feathers.layout
{
   import flash.Boot;
   
   public final class VerticalAlign
   {
      
      public static const __isenum:Boolean = true;
      
      public static var BOTTOM:VerticalAlign = new VerticalAlign("BOTTOM",2,null);
      
      public static var JUSTIFY:VerticalAlign = new VerticalAlign("JUSTIFY",3,null);
      
      public static var MIDDLE:VerticalAlign = new VerticalAlign("MIDDLE",1,null);
      
      public static var TOP:VerticalAlign = new VerticalAlign("TOP",0,null);
      
      public static var __constructs__:Array = ["TOP","MIDDLE","BOTTOM","JUSTIFY"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function VerticalAlign(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

