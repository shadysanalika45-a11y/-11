package feathers.graphics
{
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public final class FillStyle
   {
      
      public static const __isenum:Boolean = true;
      
      public static var None:FillStyle = new FillStyle("None",3,null);
      
      public static var __constructs__:Array = ["SolidColor","Bitmap","Gradient","None"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function FillStyle(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function Bitmap(param1:BitmapData, param2:Matrix = undefined, param3:Object = undefined, param4:Object = undefined) : FillStyle
      {
         return new FillStyle("Bitmap",1,[param1,param2,param3,param4]);
      }
      
      public static function Gradient(param1:String, param2:Array, param3:Array, param4:Array, param5:Object = undefined, param6:String = undefined, param7:String = undefined, param8:Object = undefined) : FillStyle
      {
         return new FillStyle("Gradient",2,[param1,param2,param3,param4,param5,param6,param7,param8]);
      }
      
      public static function SolidColor(param1:int, param2:Object = undefined) : FillStyle
      {
         return new FillStyle("SolidColor",0,[param1,param2]);
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

