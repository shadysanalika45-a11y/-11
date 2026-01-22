package com.oyunstudyosu.roomkick
{
   import com.oyunstudyosu.local.$;
   
   public class KickData
   {
      
      public static const ONCE:KickData = new KickData($("kickOnce"),-1);
      
      public static const ONE_HOUR:KickData = new KickData($("kickOneHour"),3600);
      
      public static const SIX_HOUR:KickData = new KickData($("kickSixHour"),21600);
      
      public static const ONE_DAY:KickData = new KickData($("kickOneDay"),86400);
      
      public static const ONE_WEEK:KickData = new KickData($("kickOneWeek"),604800);
      
      public static const ONE_MONTH:KickData = new KickData($("kickOneMonth"),2592000);
      
      public static const UNLIMITED:KickData = new KickData($("kickUnLimited"),0);
      
      public static const KICK_LIST:Array = [ONCE,ONE_HOUR,SIX_HOUR,ONE_DAY,ONE_WEEK,ONE_MONTH,UNLIMITED];
      
      public var label:String;
      
      public var second:Number;
      
      public function KickData(param1:String, param2:Number)
      {
         super();
         this.label = param1;
         this.second = param2;
      }
   }
}

