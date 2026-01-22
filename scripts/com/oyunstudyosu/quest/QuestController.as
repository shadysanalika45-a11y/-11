package com.oyunstudyosu.quest
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.core.BotEntry;
   import com.oyunstudyosu.engine.scene.components.SceneBotComponent;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.ground.GroundObject;
   import com.oyunstudyosu.ground.GroundObjectData;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.service.IServiceModel;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.assets.clips.BotQuestIcon;
   
   public class QuestController
   {
      
      private var serviceModel:IServiceModel;
      
      private var questModel:IQuestModel;
      
      private var botList:Array;
      
      private var groundVos:Array;
      
      private var groundObjects:Array;
      
      private var questIcon:BotQuestIcon;
      
      private var questBot:QuestBot;
      
      private var requiredHandItem:String;
      
      private var bot:BotEntry;
      
      private var groundObject:GroundObject;
      
      private var char:ICharacter;
      
      public function QuestController()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
         questModel = Sanalika.instance.questModel;
         botList = [];
         groundVos = [];
         groundObjects = [];
         Dispatcher.addEventListener("TERMINATE_PROVISION",terminateSceneProvision);
         Dispatcher.addEventListener("SCENE_LOADED",sceneLoaded);
         Dispatcher.addEventListener("USER_POSITION_UPDATED",collectGroundObject);
      }
      
      private function terminateSceneProvision(param1:GameEvent) : void
      {
         var _loc2_:SceneBotComponent = null;
         if(Sanalika.instance.engine.scene.existsComponent(SceneBotComponent))
         {
            _loc2_ = Sanalika.instance.engine.scene.getComponent(SceneBotComponent) as SceneBotComponent;
            for each(bot in _loc2_.botList)
            {
               for each(questIcon in bot.questIcons)
               {
                  questIcon.removeEventListener("click",botStepClicked);
                  Sanalika.instance.toolTipModel.removeTip(questIcon);
               }
            }
         }
         botList = [];
         groundVos = [];
         groundObjects = [];
      }
      
      private function collectGroundObject(param1:GameEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Boolean = false;
         if(Sanalika.instance.serviceModel.sfs.mySelf.getVariable("position") == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc3_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc2_:Array = Sanalika.instance.serviceModel.sfs.mySelf.getVariable("position").getStringValue().split(",");
         _loc6_ = 0;
         while(_loc6_ < groundVos.length)
         {
            groundObject = groundObjects[_loc6_] as GroundObject;
            if(groundVos[_loc6_].posX == parseInt(_loc2_[0]) && groundVos[_loc6_].posY == parseInt(_loc2_[1]) || groundObject.container.hitTestObject(_loc3_.myChar.container))
            {
               if(groundObject)
               {
                  if(requiredHandItem)
                  {
                     if(_loc3_.myChar.getHandItem())
                     {
                        if(_loc3_.myChar.getHandItem().clip == Sanalika.instance.avatarModel.gender + "_" + requiredHandItem)
                        {
                           _loc4_ = true;
                        }
                     }
                     if(Sanalika.instance.avatarModel.clothesOn.toString().indexOf(requiredHandItem) > -1)
                     {
                        _loc4_ = true;
                     }
                     if(_loc4_)
                     {
                        serviceModel.requestData("questaction",{"id":groundVos[_loc6_].questID},onOngoingResponse);
                        groundObject.collect();
                        groundVos.splice(_loc6_,1);
                        groundObjects.splice(_loc6_,1);
                        for each(var _loc5_ in groundVos)
                        {
                           trace("x:" + _loc5_.posX + " y:" + _loc5_.posY);
                        }
                        break;
                     }
                     questItemRequired(requiredHandItem);
                  }
               }
            }
            _loc6_++;
         }
      }
      
      protected function questItemGathered(param1:String) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = $("questItemGathered") + ": " + param1;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      protected function questItemCompleted() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "tooltip";
         _loc1_.description = $("questItemCompleted");
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
      
      protected function questItemRequired(param1:String) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = $("questItemRequired") + ": " + $("pro_" + param1);
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      protected function onOngoingResponse(param1:Object) : void
      {
         var _loc2_:String = null;
         serviceModel.removeRequestData("questaction",onOngoingResponse);
         Sanalika.instance.soundModel.playSound("SoundKey.COLLECT",1,1);
         if(param1.curVal != param1.reqVal)
         {
            _loc2_ = param1.curVal + "/" + param1.reqVal;
            if(param1.curVal == 0)
            {
               questItemCompleted();
            }
            else
            {
               questItemGathered(_loc2_);
            }
         }
      }
      
      private function sceneLoaded(param1:GameEvent) : void
      {
         var _loc4_:int = 0;
         getQuestList();
         botList = [];
         groundVos = [];
         groundObjects = [];
         var _loc3_:SceneBotComponent = Sanalika.instance.engine.scene.getComponent(SceneBotComponent) as SceneBotComponent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Array = null;
         if(questModel.questlistroom[Sanalika.instance.roomModel.key])
         {
            _loc2_ = questModel.questlistroom[Sanalika.instance.roomModel.key];
         }
         if(_loc2_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               var _loc5_:* = _loc2_[_loc4_].step.cn;
               if("CollectItemQuestProperty" !== _loc5_)
               {
                  bot = _loc3_.getBotByName(_loc2_[_loc4_].step.botKey);
                  if(bot)
                  {
                     questIcon = new BotQuestIcon();
                     trace("AAAAAABOT" + _loc2_[_loc4_].metaKey);
                     questIcon.name = "questIcon_" + _loc2_[_loc4_].metaKey;
                     questIcon.questID = _loc2_[_loc4_].id;
                     questIcon.metaKey = _loc2_[_loc4_].metaKey;
                     questIcon.buttonMode = true;
                     questIcon.addEventListener("click",botStepClicked);
                     Sanalika.instance.toolTipModel.addTip(questIcon,$("quest_" + _loc2_[_loc4_].metaKey + "_title"));
                     bot.getClip().addChildAt(questIcon,bot.questCount);
                     questIcon.y = -80;
                     questIcon.alpha = 0;
                     bot.questIcons[_loc2_[_loc4_].id] = questIcon;
                     bot.questCount++;
                  }
               }
               else
               {
                  if(_loc2_[_loc4_].step.reqItem)
                  {
                     requiredHandItem = _loc2_[_loc4_].step.reqItem;
                  }
                  addGroundItems(_loc2_[_loc4_].step.groundItem,_loc2_[_loc4_].id);
               }
               _loc4_++;
            }
         }
      }
      
      public function getQuestList() : void
      {
         if(!questModel.questlist && !Sanalika.instance.avatarModel.guest)
         {
            serviceModel.requestData("questlist",{"showDetail":false},onQuestList);
         }
      }
      
      private function onQuestList(param1:*) : void
      {
         serviceModel.removeRequestData("questlist",onQuestList);
         questModel.questlist = param1;
      }
      
      protected function botStepClicked(param1:MouseEvent) : void
      {
         var _loc2_:PanelVO = null;
         param1.stopPropagation();
         if(Sanalika.instance.avatarModel.guest)
         {
            _loc2_ = new PanelVO("GuestPanel");
            Sanalika.instance.panelModel.openPanel(_loc2_);
            return;
         }
         var _loc3_:PanelVO = new PanelVO();
         _loc3_.params = {};
         _loc3_.params.questID = param1.target.questID;
         _loc3_.params.metaKey = param1.target.metaKey;
         trace("Gorev questID : " + _loc3_.params.questID);
         trace("Gorev metaKey : " + _loc3_.params.metaKey);
         switch(_loc3_.params.metaKey)
         {
            case "pinar2018":
               _loc3_.name = "QuestPanelPinar";
               break;
            case "kido201809":
               _loc3_.name = "Kido201809QuestPanel";
               break;
            case "yupoFeed":
            case "yupoGift":
            case "yupoCollect":
            case "yupoStep":
               _loc3_.name = "Yupo2019QuestPanel";
               break;
            case "isbank2019":
               _loc3_.name = "Isbank2019QuestPanel";
               break;
            default:
               _loc3_.name = "QuestPanel";
         }
         _loc3_.type = "core";
         Sanalika.instance.panelModel.openPanel(_loc3_);
      }
      
      private function addGroundItems(param1:Object, param2:String) : void
      {
         var _loc6_:GroundObjectData = null;
         var _loc5_:int = 0;
         var _loc3_:Array = param1.grids;
         var _loc4_:int = Math.random() * _loc3_.length;
         _loc4_ = int(_loc3_.length);
         groundVos = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new GroundObjectData();
            _loc6_.questID = param2;
            _loc6_.posX = _loc3_[_loc5_].x;
            _loc6_.posY = _loc3_[_loc5_].y;
            _loc6_.clip = param1.clip;
            groundVos.push(_loc6_);
            addGroundObject(_loc6_);
            _loc5_++;
         }
      }
      
      private function addBot(param1:IQuestBotVo) : void
      {
         questBot = new QuestBot();
         questBot.initBot(param1);
      }
      
      private function addGroundObject(param1:GroundObjectData) : void
      {
         groundObject = new GroundObject();
         groundObject.init(param1);
         groundObjects.push(groundObject);
      }
   }
}

