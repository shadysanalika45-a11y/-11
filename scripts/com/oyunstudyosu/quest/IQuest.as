package com.oyunstudyosu.quest
{
   public interface IQuest
   {
      
      function get id() : String;
      
      function set id(param1:String) : void;
      
      function get questType() : String;
      
      function set questType(param1:String) : void;
      
      function get questID() : String;
      
      function set questID(param1:String) : void;
      
      function get questName() : String;
      
      function set questName(param1:String) : void;
      
      function get questDescription() : String;
      
      function set questDescription(param1:String) : void;
      
      function get detailData() : Object;
      
      function set detailData(param1:Object) : void;
      
      function get active() : Boolean;
      
      function set active(param1:Boolean) : void;
   }
}

