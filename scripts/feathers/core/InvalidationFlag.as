package feathers.core
{
   import flash.Boot;
   
   public final class InvalidationFlag
   {
      
      public static const __isenum:Boolean = true;
      
      public static var DATA:InvalidationFlag = new InvalidationFlag("DATA",5,null);
      
      public static var FOCUS:InvalidationFlag = new InvalidationFlag("FOCUS",8,null);
      
      public static var LAYOUT:InvalidationFlag = new InvalidationFlag("LAYOUT",4,null);
      
      public static var SCROLL:InvalidationFlag = new InvalidationFlag("SCROLL",6,null);
      
      public static var SELECTION:InvalidationFlag = new InvalidationFlag("SELECTION",7,null);
      
      public static var SIZE:InvalidationFlag = new InvalidationFlag("SIZE",1,null);
      
      public static var SKIN:InvalidationFlag = new InvalidationFlag("SKIN",3,null);
      
      public static var SORT:InvalidationFlag = new InvalidationFlag("SORT",9,null);
      
      public static var STATE:InvalidationFlag = new InvalidationFlag("STATE",0,null);
      
      public static var STYLES:InvalidationFlag = new InvalidationFlag("STYLES",2,null);
      
      public static var __constructs__:Array = ["STATE","SIZE","STYLES","SKIN","LAYOUT","DATA","SCROLL","SELECTION","FOCUS","SORT","CUSTOM"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function InvalidationFlag(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function CUSTOM(param1:String) : InvalidationFlag
      {
         return new InvalidationFlag("CUSTOM",10,[param1]);
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

