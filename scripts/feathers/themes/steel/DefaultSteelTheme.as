package feathers.themes.steel
{
   import flash.Boot;
   
   public class DefaultSteelTheme extends BaseSteelTheme
   {
      
      public function DefaultSteelTheme(param1:Object = undefined, param2:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
      }
   }
}

