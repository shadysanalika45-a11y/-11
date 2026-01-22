package feathers.style._ClassVariantStyleProvider
{
   import flash.Boot;
   
   public final class StyleTarget
   {
      
      public static const __isenum:Boolean = true;
      
      public static var __constructs__:Array = ["Class","ClassAndVariant"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function StyleTarget(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function Class(param1:String) : StyleTarget
      {
         return new StyleTarget("Class",0,[param1]);
      }
      
      public static function ClassAndVariant(param1:String, param2:String) : StyleTarget
      {
         return new StyleTarget("ClassAndVariant",1,[param1,param2]);
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

