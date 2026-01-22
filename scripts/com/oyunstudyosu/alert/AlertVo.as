package com.oyunstudyosu.alert
{
   public class AlertVo implements IAlertVo
   {
      
      private var _data:Object;
      
      private var _title:String;
      
      private var _description:String;
      
      private var _stepperComment:String;
      
      private var _alertType:String;
      
      private var _callBack:Function;
      
      private var _minQuantity:int;
      
      private var _maxQuantity:int;
      
      private var _stepSize:int;
      
      private var _defaultInputMessage:String;
      
      private var _isTransfer:Boolean;
      
      private var _secretSession:String;
      
      private var _panelType:String;
      
      private var _sound:Boolean = false;
      
      public function AlertVo()
      {
         super();
      }
      
      public function get defaultInputMessage() : String
      {
         return this._defaultInputMessage;
      }
      
      public function set defaultInputMessage(param1:String) : void
      {
         this._defaultInputMessage = param1;
      }
      
      public function get stepSize() : int
      {
         return this._stepSize;
      }
      
      public function set stepSize(param1:int) : void
      {
         this._stepSize = param1;
      }
      
      public function get maxQuantity() : int
      {
         return this._maxQuantity;
      }
      
      public function set maxQuantity(param1:int) : void
      {
         this._maxQuantity = param1;
      }
      
      public function get minQuantity() : int
      {
         return this._minQuantity;
      }
      
      public function set minQuantity(param1:int) : void
      {
         this._minQuantity = param1;
      }
      
      public function get callBack() : Function
      {
         return this._callBack;
      }
      
      public function set callBack(param1:Function) : void
      {
         this._callBack = param1;
      }
      
      public function get alertType() : String
      {
         return this._alertType;
      }
      
      public function set alertType(param1:String) : void
      {
         this._alertType = param1;
      }
      
      public function get stepperComment() : String
      {
         return this._stepperComment;
      }
      
      public function set stepperComment(param1:String) : void
      {
         this._stepperComment = param1;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get isTransfer() : Boolean
      {
         return this._isTransfer;
      }
      
      public function set isTransfer(param1:Boolean) : void
      {
         if(this._isTransfer == param1)
         {
            return;
         }
         this._isTransfer = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function get secretSession() : String
      {
         return this._secretSession;
      }
      
      public function set secretSession(param1:String) : void
      {
         if(this._secretSession == param1)
         {
            return;
         }
         this._secretSession = param1;
      }
      
      public function get panelType() : String
      {
         return this._panelType;
      }
      
      public function set panelType(param1:String) : void
      {
         if(this._panelType == param1)
         {
            return;
         }
         this._panelType = param1;
      }
      
      public function get sound() : Boolean
      {
         return this._sound;
      }
      
      public function set sound(param1:Boolean) : void
      {
         if(this._sound == param1)
         {
            return;
         }
         this._sound = param1;
      }
   }
}

