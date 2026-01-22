package com.oyunstudyosu.quest
{
   import flash.utils.Dictionary;
   
   public interface IQuestModel
   {
      
      function get questlistroom() : Dictionary;
      
      function get questlist() : Object;
      
      function set questlist(param1:Object) : void;
   }
}

