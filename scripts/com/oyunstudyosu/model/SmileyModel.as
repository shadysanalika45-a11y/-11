package com.oyunstudyosu.model
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.SmileyEvent;
   import com.oyunstudyosu.sanalika.interfaces.ISmileyModel;
   
   public class SmileyModel implements ISmileyModel
   {
      
      private var _list:Array;
      
      public function SmileyModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("smileylist",onSmileyList);
      }
      
      public function get list() : Array
      {
         return _list;
      }
      
      public function set list(param1:Array) : void
      {
         if(_list == param1)
         {
            return;
         }
         _list = param1;
      }
      
      private function onSmileyList(param1:*) : void
      {
         list = param1.smilies;
         Dispatcher.dispatchEvent(new SmileyEvent("SmileyEvent.LIST_UPDATED"));
      }
      
      public function dispose() : void
      {
         Sanalika.instance.serviceModel.removeExtension("smiliesUpdated",onSmileyList);
      }
   }
}

