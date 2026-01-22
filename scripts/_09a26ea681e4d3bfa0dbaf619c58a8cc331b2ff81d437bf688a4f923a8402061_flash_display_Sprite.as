package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _09a26ea681e4d3bfa0dbaf619c58a8cc331b2ff81d437bf688a4f923a8402061_flash_display_Sprite extends Sprite
   {
      
      public function _09a26ea681e4d3bfa0dbaf619c58a8cc331b2ff81d437bf688a4f923a8402061_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}

