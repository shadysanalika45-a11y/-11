package feathers.layout
{
   import flash.Boot;
   
   public final class AutoSizeMode
   {
      
      public static const __isenum:Boolean = true;
      
      public static var CONTENT:AutoSizeMode = new AutoSizeMode("CONTENT",1,null);
      
      public static var STAGE:AutoSizeMode = new AutoSizeMode("STAGE",0,null);
      
      public static var __constructs__:Array = ["STAGE","CONTENT"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function AutoSizeMode(param1:String, param2:int, param3:Array)
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

