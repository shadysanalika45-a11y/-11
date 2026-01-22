package feathers.layout
{
   import flash.Boot;
   
   public final class RelativePosition
   {
      
      public static const __isenum:Boolean = true;
      
      public static var BOTTOM:RelativePosition = new RelativePosition("BOTTOM",2,null);
      
      public static var LEFT:RelativePosition = new RelativePosition("LEFT",3,null);
      
      public static var MANUAL:RelativePosition = new RelativePosition("MANUAL",4,null);
      
      public static var RIGHT:RelativePosition = new RelativePosition("RIGHT",1,null);
      
      public static var TOP:RelativePosition = new RelativePosition("TOP",0,null);
      
      public static var __constructs__:Array = ["TOP","RIGHT","BOTTOM","LEFT","MANUAL"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function RelativePosition(param1:String, param2:int, param3:Array)
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

