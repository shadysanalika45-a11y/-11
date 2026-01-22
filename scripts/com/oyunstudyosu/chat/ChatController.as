package com.oyunstudyosu.chat
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.auth.Permission;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.timer.SyncTimer;
   import com.oyunstudyosu.utils.NumberUtils;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.data.SFSObject;
   import com.smartfoxserver.v2.requests.PublicMessageRequest;
   import de.polygonal.core.fmt.Sprintf;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import org.oyunstudyosu.complete.AvatarNickCompleteView;
   
   public class ChatController
   {
      
      private var regexp:RegExp = /\s+/g;
      
      private var activeTextField:TextField;
      
      private var newText:String;
      
      private var txtlen:int;
      
      private var completeView:AvatarNickCompleteView;
      
      private var currentScale:Number;
      
      private var user:User;
      
      private var role:String;
      
      private var perm:Permission;
      
      public function ChatController()
      {
         super();
         Dispatcher.addEventListener("tf_focus_in",focusInToCurrentTextField);
         Dispatcher.addEventListener("tf_focus_out",focusOutFromCurrentTextField);
         Dispatcher.addEventListener("sendMessage",sendMessage);
         Sanalika.instance.serviceModel.sfs.addEventListener("publicMessage",onPublicMessage);
         Sanalika.instance.serviceModel.listenExtension("whisper",whisperToUser);
         Sanalika.instance.serviceModel.listenExtension("whispernotify",whisperToAll);
         Dispatcher.addEventListener("RESIZE",onSceneResize);
         completeView = new AvatarNickCompleteView();
         Sanalika.instance.layerModel.hudLayer.addChild(completeView);
         onSceneResize();
      }
      
      private function onSceneResize(param1:GameEvent = null) : void
      {
         currentScale = NumberUtils.setPrecision(Sanalika.instance.layerModel.gameLayer.scaleX,1);
         completeView.x = (Sanalika.instance.gameModel.canvasWidth - completeView.width) * currentScale / 2;
         completeView.y = Sanalika.instance.layerModel.stage.stageHeight - Sanalika.instance.layerModel.hudLayer.y - completeView.height - 110;
      }
      
      private function whisperToAll(param1:Object) : void
      {
         if(param1.errorCode != null)
         {
            return;
         }
         var _loc4_:String = param1.sender;
         var _loc6_:String = param1.receiver;
         var _loc8_:ChatColorTemplate = ChatColorTemplate.DEFAULT;
         if(Sanalika.instance.avatarModel.avatarId == _loc4_ || Sanalika.instance.avatarModel.avatarId == _loc6_)
         {
            return;
         }
         if(Sanalika.instance.avatarModel.isBlocked(_loc4_))
         {
            return;
         }
         if(Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc5_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc7_:ICharacter = _loc5_.getAvatarById(_loc4_);
         var _loc3_:ICharacter = _loc5_.getAvatarById(_loc6_);
         if(_loc7_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc2_:String = Sprintf.format($("whisperToUser"),[_loc3_.avatarName]);
         if(Sanalika.instance.avatarModel.settings.incomingMessages && Sanalika.instance.avatarModel.pero)
         {
            _loc7_.talk(_loc2_,_loc8_.bgFrame,0.8,false);
         }
         Sanalika.instance.chatModel.add(_loc7_,_loc2_,_loc8_.bgFrame,false);
         _loc7_ = null;
         _loc2_ = null;
      }
      
      private function whisperToUser(param1:Object) : void
      {
         var _loc8_:AlertVo = null;
         if(param1.errorCode != null && param1.errorCode != "INSUFFICIENT_ROLE")
         {
            _loc8_ = new AlertVo();
            _loc8_.alertType = "tooltip";
            _loc8_.description = Sanalika.instance.localizationModel.translate(param1.errorCode);
            Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
            return;
         }
         var _loc3_:String = param1.message;
         var _loc2_:String = param1.sender;
         var _loc5_:String = param1.receiver;
         var _loc7_:ChatColorTemplate = ChatColorTemplate.WHISPER;
         if(Sanalika.instance.avatarModel.avatarId != _loc2_ && Sanalika.instance.avatarModel.avatarId != _loc5_)
         {
            return;
         }
         if(Sanalika.instance.avatarModel.isBlocked(_loc2_))
         {
            return;
         }
         _loc3_ = _loc3_.substring(0,100);
         if(_loc3_.length == 0)
         {
            return;
         }
         if(Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc4_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc6_:ICharacter = _loc4_.getAvatarById(_loc2_);
         if(_loc6_ != null)
         {
            if(Sanalika.instance.avatarModel.settings.incomingMessages && Sanalika.instance.avatarModel.pero)
            {
               _loc6_.talk(_loc3_,_loc7_.bgFrame,1);
            }
            Sanalika.instance.chatModel.add(_loc6_,_loc3_,_loc7_.bgFrame);
         }
         _loc6_ = null;
         _loc3_ = null;
      }
      
      private function onPublicMessage(param1:SFSEvent) : void
      {
         var _loc3_:User = param1.params.sender;
         var _loc2_:String = param1.params.message;
         processMessage(_loc3_,_loc2_);
      }
      
      public function processMessage(param1:User, param2:String) : void
      {
         if(Sanalika.instance.engine.scene == null)
         {
            return;
         }
         if(Sanalika.instance.avatarModel.isBlocked(param1.name))
         {
            return;
         }
         incomingMessage(param1,param2);
      }
      
      public function incomingMessage(param1:User, param2:String, param3:Number = 1) : void
      {
         var _loc7_:int = 0;
         var _loc6_:Boolean = false;
         _loc7_ = 1;
         _loc7_ = parseInt(param1.getVariable("chatBalloon").getStringValue());
         param1.getVariable("chatBalloon") != null ? _loc7_ : (_loc7_);
         param2 = param2.substring(0,100);
         if(param2.length == 0)
         {
            return;
         }
         if(Sanalika.instance.engine.scene == null || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc4_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc5_:ICharacter = _loc4_.getAvatarById(param1.name);
         if(_loc5_ != null && !Sanalika.instance.avatarModel.isBlocked(_loc5_.id))
         {
            _loc6_ = _loc5_.permission.check(49);
            if(_loc6_)
            {
               param2 = Sprintf.format(Sanalika.instance.localizationModel.translate(param2),[Sanalika.instance.avatarModel.avatarName]);
            }
            if(Sanalika.instance.avatarModel.settings.incomingMessages && Sanalika.instance.avatarModel.pero)
            {
               _loc5_.talk(param2,_loc7_,param3,!_loc6_);
            }
            if(!_loc6_)
            {
               Sanalika.instance.chatModel.add(_loc5_,param2,_loc7_);
            }
            _loc5_ = null;
         }
      }
      
      private function focusOutFromCurrentTextField(param1:HudEvent) : void
      {
         activeTextField.removeEventListener("textInput",inpTextInput);
         activeTextField.removeEventListener("change",inpChanged);
         completeView.clearAll();
         activeTextField = null;
      }
      
      private function focusInToCurrentTextField(param1:HudEvent) : void
      {
         activeTextField = param1.tf;
         activeTextField.addEventListener("textInput",inpTextInput);
      }
      
      protected function inpChanged(param1:Event) : void
      {
         var _loc4_:String = activeTextField.text;
         var _loc3_:int = _loc4_.length - 1;
         var _loc2_:int = int(_loc4_.indexOf("@"));
         if(_loc2_ > -1)
         {
            onSceneResize();
         }
         else
         {
            completeView.clearAll();
         }
      }
      
      private function inpTextInput(param1:TextEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(!isAvailableText() || !isTypedAvaliable(param1) || param1.text == ">" || param1.text == "<")
         {
            param1.preventDefault();
            return;
         }
         newText = null;
         txtlen = param1.text.length;
         if(newText != null)
         {
            _loc4_ = int(param1.target.caretIndex);
            _loc3_ = param1.target.text;
            _loc2_ = _loc3_.substr(0,_loc4_) + newText + _loc3_.substr(_loc4_,_loc3_.length - _loc4_);
            param1.target.text = _loc2_;
            param1.target.setSelection(_loc4_ + 1,_loc4_ + 1);
         }
      }
      
      protected function isTypedAvaliable(param1:TextEvent) : Boolean
      {
         if(param1.text.length > 1)
         {
            param1.preventDefault();
            return false;
         }
         return true;
      }
      
      private function isAvailableText() : Boolean
      {
         var _loc1_:String = null;
         var _loc5_:int = 0;
         var _loc3_:String = this.activeTextField.text;
         var _loc4_:int = _loc3_.length;
         var _loc2_:int = 1;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc1_ != _loc3_.charAt(_loc5_))
            {
               _loc2_ = 1;
               _loc1_ = _loc3_.charAt(_loc5_);
            }
            else
            {
               _loc2_++;
            }
            if(_loc2_ == 8)
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public function sendMessage(param1:HudEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:String = param1.chatMessage;
         if(_loc2_.indexOf("@") != -1 && completeView.numChildren > 0)
         {
            _loc3_ = int(activeTextField.text.indexOf("@"));
            activeTextField.text = _loc2_.substr(0,_loc3_) + completeView.selectedItem.title + " ";
            activeTextField.setSelection(activeTextField.length,activeTextField.length);
            completeView.clearAll();
            return;
         }
         if(_loc2_.length < 2)
         {
            return;
         }
         send(_loc2_);
         if(activeTextField)
         {
            activeTextField.text = "";
         }
      }
      
      public function send(param1:String) : void
      {
         var _loc2_:ISFSObject = null;
         if(Sanalika.instance.chatModel.whisperMode)
         {
            Sanalika.instance.serviceModel.requestData("whisper",{
               "message":param1,
               "receiver":Sanalika.instance.chatModel.whisperId
            },null);
         }
         else
         {
            _loc2_ = new SFSObject();
            _loc2_.putLong("ts",SyncTimer.timestamp);
            Sanalika.instance.serviceModel.sfs.send(new PublicMessageRequest(param1,_loc2_,Sanalika.instance.roomModel.currentRoom));
         }
      }
   }
}

