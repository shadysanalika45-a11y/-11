package com.oyunstudyosu.sanalika.mock
{
   public interface IExtensionMock
   {
      
      function requestData(param1:String, param2:Object) : Object;
      
      function getInitData() : Object;
      
      function dispatchExtension(param1:uint) : Object;
   }
}

