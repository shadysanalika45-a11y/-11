package feathers.controls
{
   import flash.Boot;
   
   public final class ScrollPolicy
   {
      
      public static const __isenum:Boolean = true;
      
      public static var AUTO:ScrollPolicy = new ScrollPolicy("AUTO",2,null);
      
      public static var OFF:ScrollPolicy = new ScrollPolicy("OFF",1,null);
      
      public static var ON:ScrollPolicy = new ScrollPolicy("ON",0,null);
      
      public static var __constructs__:Array = ["ON","OFF","AUTO"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function ScrollPolicy(param1:String, param2:int, param3:Array)
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

