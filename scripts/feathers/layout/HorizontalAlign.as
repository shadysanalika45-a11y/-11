package feathers.layout
{
   import flash.Boot;
   
   public final class HorizontalAlign
   {
      
      public static const __isenum:Boolean = true;
      
      public static var CENTER:HorizontalAlign = new HorizontalAlign("CENTER",1,null);
      
      public static var JUSTIFY:HorizontalAlign = new HorizontalAlign("JUSTIFY",3,null);
      
      public static var LEFT:HorizontalAlign = new HorizontalAlign("LEFT",0,null);
      
      public static var RIGHT:HorizontalAlign = new HorizontalAlign("RIGHT",2,null);
      
      public static var __constructs__:Array = ["LEFT","CENTER","RIGHT","JUSTIFY"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function HorizontalAlign(param1:String, param2:int, param3:Array)
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

