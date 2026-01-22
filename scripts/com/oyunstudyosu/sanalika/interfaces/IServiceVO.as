package com.oyunstudyosu.sanalika.interfaces
{
   public interface IServiceVO
   {
      
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get key() : String;
      
      function set key(param1:String) : void;
      
      function get ownerId() : int;
      
      function set ownerId(param1:int) : void;
      
      function get parameters() : Object;
      
      function set parameters(param1:Object) : void;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get responseFunction() : Function;
      
      function set responseFunction(param1:Function) : void;
      
      function get errorFunction() : Function;
      
      function set errorFunction(param1:Function) : void;
      
      function get isPermanent() : Boolean;
      
      function set isPermanent(param1:Boolean) : void;
      
      function get send() : Boolean;
      
      function set send(param1:Boolean) : void;
      
      function dispose() : void;
   }
}

