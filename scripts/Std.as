package
{
   import flash.Boot;
   
   public class Std
   {
      
      public function Std()
      {
      }
      
      public static function isOfType(param1:*, param2:*) : Boolean
      {
         return Boot.__instanceof(param1,param2);
      }
      
      public static function string(param1:*) : String
      {
         return Boot.__string_rec(param1,"");
      }
      
      public static function parseFloat(param1:String) : Number
      {
         return parseFloat(param1);
      }
   }
}

