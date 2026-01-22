package extensions.notification
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.colors.RoomMessageColor;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.utils.StringUtil;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.oyunstudyosu.assets.clips.BotMessageUI;
   
   public class UserRoomMessage extends BotMessage
   {
      
      public var character:ICharacter;
      
      public function UserRoomMessage()
      {
         super();
      }
      
      override public function init() : void
      {
         var colorSet:RoomMessageColor;
         var Background:String;
         var TimerProgress:String;
         var TimerBackground:String;
         var TimerBorder:String;
         var message:String;
         var format:TextFormat;
         var senderID:int;
         var sceneCharacterComponent:SceneCharacterComponent;
         ui = new BotMessageUI();
         addChild(ui);
         roomMessageTip = new RoomMessageTip();
         addChild(roomMessageTip);
         roomMessageTip.addEventListener("overMessage",overHandler);
         roomMessageTip.addEventListener("outMessage",outHandler);
         roomMessageTip.addEventListener("closeClicked",closeClicked);
         ui.hitButton.addEventListener("mouseOver",overHandler);
         ui.hitButton.addEventListener("mouseOut",outHandler);
         ui.hitButton.addEventListener("mouseOut",outHandler);
         roomMessageTip.ui.btnReport.addEventListener("click",clickReport);
         roomMessageTip.x = -35;
         colorSet = RoomMessageColor.getTempByID(data.colorSet);
         Background = "0x" + colorSet.background;
         TimerProgress = "0x" + colorSet.progress;
         TimerBackground = "0x" + colorSet.timerBg;
         TimerBorder = "0x" + colorSet.border;
         if(sTxtMessage == null)
         {
            sTxtMessage = TextFieldManager.convertAsArabicTextField(roomMessageTip.ui.getChildByName("txtMessage") as TextField);
            botNameText = TextFieldManager.convertAsArabicTextField(ui.getChildByName("timeLabel") as TextField);
         }
         botNameText.multiline = sTxtMessage.multiline = true;
         sTxtMessage.width = 240;
         botNameText.width = 120;
         botNameText.autoSize = "none";
         sTxtMessage.autoSize = "none";
         message = StringUtil.removeCarriageReturnsAndNewLines(data.message);
         sTxtMessage.text = message;
         sTxtMessage.cacheAsBitmap = botNameText.cacheAsBitmap = true;
         sTxtMessage.height = sTxtMessage.textHeight + 4;
         if(sTxtMessage.numLines == 1)
         {
            sTxtMessage.width = sTxtMessage.textWidth + 6;
         }
         botNameText.text = data.senderName;
         format = botNameText.defaultTextFormat;
         format.color = uint(TimerProgress);
         format.align = "center";
         botNameText.setTextFormat(format);
         botNameText.x = -botNameText.width / 2;
         botNameText.y = 10;
         update();
         sTxtMessage.length > 15 ? (tipDelayTime = sTxtMessage.length * tipDelayRate) : (int(tipDelayTime = 15 * tipDelayRate));
         TweenMax.to(ui.rotateAnim,0,{"tint":uint(TimerProgress)});
         TweenMax.to(ui.background,0,{"tint":uint(Background)});
         TweenMax.to(ui.timerbackground,0,{"tint":uint(TimerBorder)});
         TweenMax.to(ui.maskContainer,0,{"tint":uint(TimerBackground)});
         TweenMax.to(botNameText,0,{"glowFilter":{
            "color":uint(Background),
            "alpha":1,
            "blurX":2,
            "blurY":2,
            "strength":10,
            "quality":3
         }});
         TweenMax.to(roomMessageTip.ui.background,0,{"tint":uint(Background)});
         TweenMax.to(sTxtMessage,0,{"tint":uint(TimerProgress)});
         TweenMax.to(roomMessageTip,0,{
            "scaleX":0,
            "scaleY":0,
            "autoAlpha":0
         });
         TweenMax.to(roomMessageTip,0.4,{
            "delay":0.6,
            "scaleX":1,
            "scaleY":1,
            "autoAlpha":1,
            "ease":Back.easeOut,
            "onComplete":function():void
            {
               TweenMax.to(roomMessageTip,0.4,{
                  "delay":tipDelayTime,
                  "scaleX":0,
                  "scaleY":0,
                  "autoAlpha":0,
                  "ease":Back.easeOut
               });
            }
         });
         totalTime = leftTime = data.duration;
         totalFrame = ui.rotateAnim.totalFrames;
         TweenMax.delayedCall(1,countDown);
         data.clip = this;
         senderID = int(data.senderID);
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            sceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            character = sceneCharacterComponent.getAvatarById(String(senderID));
         }
         if(character != null && character.isMe)
         {
            roomMessageTip.ui.btnReport.visible = false;
         }
         request = new AssetRequest();
         request.type = "ModuleType.PNG";
         request.name = "avatarimage";
         request.data = {};
         request.context = Sanalika.instance.domainModel.assetContext;
         request.assetId = "/cp/av/v2/" + data.senderID + "?instance=" + Sanalika.instance.gameModel.serverName + "&ip=" + data.imgPath + "&g=" + data.gender;
         request.loadedFunction = userImageLoaded;
         request.errorFunction = userImageError;
         Sanalika.instance.assetModel.request(request);
      }
      
      protected function userImageError(param1:IAssetRequest) : void
      {
         param1.dispose();
      }
      
      protected function userImageLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:Bitmap = new Bitmap((param1.display as Bitmap).bitmapData.clone());
         _loc2_.smoothing = true;
         _loc2_.scaleX = -1.2;
         _loc2_.scaleY = 1.2;
         ui.botPng.addChild(_loc2_);
         _loc2_.x = 2 + _loc2_.width / 2;
         _loc2_.y = -(_loc2_.height - 46);
         _loc2_.mask = ui.botMask;
         param1.dispose();
      }
      
      private function clickReport(param1:Event = null) : void
      {
         var _loc2_:PanelVO = null;
         if(character != null && data.message != null && !Sanalika.instance.avatarModel.guest)
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "ReportPanel";
            _loc2_.type = "hud";
            _loc2_.params = {};
            _loc2_.params.avatarId = character.id;
            _loc2_.params.lastMessage = data.message;
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         character = null;
         roomMessageTip.ui.btnReport.removeEventListener("click",clickReport);
         super.dispose();
      }
   }
}

