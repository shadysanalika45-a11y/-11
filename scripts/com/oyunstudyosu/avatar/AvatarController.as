package com.oyunstudyosu.avatar
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.door.IDoorVO;
   import com.oyunstudyosu.door.IProperty;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.engine.scene.components.SceneDoorComponent;
   import com.oyunstudyosu.events.CharacterEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OrderEvent;
   import com.oyunstudyosu.events.ProfileEvent;
   import com.oyunstudyosu.events.WalkEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.property.ThrowProperty;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.variables.UserVariable;
   import extensions.admin.Teleportation;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import flash.utils.setInterval;
   
   public class AvatarController
   {
      
      private var handItemProperty:IProperty;
      
      public function AvatarController()
      {
         super();
         Sanalika.instance.serviceModel.listenUserVariable("smiley",onSmileyUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("clothes",onClothesUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("avatarSize",onAvatarSizeUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("avatarName",onUserNameUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("gender",onGenderUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("hand",onHandItemUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("direction",onDirectionUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("position",onPositionUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("speed",onSpeedUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("roles",onAvatarRoleUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("status",onStatusUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("poolVars",onPoolVarsUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("target",onTargetPositionUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("universeKey",currentUniverseUpdate);
         Sanalika.instance.serviceModel.listenUserVariable("fbPermissions",onFbPermission);
         Sanalika.instance.serviceModel.listenUserVariable("tp",onTypingUpdate);
         Sanalika.instance.serviceModel.listenExtension("updateWallet",updateWallet);
         Sanalika.instance.serviceModel.listenExtension("avatarLikeUpdated",avatarLikeUpdated);
         Sanalika.instance.serviceModel.listenExtension("roles",onRoleUpdate);
         Sanalika.instance.serviceModel.listenExtension("moderatorNotice",onModeratorNotice);
         Sanalika.instance.serviceModel.listenExtension("teleport",onTeleport);
         Sanalika.instance.serviceModel.listenExtension("usehanditem",onHandItem);
         Sanalika.instance.serviceModel.listenExtension("throwItem",onThrow);
         Sanalika.instance.serviceModel.listenExtension("throwHit",onHitNotice);
         Sanalika.instance.serviceModel.listenExtension("treasure",onTreasure);
         Sanalika.instance.serviceModel.listenExtension("reLocate",onReLocate);
         Dispatcher.addEventListener("AvatarProfileEvent.SHOW_PROFILE",showProfilePanel);
         Dispatcher.addEventListener("AvatarProfileEvent.BLOCK",blockUser);
         Dispatcher.addEventListener("AvatarProfileEvent.UNBLOCK",unBlockUser);
         Dispatcher.addEventListener("AvatarProfileEvent.DISLIKED",dislikeUser);
         Dispatcher.addEventListener("AvatarProfileEvent.LIKED",likeUser);
         Dispatcher.addEventListener("AvatarProfileEvent.LIKEREMOVED",likeremovedUser);
         Dispatcher.addEventListener("OrderEvent.OPEN_ORDER",openGameOrderRequestPanel);
         Dispatcher.addEventListener("CharacterEvent.CHAR_SIT",onSit);
         Dispatcher.addEventListener("updateWalk",onWalkComplete);
         Sanalika.instance.avatarModel.stepCount = 0;
         Sanalika.instance.avatarModel.giftCount = 0;
         setInterval(ping,60000);
         ThrowProperty;
      }
      
      private function ping() : void
      {
         Sanalika.instance.serviceModel.requestData("ping",{},null);
      }
      
      public function removeHandItemProperty() : void
      {
         if(handItemProperty)
         {
            handItemProperty.dispose();
            handItemProperty = null;
         }
      }
      
      private function onHandItem(param1:Object) : void
      {
         var _loc2_:Class = null;
         if(param1.property)
         {
            try
            {
               _loc2_ = getDefinitionByName("com.oyunstudyosu.property." + param1.property.cn) as Class;
            }
            catch(error:Error)
            {
               trace("No class found named" + param1.property.cn);
               return;
            }
            handItemProperty = new _loc2_();
            handItemProperty.execute();
         }
         else
         {
            removeHandItemProperty();
         }
      }
      
      private function onTeleport(param1:Object) : void
      {
         if(param1.errorCode != undefined)
         {
            Sanalika.instance.roomModel.doorModel.busy = false;
            return;
         }
         Sanalika.instance.roomModel.checkMap(param1);
      }
      
      private function onWalkComplete(param1:WalkEvent = null) : void
      {
         Sanalika.instance.avatarModel.stepCount += int(param1.stepCount * (Math.random() * 5));
         Sanalika.instance.hudModel.setQuestIndicator(Sanalika.instance.avatarModel.stepCount);
      }
      
      protected function onSit(param1:CharacterEvent) : void
      {
         if(Sanalika.instance.roomModel.ownerId != Sanalika.instance.avatarModel.avatarId && Sanalika.instance.roomModel.roomName != null && (Sanalika.instance.roomModel.type == "CAFE" || Sanalika.instance.roomModel.type == "GARAGE"))
         {
            if(Sanalika.instance.orderModel.orderRequest)
            {
               if(Sanalika.instance.orderModel.orderRequest.status != "DELIVERED")
               {
                  Dispatcher.dispatchEvent(new OrderEvent("OrderEvent.OPEN_ORDER"));
               }
            }
         }
      }
      
      protected function openGameOrderRequestPanel(param1:OrderEvent) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "GameOrderRequestPanel";
         _loc2_.params = {};
         _loc2_.params.avatarId = param1.avatarID;
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function updateWallet(param1:Object) : void
      {
         Sanalika.instance.avatarModel.reasonWallet(param1.reason);
         Sanalika.instance.avatarModel.updateWallet(param1.wallet);
      }
      
      private function avatarLikeUpdated(param1:Object) : void
      {
         var _loc2_:ProfileEvent = null;
         if(param1.status == 1)
         {
            _loc2_ = new ProfileEvent("AvatarProfileEvent.LIKED");
            _loc2_.avatarID = param1.avatarID.toString();
            _loc2_.status = param1.status;
            Dispatcher.dispatchEvent(_loc2_);
         }
         else if(param1.status == 0)
         {
            _loc2_ = new ProfileEvent("AvatarProfileEvent.DISLIKED");
            _loc2_.avatarID = param1.avatarID.toString();
            _loc2_.status = param1.status;
            Dispatcher.dispatchEvent(_loc2_);
         }
         else
         {
            _loc2_ = new ProfileEvent("AvatarProfileEvent.LIKEREMOVED");
            _loc2_.avatarID = param1.avatarID.toString();
            _loc2_.status = param1.status;
            Dispatcher.dispatchEvent(_loc2_);
         }
      }
      
      private function blockUser(param1:ProfileEvent) : void
      {
         Sanalika.instance.avatarModel.blockUser(param1.avatarID);
      }
      
      private function unBlockUser(param1:ProfileEvent) : void
      {
         Sanalika.instance.avatarModel.removeBlock(param1.avatarID);
      }
      
      private function dislikeUser(param1:ProfileEvent) : void
      {
         Sanalika.instance.avatarModel.dislikeUser(param1.avatarID);
      }
      
      private function likeUser(param1:ProfileEvent) : void
      {
         Sanalika.instance.avatarModel.likeUser(param1.avatarID);
      }
      
      private function likeremovedUser(param1:ProfileEvent) : void
      {
         Sanalika.instance.avatarModel.likeremovedUser(param1.avatarID);
      }
      
      private function onRoleUpdate(param1:Object) : void
      {
         if(Sanalika.instance.avatarModel.permission.value == param1.roles)
         {
            return;
         }
         Sanalika.instance.avatarModel.permission.value = param1.roles;
         if(Sanalika.instance.avatarModel.permission.check(20))
         {
            new Teleportation("CTRL+SHIFT+Y");
            trace("--------------------TELEPORT--------------------------");
         }
      }
      
      protected function onAvatarRoleUpdate(param1:Object) : void
      {
         var _loc4_:User = param1 as User;
         if(_loc4_ == null)
         {
            return;
         }
         if(Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc4_.name);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.setRoles(_loc4_.getVariable("roles").getStringValue());
      }
      
      protected function onThrow(param1:Object) : void
      {
         trace("movie" + param1.yTarget);
         trace("movie" + param1.xTarget);
         trace("movie" + param1.x);
         trace("movie" + param1.y);
      }
      
      protected function onHitNotice(param1:Object) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = "Hit! " + param1.avatarID;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      protected function onTreasure(param1:Object) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = "Treasure Found! " + param1.avatarID;
         if(param1.giftType == "OBJECT")
         {
            _loc2_.description = $("Treasure Found!") + " " + param1.avatarName + " | " + $("pro_" + param1.clip) + " | " + param1.universe + "@" + param1.room;
         }
         else
         {
            _loc2_.description = $("Treasure Found!") + " " + param1.avatarName + " | " + param1.amount + " " + param1.giftType + " | " + param1.universe + "@" + param1.room;
         }
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      protected function onReLocate(param1:Object) : void
      {
         var _loc2_:SceneCharacterComponent = null;
         var _loc4_:ICharacter = null;
         var _loc3_:String = param1.avatarId.toString();
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc2_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc4_ = _loc2_.getAvatarById(_loc3_);
            if(_loc4_ != null)
            {
               _loc4_.reLocate(param1.x,param1.y,param1.direction);
            }
         }
      }
      
      protected function onModeratorNotice(param1:Object) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "Warning";
         _loc2_.title = "!!! " + $("Warning") + " !!!";
         _loc2_.description = $(param1.message) + "<br> REPID:" + param1.reporterID;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function check(param1:User) : ICharacter
      {
         if(param1 == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return null;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(param1.isItMe)
         {
            return null;
         }
         return _loc2_.getAvatarById(param1.name);
      }
      
      private function checkAll(param1:User) : ICharacter
      {
         if(param1 == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return null;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         return _loc2_.getAvatarById(param1.name);
      }
      
      protected function onFbPermission(param1:Object) : void
      {
         var _loc2_:User = param1 as User;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.isItMe)
         {
            Sanalika.instance.avatarModel.fbPermission = _loc2_.getVariable("fbPermissions").getStringValue();
         }
      }
      
      protected function currentUniverseUpdate(param1:Object) : void
      {
         var _loc2_:User = param1 as User;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.isItMe)
         {
            Sanalika.instance.avatarModel.universe = _loc2_.getVariable("universeKey").getStringValue();
         }
      }
      
      protected function onTargetPositionUpdate(param1:Object) : void
      {
         var _loc12_:Array = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Cell = null;
         var _loc9_:IDoorVO = null;
         var _loc13_:SceneDoorComponent = null;
         var _loc10_:* = null;
         var _loc14_:User = param1 as User;
         if(_loc14_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc3_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc4_:ICharacter = _loc3_.getAvatarById(_loc14_.name);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc7_:UserVariable = _loc14_.getVariable("speed");
         if(_loc7_ != null)
         {
            _loc4_.speed = _loc7_.getDoubleValue();
         }
         var _loc5_:UserVariable = _loc14_.getVariable("target");
         if(_loc5_ != null)
         {
            _loc12_ = _loc5_.getStringValue().split(",");
            if(_loc12_.length == 2)
            {
               _loc11_ = parseInt(_loc12_[0]);
               _loc8_ = parseInt(_loc12_[1]);
               if(_loc14_.isItMe)
               {
                  trace("onTargetPositionUpdate: " + _loc11_ + "," + _loc8_);
                  _loc6_ = Sanalika.instance.engine.scene.getCellAt(_loc11_,0,_loc8_);
                  _loc9_ = Sanalika.instance.roomModel.doorModel.getDoor(_loc11_,_loc8_);
                  if(_loc9_ != null)
                  {
                     _loc13_ = Sanalika.instance.engine.scene.getComponent(SceneDoorComponent) as SceneDoorComponent;
                     _loc10_ = null;
                     if(_loc13_ != null)
                     {
                        for each(var _loc2_ in _loc13_.doorList)
                        {
                           if(_loc2_.name == _loc9_.key)
                           {
                              _loc10_ = _loc2_;
                           }
                        }
                     }
                     _loc4_.walk(_loc11_,_loc8_,_loc10_);
                  }
                  else
                  {
                     _loc4_.walk(_loc11_,_loc8_);
                  }
               }
               else
               {
                  _loc4_.walk(_loc11_,_loc8_);
               }
            }
         }
      }
      
      protected function onPoolVarsUpdate(param1:Object) : void
      {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc2_:GamePool = null;
         var _loc6_:User = param1 as User;
         var _loc3_:ICharacter = check(_loc6_);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:UserVariable = _loc6_.getVariable("poolVars");
         if(_loc4_)
         {
            _loc5_ = _loc4_.getStringValue();
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_.split(",")[0];
               _loc2_ = Sanalika.instance.engine.scene.elementsContainer.getChildByName(_loc7_) as GamePool;
               if(_loc2_ != null)
               {
                  _loc2_.updateItem(_loc6_.name,_loc5_);
               }
            }
         }
      }
      
      protected function onStatusUpdate(param1:Object) : void
      {
         var _loc4_:User = param1 as User;
         if(Sanalika.instance.engine.scene == null)
         {
            return;
         }
         var _loc2_:ICharacter = checkAll(_loc4_);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.action = null;
         var _loc3_:UserVariable = _loc4_.getVariable("status");
         if(_loc3_ != null)
         {
            trace("setDance");
            _loc2_.setAction(_loc3_.getStringValue());
         }
         else
         {
            _loc2_.setAction(null);
         }
      }
      
      protected function onSpeedUpdate(param1:Object) : void
      {
         var _loc5_:User = param1 as User;
         if(_loc5_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc5_.name);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:UserVariable = _loc5_.getVariable("speed");
         if(_loc4_ != null)
         {
         }
      }
      
      protected function onPositionUpdate(param1:Object) : void
      {
         var _loc4_:GameEvent = null;
         var _loc2_:Array = null;
         var _loc7_:User = param1 as User;
         if(_loc7_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc3_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc5_:ICharacter = _loc3_.getAvatarById(_loc7_.name);
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc7_.isItMe)
         {
            _loc4_ = new GameEvent("USER_POSITION_UPDATED");
            _loc4_.id = _loc7_.name;
            Dispatcher.dispatchEvent(_loc4_);
         }
         var _loc6_:UserVariable = _loc7_.getVariable("position");
         if(_loc6_ != null)
         {
            _loc2_ = _loc6_.getStringValue().split(",");
            if(_loc2_.length == 2)
            {
            }
         }
      }
      
      protected function onDirectionUpdate(param1:Object) : void
      {
         var _loc5_:User = param1 as User;
         if(_loc5_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc5_.name);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:UserVariable = _loc5_.getVariable("direction");
         if(_loc4_ != null && (_loc3_.status == "i" || _loc3_.status == "ac"))
         {
            _loc3_.direction = _loc4_.getIntValue();
            _loc3_.setStatus(_loc3_.status,_loc3_.direction);
         }
      }
      
      protected function onHandItemUpdate(param1:Object) : void
      {
         var _loc5_:User = param1 as User;
         if(_loc5_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc5_.name);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:UserVariable = _loc5_.getVariable("hand");
         if(_loc4_ != null)
         {
            _loc3_.useHandItem(_loc4_.getStringValue());
         }
         else
         {
            _loc3_.useHandItem("0");
         }
      }
      
      protected function onGenderUpdate(param1:Object) : void
      {
         var _loc2_:User = param1 as User;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.isItMe)
         {
            Sanalika.instance.avatarModel.gender = _loc2_.getVariable("gender").getStringValue();
         }
      }
      
      protected function showProfilePanel(param1:ProfileEvent) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "ProfilePanel";
         _loc2_.type = "hud";
         _loc2_.params = {};
         _loc2_.params.avatarId = param1.avatarID;
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      protected function onAvatarSizeUpdate(param1:Object) : void
      {
         var _loc4_:User = param1 as User;
         if(_loc4_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(_loc4_.isItMe)
         {
            Sanalika.instance.avatarModel.avatarSize = _loc4_.getVariable("avatarSize").getDoubleValue();
         }
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc4_.name);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.avatarSize = _loc4_.getVariable("avatarSize").getDoubleValue();
      }
      
      protected function onUserNameUpdate(param1:Object) : void
      {
         var _loc3_:User = param1 as User;
         var _loc2_:ICharacter = check(_loc3_);
         if(_loc3_.isItMe)
         {
            Sanalika.instance.avatarModel.avatarName = _loc3_.getVariable("avatarName").getStringValue();
         }
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.avatarName = _loc3_.getVariable("avatarName").getStringValue();
      }
      
      protected function onSmileyUpdate(param1:Object) : void
      {
         var _loc4_:User = param1 as User;
         if(_loc4_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc4_.name);
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc4_.isItMe)
         {
            Sanalika.instance.avatarModel.smileyKey = _loc4_.getVariable("smiley").getStringValue();
         }
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.setSmiley(_loc4_.getVariable("smiley").getStringValue());
      }
      
      protected function onTypingUpdate(param1:Object) : void
      {
         var _loc4_:User = param1 as User;
         if(_loc4_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(_loc4_.name);
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc4_.isItMe)
         {
            Sanalika.instance.avatarModel.tp = _loc4_.getVariable("tp").getValue();
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc4_.getVariable("tp").getValue() == 1)
         {
            _loc3_.tp = 1;
         }
         else
         {
            _loc3_.tp = 0;
         }
      }
      
      protected function onClothesUpdate(param1:Object) : void
      {
         var _loc6_:* = null;
         var _loc7_:User = param1 as User;
         if(_loc7_ == null || Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc4_:ICharacter = _loc2_.getAvatarById(_loc7_.name);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:UserVariable = _loc7_.getVariable("clothes");
         var _loc3_:Array = JSON.parse(_loc5_.getStringValue()) as Array;
         _loc4_.setAccesory(_loc3_);
         if(_loc7_.isItMe)
         {
            Sanalika.instance.avatarModel.clothesOn = _loc3_;
         }
      }
   }
}

