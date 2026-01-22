package com.oyunstudyosu.sanalika.interfaces
{
   import flash.display.DisplayObject;
   
   public interface IToolTipModel
   {
      
      function addTip(param1:DisplayObject, param2:String, param3:int = 0) : void;
      
      function removeTip(param1:DisplayObject) : void;
      
      function showTip(param1:DisplayObject, param2:String, param3:int = 0) : void;
   }
}

