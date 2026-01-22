package
{
   public class StringTools
   {
      
      public function StringTools()
      {
      }
      
      public static function startsWith(param1:String, param2:String) : Boolean
      {
         if(param1.length >= param2.length)
         {
            return int(param1.lastIndexOf(param2,0)) == 0;
         }
         return false;
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         var _loc3_:int = param2.length;
         var _loc4_:int = param1.length;
         if(_loc4_ >= _loc3_)
         {
            return int(param1.indexOf(param2,_loc4_ - _loc3_)) == _loc4_ - _loc3_;
         }
         return false;
      }
      
      public static function lpad(param1:String, param2:String, param3:int) : String
      {
         if(param2.length <= 0)
         {
            return param1;
         }
         var _loc4_:String = "";
         param3 -= param1.length;
         while(_loc4_.length < param3)
         {
            _loc4_ += Std.string(param2);
         }
         return _loc4_ + Std.string(param1);
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function hex(param1:int, param2:Object = undefined) : String
      {
         var _loc3_:uint = uint(param1);
         var _loc4_:String = _loc3_.toString(16);
         _loc4_ = _loc4_.toUpperCase();
         if(param2 != null)
         {
            while(_loc4_.length < param2)
            {
               _loc4_ = "0" + _loc4_;
            }
         }
         return _loc4_;
      }
   }
}

