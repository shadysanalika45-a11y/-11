package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.ban.BanData;
   
   public interface IBanModel
   {
      
      function configBans(param1:Array) : void;
      
      function banned(param1:Object) : void;
      
      function getBanData(param1:String) : BanData;
   }
}

