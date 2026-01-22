package feathers.core._FeathersControl
{
   import flash.Boot;
   
   public final class StyleDefinition
   {
      
      public static const __isenum:Boolean = true;
      
      public static var __constructs__:Array = ["Name","NameAndState"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function StyleDefinition(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function Name(param1:String) : StyleDefinition
      {
         return new StyleDefinition("Name",0,[param1]);
      }
      
      public static function NameAndState(param1:String, param2:Object) : StyleDefinition
      {
         return new StyleDefinition("NameAndState",1,[param1,param2]);
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

