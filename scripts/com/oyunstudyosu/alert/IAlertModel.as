package com.oyunstudyosu.alert
{
   public interface IAlertModel
   {
      
      function toObject(param1:IAlertVo) : Object;
      
      function toAlertVo(param1:Object) : IAlertVo;
   }
}

