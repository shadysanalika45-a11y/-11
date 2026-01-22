package feathers.graphics
{
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public final class LineStyle
   {
      
      public static const __isenum:Boolean = true;
      
      public static var None:LineStyle = new LineStyle("None",3,null);
      
      public static var __constructs__:Array = ["SolidColor","Bitmap","Gradient","None"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function LineStyle(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function Bitmap(param1:Number, param2:BitmapData, param3:Matrix = undefined, param4:Object = undefined, param5:Object = undefined) : LineStyle
      {
         return new LineStyle("Bitmap",1,[param1,param2,param3,param4,param5]);
      }
      
      public static function Gradient(param1:Number, param2:String, param3:Array, param4:Array, param5:Array, param6:Object = undefined, param7:String = undefined, param8:String = undefined, param9:Object = undefined) : LineStyle
      {
         return new LineStyle("Gradient",2,[param1,param2,param3,param4,param5,param6,param7,param8,param9]);
      }
      
      public static function SolidColor(param1:Object = undefined, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined, param5:String = undefined, param6:String = undefined, param7:String = undefined, param8:Object = undefined) : LineStyle
      {
         return new LineStyle("SolidColor",0,[param1,param2,param3,param4,param5,param6,param7,param8]);
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

