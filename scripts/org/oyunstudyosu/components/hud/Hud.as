package org.oyunstudyosu.components.hud
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.greensock.easing.Cubic;
   import com.oyunstudyosu.ban.BanData;
   import com.oyunstudyosu.chat.ChatColorTemplate;
   import com.oyunstudyosu.enums.BanType;
   import com.oyunstudyosu.enums.CharacterVariable;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.enums.RequestDataKey;
   import com.oyunstudyosu.enums.UpdateGroups;
   import com.oyunstudyosu.events.AchievementEvent;
   import com.oyunstudyosu.events.BanEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.PrivateChatEvent;
   import com.oyunstudyosu.events.ProfileEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import com.oyunstudyosu.utils.TimeConverter;
   import com.printfas3.printf;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.variables.UserVariable;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import org.oyunstudyosu.action.ActionView;
   import org.oyunstudyosu.components.CoreMovieClip;
   import org.oyunstudyosu.components.hud.menu.DanceButton;
   import org.oyunstudyosu.components.hud.menu.MainHudButton;
   import org.oyunstudyosu.components.hud.menu.SettingsButton;
   import org.oyunstudyosu.components.hud.menu.UnReadIndicator;
   import org.oyunstudyosu.settings.InGameSettingsView;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1218")]
   public class Hud extends CoreMovieClip
   {
      
      public var inputText:TextField;
      
      public var chatBg:MovieClip;
      
      public var menuBg:MovieClip;
      
      public var menuContainer:MovieClip;
      
      public var historyIcon:MovieClip;
      
      public var colorPanel:ChatColorPanel;
      
      private var hudEvent:HudEvent;
      
      private var bgColor:ColorTransform;
      
      private var inputColor:ColorTransform;
      
      public var whisperMc:MovieClip;
      
      private var user:User;
      
      private var buttons:Array;
      
      private var len:int;
      
      private var sw:int;
      
      private var child:DisplayObject;
      
      private var ratio:Number;
      
      private var actionView:ActionView;
      
      private var settingsView:InGameSettingsView;
      
      private var actionY:int;
      
      private var settingsY:int;
      
      private var targetSettingsButton:SettingsButton;
      
      private var banData:BanData;
      
      public var whisperText:STextField;
      
      public var unreadTf:TextField;
      
      public var unreadAchTf:TextField;
      
      public var unreadBg:MovieClip;
      
      public var unreadAchBg:MovieClip;
      
      public var messageIndicator:UnReadIndicator;
      
      public var achievementIndicator:UnReadIndicator;
      
      private var _unreadAchievementCount:int;
      
      private var _unreadCount:int;
      
      public function Hud()
      {
         super();
      }
      
      override public function added() : void
      {
         Dispatcher.addEventListener(BanEvent.CHAT_BANNED,this.onChatBan);
         this.buttons = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < this.menuContainer.numChildren)
         {
            this.child = this.menuContainer.getChildAt(_loc1_);
            if(this.child is MainHudButton)
            {
               (this.child as MainHudButton).init();
               this.buttons.push(this.child);
            }
            if(this.child is DanceButton)
            {
               this.child.addEventListener(MouseEvent.MOUSE_OVER,this.danceOver);
               this.child.addEventListener(MouseEvent.MOUSE_OUT,this.danceOut);
               this.actionView = new ActionView();
               this.actionView.x = this.child.x + this.child.width / 2;
               this.actionView.y = this.actionY = this.child.y - this.actionView.height / 2;
               TweenMax.to(this.actionView,0,{"autoAlpha":0});
               this.menuContainer.addChild(this.actionView);
               this.actionView.addEventListener(MouseEvent.MOUSE_OVER,this.actionOver);
               this.actionView.addEventListener(MouseEvent.MOUSE_OUT,this.actionOut);
            }
            if(this.child is SettingsButton)
            {
               this.child.addEventListener(MouseEvent.MOUSE_OVER,this.settingsOver);
               this.child.addEventListener(MouseEvent.MOUSE_OUT,this.settingsOut);
               this.settingsView = new InGameSettingsView();
               this.settingsView.name = "settingsView";
               this.settingsView.x = this.child.x + this.child.width / 2;
               this.settingsView.y = this.settingsY = 0;
               TweenMax.to(this.settingsView,0,{"autoAlpha":0});
               this.menuContainer.addChild(this.settingsView);
               this.settingsView.addEventListener(MouseEvent.MOUSE_OVER,this.settingsViewOver);
               this.settingsView.addEventListener(MouseEvent.MOUSE_OUT,this.settingsViewOut);
               this.targetSettingsButton = this.child as SettingsButton;
            }
            this.buttons.sortOn("x",Array.NUMERIC);
            _loc1_++;
         }
         this.len = this.buttons.length;
         var _loc2_:ChatColorTemplate = ChatColorTemplate.DEFAULT;
         this.chatBg.gotoAndStop(_loc2_.bgFrame);
         this.inputText.textColor = _loc2_.textColor;
         if(this.whisperText == null)
         {
            this.whisperText = TextFieldManager.convertAsArabicTextField(this.whisperMc.getChildByName("nickTxt") as TextField,false,false);
         }
         this.onChatBan();
         this.colorPanel.x = -this.colorPanel.width / 2;
         this.inputText.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.inputText.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         Connectr.instance.serviceModel.listenUserVariable(CharacterVariable.CHAT_BALLOON_COLOR,this.changeBalloonColorChanged);
         Dispatcher.addEventListener(ProfileEvent.WHISPER,this.whisperUpdate);
         this.whisperMc.addEventListener(MouseEvent.CLICK,this.whisperMcClicked);
         this.whisperMc.mouseChildren = false;
         if(!this.messageIndicator)
         {
            this.messageIndicator = new UnReadIndicator();
            this.messageIndicator.x = 36;
            (this.menuContainer.getChildByName("cell") as MovieClip).addChild(this.messageIndicator);
            this.achievementIndicator = new UnReadIndicator();
            this.achievementIndicator.x = 36;
            (this.menuContainer.getChildByName("achievement") as MovieClip).addChild(this.achievementIndicator);
         }
         Connectr.instance.privateChatModel.cellPhoneActive = false;
         this.unreadCount = Connectr.instance.privateChatModel.unreadCount;
         this.initAchLayout();
         Dispatcher.addEventListener(PrivateChatEvent.CELL_PHONE_MODE,this.cellPhoneModeChange);
         Dispatcher.addEventListener(PrivateChatEvent.UNREAD_COUNT_UPDATED,this.unreadCountUpdated);
      }
      
      private function onChatBan(param1:BanEvent = null) : void
      {
         var _loc2_:ChatColorTemplate = null;
         this.banData = Connectr.instance.banModel.getBanData(BanType.CHAT_BANNED);
         if(this.banData)
         {
            this.inputText.mouseEnabled = false;
            this.inputText.type = TextFieldType.DYNAMIC;
            if(this.banData.isLimited)
            {
               Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_1S).addFunction(this.banChecker);
               Dispatcher.removeEventListener(BanEvent.CHAT_BANNED_COMPLETE,this.chatBanCompleted);
               Dispatcher.addEventListener(BanEvent.CHAT_BANNED_COMPLETE,this.chatBanCompleted);
               this.inputText.text = "";
            }
            else
            {
               this.inputText.text = LanguageKeys.DEFAULT_INPUT_UNLIMITED_BAN_TEXT;
            }
            _loc2_ = ChatColorTemplate.DEFAULT;
            _loc2_ = ChatColorTemplate.BAN;
            this.chatBg.gotoAndStop(_loc2_.bgFrame);
            this.inputText.textColor = _loc2_.textColor;
         }
         else
         {
            this.inputText.text = LanguageKeys.DEFAULT_INPUT_TEXT;
         }
      }
      
      private function initAchLayout() : void
      {
         this.unreadAchievementCount = Connectr.instance.achievementModel.rewardCount;
         Dispatcher.addEventListener(AchievementEvent.REWARD_COUNT_UPDATED,this.rewardCountUpdated);
      }
      
      private function rewardCountUpdated(param1:AchievementEvent) : void
      {
         this.unreadAchievementCount = Connectr.instance.achievementModel.rewardCount;
      }
      
      private function unreadCountUpdated(param1:PrivateChatEvent) : void
      {
         this.unreadCount = Connectr.instance.privateChatModel.unreadCount;
      }
      
      public function get unreadAchievementCount() : int
      {
         return this._unreadAchievementCount;
      }
      
      public function set unreadAchievementCount(param1:int) : void
      {
         this._unreadAchievementCount = param1;
         this.achievementIndicator.setIndicator(param1);
      }
      
      private function cellPhoneModeChange(param1:PrivateChatEvent) : void
      {
         if(param1.cellPhoneActivated == true)
         {
            this.unreadCount = 0;
         }
         else
         {
            this.unreadCount = Connectr.instance.privateChatModel.unreadCount;
         }
      }
      
      public function get unreadCount() : int
      {
         return this._unreadCount;
      }
      
      public function set unreadCount(param1:int) : void
      {
         this._unreadCount = param1;
         this.messageIndicator.setIndicator(param1);
      }
      
      private function chatBanCompleted(param1:BanEvent) : void
      {
         Dispatcher.removeEventListener(BanEvent.CHAT_BANNED_COMPLETE,this.chatBanCompleted);
         this.inputText.mouseEnabled = true;
         this.inputText.type = TextFieldType.INPUT;
         Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_1S).removeFunction(this.banChecker);
         var _loc2_:ChatColorTemplate = ChatColorTemplate.DEFAULT;
         this.chatBg.gotoAndStop(_loc2_.bgFrame);
         this.inputText.textColor = _loc2_.textColor;
         this.inputText.text = LanguageKeys.DEFAULT_INPUT_TEXT;
      }
      
      private function banChecker(param1:uint, param2:uint) : void
      {
         if(this.banData.isLimited)
         {
            this.inputText.text = printf(LanguageKeys.DEFAULT_INPUT_BAN_TEXT,TimeConverter.toTime(this.banData.banEndTime * 1000,TimeConverter.HOUR_MINUTE_SECOND_TYPE));
         }
      }
      
      private function whisperUpdate(param1:ProfileEvent) : void
      {
         var _loc2_:User = null;
         var _loc3_:UserVariable = null;
         var _loc4_:String = null;
         var _loc5_:ChatColorTemplate = null;
         Connectr.instance.chatModel.whisperMode = param1.whisperMode;
         Connectr.instance.chatModel.whisperId = param1.avatarID;
         if(Connectr.instance.chatModel.whisperMode)
         {
            _loc2_ = Connectr.instance.serviceModel.sfs.lastJoinedRoom.getUserByName(param1.avatarID);
            if(_loc2_ == null)
            {
               return;
            }
            _loc3_ = _loc2_.getVariable(CharacterVariable.AVATAR_NAME);
            _loc4_ = _loc3_.getStringValue();
            if(_loc4_.length > 12)
            {
               _loc4_ = _loc4_.substr(0,9) + "...";
            }
            this.whisperText.text = _loc4_;
            this.whisperMc.visible = true;
            this.whisperText.width = 80;
            this.inputText.x = (-131 + this.whisperText.x + this.whisperText.width) * Connectr.instance.scaleModel.uiScale;
            this.inputText.width = 172;
            this.inputText.y = 9 * Connectr.instance.scaleModel.uiScale;
            _loc5_ = ChatColorTemplate.WHISPER;
            this.chatBg.gotoAndStop(_loc5_.bgFrame);
            this.inputText.textColor = _loc5_.textColor;
         }
         else
         {
            this.whisperMc.visible = false;
            this.inputText.x = -131 * Connectr.instance.scaleModel.uiScale;
            this.inputText.width = 270;
            Connectr.instance.serviceModel.requestData(RequestDataKey.USE_CHAT_BALLOON,{"id":1},null);
         }
      }
      
      protected function settingsViewOver(param1:MouseEvent) : void
      {
         TweenMax.killDelayedCallsTo(this.closeSettingsView);
      }
      
      protected function settingsViewOut(param1:MouseEvent) : void
      {
         TweenMax.killDelayedCallsTo(this.closeSettingsView);
         TweenMax.delayedCall(0.5,this.closeSettingsView);
      }
      
      protected function settingsOver(param1:MouseEvent) : void
      {
         TweenMax.killDelayedCallsTo(this.closeSettingsView);
         this.settingsView.update();
         if(this.settingsView.y != this.settingsY)
         {
            this.settingsView.y = this.settingsY + 10;
         }
         TweenMax.to(this.settingsView,0.3,{
            "autoAlpha":1,
            "y":this.settingsY,
            "ease":Cubic.easeOut
         });
         TweenMax.to(this.targetSettingsButton.arrow,0.3,{
            "rotation":180,
            "ease":Back.easeOut
         });
      }
      
      protected function settingsOut(param1:MouseEvent) : void
      {
         TweenMax.delayedCall(0.5,this.closeSettingsView);
      }
      
      private function closeSettingsView() : void
      {
         TweenMax.to(this.settingsView,0.3,{
            "autoAlpha":0,
            "y":this.settingsY + 10,
            "ease":Cubic.easeOut
         });
         TweenMax.to(this.targetSettingsButton.arrow,0.3,{
            "rotation":0,
            "ease":Back.easeOut
         });
      }
      
      protected function actionOver(param1:MouseEvent) : void
      {
         TweenMax.killDelayedCallsTo(this.closeActionView);
      }
      
      protected function actionOut(param1:MouseEvent) : void
      {
         TweenMax.killDelayedCallsTo(this.closeActionView);
         TweenMax.delayedCall(0.5,this.closeActionView);
      }
      
      protected function danceOver(param1:Event) : void
      {
         TweenMax.killDelayedCallsTo(this.closeActionView);
         this.actionView.update();
         if(this.actionView.y != this.actionY)
         {
            this.actionView.y = this.actionY + 15;
         }
         TweenMax.to(this.actionView,0.3,{
            "autoAlpha":1,
            "y":this.actionY,
            "ease":Cubic.easeOut
         });
      }
      
      protected function danceOut(param1:Event) : void
      {
         TweenMax.delayedCall(0.5,this.closeActionView);
      }
      
      private function closeActionView() : void
      {
         TweenMax.to(this.actionView,0.3,{
            "autoAlpha":0,
            "y":this.actionY + 15,
            "ease":Cubic.easeOut
         });
      }
      
      protected function whisperMcClicked(param1:MouseEvent) : void
      {
         var _loc2_:ProfileEvent = new ProfileEvent(ProfileEvent.WHISPER);
         _loc2_.whisperMode = false;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      private function changeBalloonColorChanged(param1:Object) : void
      {
         var _loc2_:int = 0;
         this.user = param1 as User;
         if(this.user == null)
         {
            return;
         }
         if(!this.user.isItMe)
         {
            return;
         }
         var _loc3_:UserVariable = this.user.getVariable(CharacterVariable.CHAT_BALLOON_COLOR);
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.getStringValue());
         }
         else
         {
            _loc2_ = 1;
         }
         var _loc4_:ChatColorTemplate = Connectr.instance.chatBalloonModel.getTemplateByID(_loc2_);
         this.chatBg.gotoAndStop(_loc4_.bgFrame);
         this.inputText.textColor = _loc4_.textColor;
      }
      
      protected function focusIn(param1:FocusEvent) : void
      {
         this.hudEvent = new HudEvent(HudEvent.TEXT_FIELD_FOCUS_IN);
         this.hudEvent.tf = this.inputText;
         Dispatcher.dispatchEvent(this.hudEvent);
         this.colorPanel.x = -this.colorPanel.width / 2;
         TweenMax.killTweensOf(this.colorPanel);
         TweenMax.to(this.colorPanel,0.3,{
            "delay":0.1,
            "y":this.inputText.y - 40 * Connectr.instance.scaleModel.uiScale,
            "ease":Back.easeOut
         });
      }
      
      protected function focusOut(param1:FocusEvent) : void
      {
         this.hudEvent = new HudEvent(HudEvent.TEXT_FIELD_FOCUS_OUT);
         this.hudEvent.tf = this.inputText;
         Dispatcher.dispatchEvent(this.hudEvent);
         TweenMax.killTweensOf(this.colorPanel);
         TweenMax.to(this.colorPanel,0.3,{
            "delay":0.2,
            "y":this.inputText.y,
            "ease":Back.easeIn
         });
      }
      
      override public function removed() : void
      {
         this.inputText.removeEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.inputText.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
      }
   }
}

