package extensions.notification
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.greensock.easing.Linear;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.bot.IBotMessage;
   import com.oyunstudyosu.door.IProperty;
   import com.oyunstudyosu.events.BotMessageEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.StringUtil;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import org.oyunstudyosu.assets.clips.BotMessageUI;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   public class BotMessage extends CoreMovieClip implements IBotMessage
   {
      
      public var ui:BotMessageUI;
      
      public var roomMessageTip:RoomMessageTip;
      
      protected var tipDelayRate:Number = 0.2;
      
      protected var tipDelayTime:int;
      
      protected var totalTime:int;
      
      protected var leftTime:int;
      
      protected var totalFrame:int;
      
      public var sTxtMessage:STextField;
      
      public var messageContent:String;
      
      protected var botNameText:STextField;
      
      protected var PADDING:int = 10;
      
      protected var request:IAssetRequest;
      
      private var _data:Object;
      
      private var _property:IProperty;
      
      public function BotMessage()
      {
         super();
      }
      
      override public function added() : void
      {
      }
      
      public function init() : void
      {
         var colors:Array;
         var Background:String;
         var TimerProgress:String;
         var TimerBackground:String;
         var TimerBorder:String;
         var format:TextFormat;
         ui = new BotMessageUI();
         addChild(ui);
         roomMessageTip = new RoomMessageTip();
         roomMessageTip.ui.btnReport.visible = false;
         addChild(roomMessageTip);
         roomMessageTip.addEventListener("overMessage",overHandler);
         roomMessageTip.addEventListener("outMessage",outHandler);
         roomMessageTip.addEventListener("closeClicked",closeClicked);
         ui.hitButton.addEventListener("mouseOver",overHandler);
         ui.hitButton.addEventListener("mouseOut",outHandler);
         ui.hitButton.addEventListener("click",clickCopy);
         roomMessageTip.x = -35;
         colors = data.colors;
         Background = "0x" + colors[0];
         TimerProgress = "0x" + colors[1];
         TimerBackground = "0x" + colors[2];
         TimerBorder = "0x" + colors[3];
         if(botNameText == null)
         {
            sTxtMessage = TextFieldManager.convertAsArabicTextField(roomMessageTip.ui.getChildByName("txtMessage") as TextField);
            botNameText = TextFieldManager.convertAsArabicTextField(ui.getChildByName("timeLabel") as TextField);
         }
         botNameText.multiline = true;
         botNameText.autoSize = "none";
         botNameText.width = 70;
         messageContent = data.message;
         messageContent = StringUtil.wrapHtmlTags(messageContent);
         messageContent = StringUtil.txt2link(messageContent,"ffffff");
         messageContent = StringUtil.replaceCarriageReturnsToBr(messageContent);
         sTxtMessage.htmlText = messageContent;
         sTxtMessage.cacheAsBitmap = botNameText.cacheAsBitmap = true;
         sTxtMessage.height = sTxtMessage.textHeight + 28;
         sTxtMessage.width = sTxtMessage.textWidth + 6;
         if(sTxtMessage.width > 200)
         {
            sTxtMessage.width = 200;
         }
         sTxtMessage.multiline = true;
         sTxtMessage.wordWrap = true;
         if(property)
         {
            if(property.data.cn != "SimpleBotMessageProperty")
            {
               roomMessageTip.addClickEvent(property);
               sTxtMessage.mouseEnabled = false;
            }
            else
            {
               sTxtMessage.mouseEnabled = true;
            }
         }
         botNameText.htmlText = $(data.botKey);
         format = botNameText.defaultTextFormat;
         format.color = uint(TimerProgress);
         format.align = "center";
         botNameText.setTextFormat(format);
         botNameText.x = -botNameText.width / 2;
         botNameText.height = botNameText.textHeight + 12;
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
            "strength":30,
            "quality":3
         }});
         TweenMax.to(roomMessageTip.ui.background,0,{"tint":uint(Background)});
         sTxtMessage.textColor = uint(TimerProgress);
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
         totalTime = leftTime = 20;
         if(data.duration)
         {
            totalTime = leftTime = data.duration;
         }
         totalFrame = ui.rotateAnim.totalFrames;
         TweenMax.delayedCall(1,countDown);
         data.clip = this;
         request = new AssetRequest();
         request.type = "ModuleType.PNG";
         request.context = Sanalika.instance.domainModel.assetContext;
         request.assetId = "/static/bots/" + data.botKey + ".png?" + data.version;
         request.loadedFunction = onLoaded;
         request.errorFunction = onError;
         Sanalika.instance.assetModel.request(request);
      }
      
      public function clickCopy(param1:MouseEvent) : void
      {
         if(param1.ctrlKey)
         {
            System.setClipboard(messageContent);
         }
      }
      
      public function update() : void
      {
         roomMessageTip.ui.background.height = sTxtMessage.height + PADDING * 2;
         roomMessageTip.ui.background.width = sTxtMessage.width + PADDING * 2;
         roomMessageTip.ui.background.y = -roomMessageTip.ui.background.height / 2;
         sTxtMessage.x = roomMessageTip.ui.background.x - roomMessageTip.ui.background.width + PADDING;
         sTxtMessage.y = roomMessageTip.ui.background.y + PADDING / 2 + 2;
         TweenMax.to(sTxtMessage,0,{"dropShadowFilter":{
            "color":0,
            "alpha":0.4,
            "blurX":0,
            "blurY":0,
            "distance":1,
            "angle":45
         }});
         roomMessageTip.ui.btnClose.x = Math.round(roomMessageTip.ui.background.x - roomMessageTip.ui.background.width);
         roomMessageTip.ui.btnClose.y = Math.round(roomMessageTip.ui.background.y);
         roomMessageTip.ui.btnReport.x = roomMessageTip.ui.btnClose.x + 20;
         roomMessageTip.ui.btnReport.y = roomMessageTip.ui.btnClose.y;
      }
      
      protected function onError(param1:IAssetRequest) : void
      {
         this.mouseEnabled = false;
         this.alpha = 0.5;
      }
      
      protected function onLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:Bitmap = param1.display as Bitmap;
         _loc2_.smoothing = true;
         ui.botPng.addChild(_loc2_);
         _loc2_.x = -_loc2_.width / 2;
         _loc2_.y = -(_loc2_.height - 25);
         _loc2_.mask = ui.botMask;
         param1.dispose();
      }
      
      protected function overHandler(param1:Event) : void
      {
         TweenMax.killTweensOf(roomMessageTip);
         TweenMax.to(roomMessageTip,0.4,{
            "autoAlpha":1,
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
      }
      
      protected function outHandler(param1:Event) : void
      {
         TweenMax.to(roomMessageTip,0.4,{
            "delay":1,
            "scaleX":0,
            "scaleY":0,
            "autoAlpha":0,
            "ease":Back.easeIn
         });
      }
      
      protected function closeClicked(param1:Event = null) : void
      {
         var e:Event = param1;
         var holder:IBotMessage = this;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         TweenMax.to(roomMessageTip,0.4,{
            "scaleX":0,
            "scaleY":0,
            "autoAlpha":0,
            "ease":Back.easeIn
         });
         TweenLite.to(this,0.4,{
            "x":"+100",
            "delay":0.5,
            "ease":Back.easeInOut,
            "onComplete":function():void
            {
               var _loc1_:BotMessageEvent = new BotMessageEvent("BotMessageEvent.REMOVE_MESSAGE");
               _loc1_.clip = holder;
               Dispatcher.dispatchEvent(_loc1_);
            }
         });
      }
      
      protected function countDown() : void
      {
         var getFrameNumber:int;
         if(leftTime > 0)
         {
            leftTime = leftTime - 1;
            getFrameNumber = (totalTime - leftTime) / totalTime * totalFrame;
            TweenMax.to(ui.rotateAnim,1,{
               "frame":getFrameNumber,
               "ease":Linear.easeNone
            });
            TweenMax.delayedCall(1,countDown);
         }
         else
         {
            TweenMax.killDelayedCallsTo(countDown);
            TweenMax.killTweensOf(roomMessageTip);
            if(roomMessageTip)
            {
               mouseChildren = mouseEnabled = false;
               TweenMax.to(roomMessageTip,0.4,{
                  "scaleX":0,
                  "scaleY":0,
                  "autoAlpha":0
               });
               TweenLite.to(this,0.4,{
                  "delay":1,
                  "x":"+100",
                  "ease":Back.easeInOut,
                  "onComplete":function():void
                  {
                     closeClicked();
                  }
               });
            }
            else
            {
               TweenLite.to(this,0.4,{
                  "x":"+100",
                  "ease":Back.easeInOut,
                  "onComplete":function():void
                  {
                     closeClicked();
                  }
               });
            }
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:Class = null;
         _data = param1;
         if(param1 && param1.property)
         {
            trace(param1.colors.constructor.toString());
            if(param1.property && param1.property.constructor.toString().match(/object/i) != "Object")
            {
               param1.property = JSON.parse(param1.property);
            }
            if(param1.colors && !(param1.colors is Array))
            {
               param1.colors = JSON.parse(param1.colors);
            }
            if(param1.filters && !(param1.filters is Array))
            {
               param1.filters = JSON.parse(param1.filters);
            }
            _loc2_ = getDefinitionByName("com.oyunstudyosu.property." + param1.property.cn) as Class;
            property = new _loc2_();
            property.data = param1.property;
         }
      }
      
      public function get property() : IProperty
      {
         return _property;
      }
      
      public function set property(param1:IProperty) : void
      {
         if(_property == param1)
         {
            return;
         }
         _property = param1;
      }
      
      public function dispose() : void
      {
         roomMessageTip.removeEventListener("overMessage",overHandler);
         roomMessageTip.removeEventListener("outMessage",outHandler);
         roomMessageTip.removeEventListener("closeClicked",closeClicked);
         ui.hitButton.removeEventListener("mouseOver",overHandler);
         ui.hitButton.removeEventListener("mouseOut",outHandler);
         ui.hitButton.removeEventListener("click",clickCopy);
         TweenMax.killDelayedCallsTo(countDown);
         TweenMax.killTweensOf(roomMessageTip);
         TweenMax.killTweensOf(this);
         _data = {};
      }
      
      override public function removed() : void
      {
         dispose();
      }
   }
}

