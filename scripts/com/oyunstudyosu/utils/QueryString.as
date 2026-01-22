package com.oyunstudyosu.utils
{
   import flash.external.ExternalInterface;
   
   public class QueryString
   {
      
      private var _queryString:String;
      
      private var _all:String;
      
      private var _params:Object;
      
      public function QueryString(param1:String = "")
      {
         super();
         this.readQueryString(param1);
      }
      
      public function get getQueryString() : String
      {
         return this._queryString;
      }
      
      public function get url() : String
      {
         return this._all;
      }
      
      public function get parameters() : Object
      {
         return this._params;
      }
      
      private function readQueryString(param1:String = "") : void
      {
         var allParams:Array = null;
         var i:int = 0;
         var index:int = 0;
         var keyValuePair:String = null;
         var paramKey:String = null;
         var paramValue:String = null;
         var url:String = param1;
         this._params = new Object();
         try
         {
            this._all = url.length > 0 ? url : ExternalInterface.call("window.location.href.toString");
            this._queryString = url.length > 0 ? url.split("?")[1] : ExternalInterface.call("window.location.search.substring",1);
            if(this._queryString)
            {
               allParams = this._queryString.split("&");
               i = 0;
               index = -1;
               while(i < allParams.length)
               {
                  keyValuePair = allParams[i];
                  if((index = int(keyValuePair.indexOf("="))) > 0)
                  {
                     paramKey = keyValuePair.substring(0,index);
                     paramValue = keyValuePair.substring(index + 1);
                     this._params[paramKey] = paramValue;
                  }
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            trace("Some error occured. ExternalInterface doesn\'t work in Standalone player.");
         }
      }
   }
}

