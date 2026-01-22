package hx
{
   import flash.Boot;
   
   public class Std
   {
      
      public function Std()
      {
      }
      
      public static function string(param1:*) : String
      {
         return Boot.__string_rec(param1,"");
      }
      
      public static function parseInt(param1:String) : Object
      {
         var _loc2_:* = parseInt(param1);
         if(isNaN(_loc2_))
         {
            return null;
         }
         return _loc2_;
      }
   }
}

