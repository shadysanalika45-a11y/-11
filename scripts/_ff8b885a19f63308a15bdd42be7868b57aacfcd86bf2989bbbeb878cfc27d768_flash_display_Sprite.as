package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _ff8b885a19f63308a15bdd42be7868b57aacfcd86bf2989bbbeb878cfc27d768_flash_display_Sprite extends Sprite
   {
      
      public function _ff8b885a19f63308a15bdd42be7868b57aacfcd86bf2989bbbeb878cfc27d768_flash_display_Sprite()
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

