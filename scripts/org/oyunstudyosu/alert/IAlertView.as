package org.oyunstudyosu.alert
{
   import com.oyunstudyosu.alert.IAlertVo;
   import flash.display.MovieClip;
   
   public interface IAlertView
   {
      
      function init() : void;
      
      function get vo() : IAlertVo;
      
      function set vo(param1:IAlertVo) : void;
      
      function dispose() : void;
      
      function dragger() : MovieClip;
   }
}

