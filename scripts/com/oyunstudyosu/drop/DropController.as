package com.oyunstudyosu.drop
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.ground.GroundObject;
   import com.oyunstudyosu.ground.GroundObjectData;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.service.IServiceModel;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.variables.RoomVariable;
   
   public class DropController
   {
      
      private var serviceModel:IServiceModel;
      
      private var groundObject:GroundObject;
      
      private var groundVos:Array;
      
      private var groundObjects:Array;
      
      private var requiredHandItem:String;
      
      public function DropController()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
         Dispatcher.addEventListener("TERMINATE_SCENE",terminateScene);
         Dispatcher.addEventListener("SCENE_LOADED",sceneLoaded);
         Sanalika.instance.serviceModel.listenUserVariable("position",onPositionUpdate);
         Sanalika.instance.serviceModel.listenExtension("dropRemoveItem",removeItem);
         Sanalika.instance.serviceModel.listenExtension("dropItem",addItem);
         groundVos = [];
         groundObjects = [];
      }
      
      private function terminateScene(param1:GameEvent) : void
      {
         groundVos = [];
         groundObjects = [];
      }
      
      private function onPositionUpdate(param1:Object) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:User = param1 as User;
         if(_loc5_.getVariable("position") == null || !_loc5_.isItMe)
         {
            return;
         }
         var _loc3_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc2_:Array = _loc5_.getVariable("position").getStringValue().split(",");
         trace("--------------",_loc2_[0],_loc2_[1]);
         _loc6_ = 0;
         while(_loc6_ < groundVos.length)
         {
            groundObject = groundObjects[_loc6_] as GroundObject;
            if(groundVos[_loc6_].posX == parseInt(_loc2_[0]) && groundVos[_loc6_].posY == parseInt(_loc2_[1]))
            {
               trace("GROUND_OBJ hitTestObject");
               if(groundObject)
               {
                  trace("GROUND_OBJEEE",groundObject.id);
                  if(groundVos[_loc6_].requiredItemClip != null)
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
                     if(!_loc4_)
                     {
                        itemRequired(requiredHandItem);
                        break;
                     }
                  }
                  serviceModel.requestData("drop",{"type":"COLLECT"},onDropResponse);
                  break;
               }
            }
            _loc6_++;
         }
      }
      
      protected function onDropResponse(param1:Object) : void
      {
         trace("onDropResponse");
         serviceModel.removeRequestData("drop",onDropResponse);
         Sanalika.instance.soundModel.playSound("SoundKey.COLLECT",1,1);
         itemGathered();
      }
      
      protected function addItem(param1:Object) : void
      {
         addDrop(param1.x,param1.y,param1.clip);
      }
      
      protected function removeItem(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GroundObjectData = null;
         _loc3_ = 0;
         while(_loc3_ < groundVos.length)
         {
            _loc2_ = groundVos[_loc3_];
            if(param1.x == _loc2_.posX && param1.y == _loc2_.posY && param1.clip == _loc2_.clip)
            {
               groundObject = groundObjects[_loc3_] as GroundObject;
               groundObject.collect();
               groundVos.splice(_loc3_,1);
               groundObjects.splice(_loc3_,1);
               trace("removed from scene");
               break;
            }
            _loc3_++;
         }
      }
      
      protected function itemRequired(param1:String) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = $("itemRequired") + ": " + $("pro_" + param1);
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      protected function itemGathered() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "tooltip";
         _loc1_.description = $("itemCollected");
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
      
      protected function itemCompleted() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "tooltip";
         _loc1_.description = $("itemCompleted");
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
      
      private function sceneLoaded(param1:GameEvent) : void
      {
         var _loc3_:RoomVariable = Sanalika.instance.roomModel.currentRoom.getVariable("drop");
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Object = JSON.parse(_loc3_.getStringValue());
         for each(var _loc4_ in _loc2_)
         {
            addDrop(_loc4_.x,_loc4_.y,_loc4_.clip);
         }
      }
      
      private function addDrop(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:GroundObjectData = null;
         _loc4_ = new GroundObjectData();
         _loc4_.questID = "0";
         _loc4_.posX = param1;
         _loc4_.posY = param2;
         _loc4_.clip = param3;
         trace("x" + _loc4_.posX + " " + _loc4_.posY);
         processGroundObject(_loc4_);
         groundVos.push(_loc4_);
      }
      
      private function addGroundItems(param1:Object, param2:String) : void
      {
         var _loc7_:GroundObjectData = null;
         var _loc6_:int = 0;
         var _loc5_:Array = null;
         var _loc3_:Array = param1.grids;
         var _loc4_:int = Math.random() * _loc3_.length;
         _loc4_ = int(_loc3_.length);
         groundVos = [];
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = String(_loc3_[_loc6_]).split(",");
            _loc7_ = new GroundObjectData();
            _loc7_.questID = param2;
            _loc7_.posX = _loc5_[0];
            _loc7_.posY = _loc5_[1];
            _loc7_.clip = param1.clip;
            trace("x" + _loc7_.posX + " " + _loc7_.posY);
            groundVos.push(_loc7_);
            addGroundObject(_loc7_);
            _loc6_++;
         }
      }
      
      private function addGroundObject(param1:GroundObjectData) : void
      {
         groundObject = new GroundObject();
         groundObject.init(param1);
         groundObjects.push(groundObject);
      }
      
      private function processGroundObject(param1:GroundObjectData) : void
      {
         if(Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(_loc2_.myChar == null || _loc2_.myChar.container == null)
         {
            groundVos.push(param1);
         }
         else
         {
            addGroundObject(param1);
         }
      }
   }
}

