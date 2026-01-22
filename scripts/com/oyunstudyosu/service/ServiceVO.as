package com.oyunstudyosu.service
{
   import com.oyunstudyosu.sanalika.interfaces.IServiceVO;
   
   public class ServiceVO implements IServiceVO
   {
      
      private var _type:String;
      
      private var _key:String;
      
      private var _ownerId:int;
      
      private var _data:Object;
      
      private var _parameters:Object;
      
      private var _responseFunction:Function;
      
      private var _errorFunction:Function;
      
      private var _isPermanent:Boolean;
      
      private var _send:Boolean;
      
      public function ServiceVO()
      {
         super();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function set key(param1:String) : void
      {
         if(this._key == param1)
         {
            return;
         }
         this._key = param1;
      }
      
      public function get ownerId() : int
      {
         return this._ownerId;
      }
      
      public function set ownerId(param1:int) : void
      {
         if(this._ownerId == param1)
         {
            return;
         }
         this._ownerId = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
      }
      
      public function get parameters() : Object
      {
         return this._parameters;
      }
      
      public function set parameters(param1:Object) : void
      {
         if(this._parameters == param1)
         {
            return;
         }
         this._parameters = param1;
      }
      
      public function get responseFunction() : Function
      {
         return this._responseFunction;
      }
      
      public function set responseFunction(param1:Function) : void
      {
         if(this._responseFunction == param1)
         {
            return;
         }
         this._responseFunction = param1;
      }
      
      public function get errorFunction() : Function
      {
         return this._errorFunction;
      }
      
      public function set errorFunction(param1:Function) : void
      {
         if(this._errorFunction == param1)
         {
            return;
         }
         this._errorFunction = param1;
      }
      
      public function get isPermanent() : Boolean
      {
         return this._isPermanent;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         if(this._isPermanent == param1)
         {
            return;
         }
         this._isPermanent = param1;
      }
      
      public function get send() : Boolean
      {
         return this._send;
      }
      
      public function set send(param1:Boolean) : void
      {
         if(this._send == param1)
         {
            return;
         }
         this._send = param1;
      }
      
      public function dispose() : void
      {
         this._errorFunction = null;
         this._responseFunction = null;
         this._data = null;
         this._parameters = null;
      }
   }
}

