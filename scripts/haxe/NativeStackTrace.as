package haxe
{
   public class NativeStackTrace
   {
      
      public function NativeStackTrace()
      {
      }
      
      public static function normalize(param1:String, param2:int = 0) : String
      {
         var _loc3_:String = param1.substring(0,6);
         if(_loc3_ != "Error\n")
         {
            if(_loc3_ == "Error:")
            {
               addr0022:
               param2++;
            }
            return NativeStackTrace.skipLines(param1,param2);
         }
         §§goto(addr0022);
      }
      
      public static function skipLines(param1:String, param2:int, param3:int = 0) : String
      {
         if(param2 > 0)
         {
            param3 = int(param1.indexOf("\n",param3));
            if(param3 < 0)
            {
               return "";
            }
            return NativeStackTrace.skipLines(param1,--param2,param3 + 1);
         }
         return param1.substring(param3);
      }
   }
}

