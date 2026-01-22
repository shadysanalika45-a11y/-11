package com.oyunstudyosu.quest
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.QuestEvent;
   import com.oyunstudyosu.local.$;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class QuestModel implements IQuestModel
   {
      
      private var _questlist:Object;
      
      private var _questlistroom:Dictionary = new Dictionary();
      
      public function QuestModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("questlistroom",onQuestListRoom);
         Sanalika.instance.serviceModel.listenExtension("queststepcomplete",onQuestStepComplete);
         Sanalika.instance.serviceModel.listenExtension("questcomplete",onQuestComplete);
      }
      
      public function get questlist() : Object
      {
         return _questlist;
      }
      
      public function set questlist(param1:Object) : void
      {
         _questlist = param1;
      }
      
      public function get questlistroom() : Dictionary
      {
         return _questlistroom;
      }
      
      private function onTerminateGame(param1:*) : void
      {
         trace("onTerminateGame questlistroom ");
         _questlistroom = null;
      }
      
      private function onQuestListRoom(param1:*) : void
      {
         questlistroom[param1.quests[0].roomKey] = param1.quests;
         Dispatcher.dispatchEvent(new QuestEvent("QuestEvent.QUEST_LIST_ROOM_READY"));
         setTimeout(showAlert,200);
      }
      
      private function showAlert() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "tooltip";
         _loc1_.description = $("questAlert");
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
      
      private function clearQuest(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = questlistroom[Sanalika.instance.roomModel.key];
         if(_loc2_)
         {
            trace("mylist",JSON.stringify(_loc2_));
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_]["metaKey"] == param1)
               {
                  _loc2_.splice(_loc2_.indexOf(_loc3_),1);
                  break;
               }
               _loc3_++;
            }
            questlistroom[Sanalika.instance.roomModel.key] = _loc2_;
            _loc2_ = null;
         }
      }
      
      private function onQuestStepComplete(param1:*) : void
      {
         var _loc2_:String = param1.id;
         if(param1.metaKey == "yupoStep" || param1.metaKey == "yupoGift")
         {
            return;
         }
         Dispatcher.dispatchEvent(new QuestEvent("QuestEvent.QUEST_ACTION"));
         var _loc3_:AlertVo = new AlertVo();
         _loc3_.alertType = "tooltip";
         _loc3_.description = $("questStepCompleted") + " " + $("questNextRoom") + ": " + $("room_" + param1.nextRoom);
         Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
         clearQuest(param1.metaKey);
      }
      
      private function onQuestComplete(param1:*) : void
      {
         var _loc2_:String = param1.id;
         Dispatcher.dispatchEvent(new QuestEvent("QuestEvent.QUEST_ACTION"));
         Dispatcher.dispatchEvent(new QuestEvent("QuestEvent.QUEST_COMPLETED"));
         clearQuest(param1.metaKey);
      }
      
      public function dispose() : void
      {
         Sanalika.instance.serviceModel.removeExtension("questlistroom",onQuestListRoom);
         Sanalika.instance.serviceModel.removeExtension("questcomplete",onQuestComplete);
      }
   }
}

