package com.oyunstudyosu.panel
{
   public class PanelVO
   {
      
      private var _name:String;
      
      private var _type:String = "core";
      
      private var _params:Object;
      
      public var _isPermanent:Boolean = false;
      
      public function PanelVO(param1:String = null, param2:String = null, param3:Object = null)
      {
         super();
         this._name = param1;
         this._type = param2;
         this._params = param3;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         if(this._name == param1)
         {
            return;
         }
         this._name = param1;
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
      
      public function get params() : Object
      {
         return this._params;
      }
      
      public function set params(param1:Object) : void
      {
         this._params = param1;
      }
      
      public function get isPermanent() : Boolean
      {
         return this._isPermanent;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         this._isPermanent = param1;
      }
   }
}

