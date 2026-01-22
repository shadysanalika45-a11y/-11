package com.oyunstudyosu.alert
{
   public interface IAlertVo
   {
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get defaultInputMessage() : String;
      
      function set defaultInputMessage(param1:String) : void;
      
      function get stepSize() : int;
      
      function set stepSize(param1:int) : void;
      
      function get maxQuantity() : int;
      
      function set maxQuantity(param1:int) : void;
      
      function get minQuantity() : int;
      
      function set minQuantity(param1:int) : void;
      
      function get callBack() : Function;
      
      function set callBack(param1:Function) : void;
      
      function get alertType() : String;
      
      function set alertType(param1:String) : void;
      
      function get stepperComment() : String;
      
      function set stepperComment(param1:String) : void;
      
      function get description() : String;
      
      function set description(param1:String) : void;
      
      function get isTransfer() : Boolean;
      
      function set isTransfer(param1:Boolean) : void;
      
      function get title() : String;
      
      function set title(param1:String) : void;
      
      function get secretSession() : String;
      
      function set secretSession(param1:String) : void;
      
      function get panelType() : String;
      
      function set panelType(param1:String) : void;
   }
}

