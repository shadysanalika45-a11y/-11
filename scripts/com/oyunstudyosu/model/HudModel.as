package com.oyunstudyosu.model
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.BusinessMessageEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.PoolEvent;
   import com.oyunstudyosu.events.PrivateChatEvent;
   import com.oyunstudyosu.events.ScaleEvent;
   import com.oyunstudyosu.events.SoftKeyboardEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.local.arabic.ArabicInputManager;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.interfaces.IHudModel;
   import com.oyunstudyosu.tutorial.TutorialEvent;
   import flash.display.DisplayObject;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import org.oyunstudyosu.assets.buttons.ExitPoolButton;
   import org.oyunstudyosu.assets.buttons.ExitTutorialButton;
   import org.oyunstudyosu.assets.clips.FunbidButton;
   import org.oyunstudyosu.assets.clips.FunwinButton;
   import org.oyunstudyosu.assets.clips.Joystick;
   import org.oyunstudyosu.assets.clips.MatchmakingButton;
   import org.oyunstudyosu.assets.clips.QuestIndicator;
   import org.oyunstudyosu.assets.clips.Radio;
   import org.oyunstudyosu.avatar.AvatarView;
   import org.oyunstudyosu.balance.BalanceView;
   import org.oyunstudyosu.business.BusinessMenu;
   import org.oyunstudyosu.business.BusinessMessage;
   import org.oyunstudyosu.components.hud.Hud;
   import org.oyunstudyosu.components.hud.menu.ZoomInButton;
   import org.oyunstudyosu.components.hud.menu.ZoomOutButton;
   
   public class HudModel implements IHudModel
   {
      
      public var hud:Hud;
      
      private var businessMenu:BusinessMenu;
      
      private var balanceView:BalanceView;
      
      public var avatarView:AvatarView;
      
      private var poolExitButton:ExitPoolButton;
      
      private var tutorialExitButton:ExitTutorialButton;
      
      private var isBroadcast:int = 0;
      
      public var inputManager:ArabicInputManager;
      
      private var defaultText:String;
      
      private var lastTime:int = 0;
      
      public var questIndicator:QuestIndicator;
      
      private var funwin:FunwinButton;
      
      private var funbidButton:FunbidButton;
      
      private var matchmakingButton:MatchmakingButton;
      
      public var broadcastButton:Radio;
      
      private var topLocationX:int = -50;
      
      private var streamPath:String;
      
      public var mc_joystick:Joystick;
      
      public var defaultHudHeight:int = 35;
      
      public var zoomInButton:ZoomInButton;
      
      public var zoomOutButton:ZoomOutButton;
      
      private var _visible:Boolean = true;
      
      public function HudModel()
      {
         super();
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_visible != param1)
         {
            if(param1)
            {
               Dispatcher.dispatchEvent(new HudEvent("HudEvent.SHOW_BALANCE_VIEW"));
            }
            else
            {
               Dispatcher.dispatchEvent(new HudEvent("HudEvent.HIDE_BALANCE_VIEW"));
            }
         }
         _visible = param1;
      }
      
      public function init() : void
      {
         streamPath = "http://fs.sanalika.com:8080/" + Sanalika.instance.gameModel.serverName;
         hud = new Hud();
         hud.name = "hud";
         Sanalika.instance.layerModel.hudLayer.addChild(hud);
         Dispatcher.dispatchEvent(new PrivateChatEvent("PrivateChatEvent.UNREAD_COUNT_UPDATED"));
         hud.whisperMc.visible = false;
         hud.visible = false;
         defaultText = LanguageKeys.DEFAULT_INPUT_TEXT;
         avatarView = new AvatarView();
         avatarView.alpha = 0;
         avatarView.x = 10;
         avatarView.y = 10;
         avatarView.scaleX = Sanalika.instance.scaleModel.uiScale;
         avatarView.scaleY = Sanalika.instance.scaleModel.uiScale;
         Sanalika.instance.layerModel.hudLayer.addChild(avatarView);
         balanceView = new BalanceView();
         balanceView.name = "balanceView";
         balanceView.y = 200 / Sanalika.instance.scaleModel.uiScale;
         balanceView.scaleX = Sanalika.instance.scaleModel.uiScale;
         balanceView.scaleY = Sanalika.instance.scaleModel.uiScale;
         Sanalika.instance.layerModel.hudLayer.addChild(balanceView);
         TweenMax.to(balanceView,0,{
            "autoAlpha":0,
            "ease":Sine.easeOut
         });
         if(Sanalika.instance.gameModel.language == "ar")
         {
            hud.inputText.maxChars = 100;
            inputManager = new ArabicInputManager(hud.inputText,hud.inputText.defaultTextFormat);
         }
         addHudEvents();
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+SHIFT+S",showHideHud);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+1",openBuddyPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+2",openClothPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+3",openInventoryPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+4",openChatHistory);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+5",openSmileyPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+6",openIslandsPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+7",openAchievementPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+8",openAvatarSwitchPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+9",openMapPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+0",openSettingsPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+37",manualLeftDirection);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+39",manualRightDirection);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+ALT+1",openComplaintPanel);
         Sanalika.instance.keyboardModel.addKeyMapping("CTRL+ALT+9",saveScreenShot);
         onSceneResize(null);
      }
      
      private function saveScreenShot() : void
      {
         var _loc1_:GameEvent = new GameEvent("SS_IMAGE");
         Dispatcher.dispatchEvent(_loc1_);
      }
      
      private function openComplaintPanel() : void
      {
         var _loc1_:PanelVO = null;
         if(Sanalika.instance.avatarModel.permission.check(16))
         {
            _loc1_ = new PanelVO();
            _loc1_.name = "ComplaintPanel";
            _loc1_.type = "hud";
            Sanalika.instance.panelModel.openPanel(_loc1_);
         }
      }
      
      private function changeDirection(param1:ICharacter, param2:int) : void
      {
         if(param1.status == "i" || param1.status == "d")
         {
            param1.reLocate(param1.currentTile.x,param1.currentTile.y,param2,false);
            param1.setStatus("i",param2);
            Sanalika.instance.serviceModel.setUserVariable(["direction"],[param2]);
         }
      }
      
      private function manualLeftDirection() : void
      {
         var _loc1_:SceneCharacterComponent = null;
         var _loc2_:ICharacter = null;
         if(getTimer() > lastTime + 1200 && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc1_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc2_ = _loc1_.myChar;
            if(_loc2_ != null)
            {
               _loc2_.rotateCharLeft();
               lastTime = getTimer();
            }
         }
      }
      
      private function manualRightDirection() : void
      {
         var _loc1_:SceneCharacterComponent = null;
         var _loc2_:ICharacter = null;
         if(getTimer() > lastTime + 1200 && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc1_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc2_ = _loc1_.myChar;
            if(_loc2_ != null)
            {
               _loc2_.rotateCharRight();
               lastTime = getTimer();
            }
         }
      }
      
      private function sceneResize(param1:GameEvent) : void
      {
         if(businessMenu)
         {
            businessMenu.scaleX = Sanalika.instance.scaleModel.uiScale;
            businessMenu.scaleY = Sanalika.instance.scaleModel.uiScale;
            if(Sanalika.instance.layerModel.hudLayer.x > businessMenu.width)
            {
               businessMenu.x = -businessMenu.width;
            }
            else
            {
               businessMenu.x = -Sanalika.instance.layerModel.hudLayer.x;
            }
         }
      }
      
      public function addHudEvents() : void
      {
         hud.inputText.addEventListener("focusIn",focusIn);
         hud.inputText.addEventListener("focusOut",focusOut);
         Dispatcher.addEventListener("UI_SCALE_CHANGED",onUIScaleChanged);
         Dispatcher.addEventListener("PoolEvent.SHOW_EXIT_BUTTON",showPoolExitButton);
         Dispatcher.addEventListener("PoolEvent.HIDE_EXIT_BUTTON",hidePoolExitButton);
         Dispatcher.addEventListener("RESIZE",onSceneResize);
         Dispatcher.addEventListener("HudEvent.SHOW_BALANCE_VIEW",onShowBW);
         Dispatcher.addEventListener("HudEvent.HIDE_BALANCE_VIEW",onHideBW);
         Dispatcher.addEventListener("TRANSITION_IN_COMPLETE",transitionCompleted);
         Dispatcher.addEventListener("TRANSITION_OUT",transitionOutStarted);
         Dispatcher.addEventListener("SCENE_LOADED",sceneLoaded);
         Dispatcher.addEventListener("RESIZE",sceneResize);
         Dispatcher.addEventListener("chatColorChangeRequest",changeChatColorRequest);
         Dispatcher.addEventListener("openChatHistory",openChatHistory);
         Dispatcher.addEventListener("openBuddyPanel",openBuddyPanel);
         Dispatcher.addEventListener("openSmileyPanel",openSmileyPanel);
         Dispatcher.addEventListener("openAvatarSwitchPanel",openAvatarSwitchPanel);
         Dispatcher.addEventListener("openSettingsPanel",openSettingsPanel);
         Dispatcher.addEventListener("openMapPanel",openMapPanel);
         Dispatcher.addEventListener("openIslandsPanel",openIslandsPanel);
         Dispatcher.addEventListener("openInventoryPanel",openInventoryPanel);
         Dispatcher.addEventListener("openSharePanel",openSharePanel);
         Dispatcher.addEventListener("openInvitePanel",openInvitePanel);
         Dispatcher.addEventListener("openAchievementsPanel",openAchievementPanel);
         Dispatcher.addEventListener("openSanilPurchasePanel",openSanilPurchasePanel);
         Dispatcher.addEventListener("openDiamondPurchasePanel",openDiamondPurchasePanel);
         Dispatcher.addEventListener("openProductPurchasePanel",openProductPurchasePanel);
         Dispatcher.addEventListener("openClothPanel",openClothPanel);
         Dispatcher.addEventListener("openRoomDesign",openRoomDesign);
         Dispatcher.addEventListener("HudEvent.OPEN_ROOM_LIST_PANEL",openRoomListPanel);
         Dispatcher.addEventListener("HudEvent.OPEN_ROOM_INFO",openRoomInfo);
         Dispatcher.addEventListener("HudEvent.SEND_BUSINESS_MESSAGE",sendBusinessMessage);
         Dispatcher.addEventListener("HudEvent.OPEN_RESTRICTED_LIST_PANEL",openRestrictedListPanel);
         Dispatcher.addEventListener("HudEvent.OPEN_ORDER_PANEL",openOrderPanel);
         Dispatcher.addEventListener("openCellPhone",openCellPhone);
         Dispatcher.addEventListener("HudEvent.SHOW_STEP_INDICATOR",showIndicator);
         Dispatcher.addEventListener("HudEvent.HIDE_STEP_INDICATOR",hideIndicator);
         Dispatcher.addEventListener("HudEvent.SHOW_FUNBID",showFunbid);
         Dispatcher.addEventListener("HudEvent.HIDE_FUNBID",hideFunbid);
         Dispatcher.addEventListener("HudEvent.SHOW_FUNWIN",showFunwin);
         Dispatcher.addEventListener("HudEvent.HIDE_FUNWIN",hideFunwin);
         Dispatcher.addEventListener("HudEvent.SHOW_RADIO",showRadio);
         Dispatcher.addEventListener("HudEvent.HIDE_RADIO",hideRadio);
         Dispatcher.addEventListener("HudEvent.SHOW_NEWYEAR",showNewyear);
         Dispatcher.addEventListener("HudEvent.HIDE_NEWYEAR",hideNewyear);
         Dispatcher.addEventListener("HudEvent.SHOW_SNOWBALL",showSnowball);
         Dispatcher.addEventListener("HudEvent.HIDE_SNOWBALL",hideSnowball);
         Dispatcher.addEventListener("HudEvent.SHOW_MATCHMAKING",showMatchmaking);
         Dispatcher.addEventListener("HudEvent.HIDE_MATCHMAKING",hideMatchmaking);
         Dispatcher.addEventListener("HudEvent.THROW",throwItem);
         if(Sanalika.instance.softKeyboardModel.isSupported)
         {
            Dispatcher.addEventListener("SOFT_KEYBOARD_ACTIVATE",onKeyboardShow);
            Dispatcher.addEventListener("SOFT_KEYBOARD_DEACTIVATE",onKeyboardHide);
            hud.inputText.addEventListener("focusOut",onKeyboardHide);
         }
         saturateHudButtons();
      }
      
      private function onKeyboardShow(param1:SoftKeyboardEvent) : void
      {
         Cc.info("onKeyboardShow");
         Cc.info("y: " + param1.y);
         Cc.info("height: " + param1.height);
         hud.y = param1.y - hud.menuBg.height;
      }
      
      private function onKeyboardHide(param1:*) : void
      {
         setTimeout(keyboardHide,500);
      }
      
      private function keyboardHide() : void
      {
         hud.y = Sanalika.instance.layerModel.canvasHeight;
      }
      
      public function deSaturateHudButtons() : void
      {
         TweenMax.to(hud.menuContainer,1,{"colorMatrixFilter":{"saturation":0}});
         TweenMax.to(balanceView,1,{"colorMatrixFilter":{"saturation":0}});
      }
      
      public function saturateHudButtons() : void
      {
         TweenMax.to(hud.menuContainer,1,{"colorMatrixFilter":{"saturation":1}});
         TweenMax.to(balanceView,1,{"colorMatrixFilter":{"saturation":1}});
      }
      
      public function removeHudEvents() : void
      {
         deSaturateHudButtons();
         Dispatcher.removeEventListener("chatColorChangeRequest",changeChatColorRequest);
         Dispatcher.removeEventListener("openChatHistory",openChatHistory);
         Dispatcher.removeEventListener("openBuddyPanel",openBuddyPanel);
         Dispatcher.removeEventListener("openSmileyPanel",openSmileyPanel);
         Dispatcher.removeEventListener("openAvatarSwitchPanel",openAvatarSwitchPanel);
         Dispatcher.removeEventListener("openSettingsPanel",openSettingsPanel);
         Dispatcher.removeEventListener("openMapPanel",openMapPanel);
         Dispatcher.removeEventListener("openIslandsPanel",openIslandsPanel);
         Dispatcher.removeEventListener("openInventoryPanel",openInventoryPanel);
         Dispatcher.removeEventListener("openSharePanel",openSharePanel);
         Dispatcher.removeEventListener("openInvitePanel",openInvitePanel);
         Dispatcher.removeEventListener("openAchievementsPanel",openAchievementPanel);
         Dispatcher.removeEventListener("openSanilPurchasePanel",openSanilPurchasePanel);
         Dispatcher.removeEventListener("openDiamondPurchasePanel",openDiamondPurchasePanel);
         Dispatcher.removeEventListener("openProductPurchasePanel",openProductPurchasePanel);
         Dispatcher.removeEventListener("openClothPanel",openClothPanel);
         Dispatcher.removeEventListener("openRoomDesign",openRoomDesign);
         Dispatcher.removeEventListener("HudEvent.OPEN_ROOM_LIST_PANEL",openRoomListPanel);
         Dispatcher.removeEventListener("HudEvent.OPEN_ROOM_INFO",openRoomInfo);
         Dispatcher.removeEventListener("HudEvent.SEND_BUSINESS_MESSAGE",sendBusinessMessage);
         Dispatcher.removeEventListener("HudEvent.OPEN_RESTRICTED_LIST_PANEL",openRestrictedListPanel);
         Dispatcher.removeEventListener("HudEvent.OPEN_ORDER_PANEL",openOrderPanel);
         Dispatcher.removeEventListener("openCellPhone",openCellPhone);
         Dispatcher.removeEventListener("HudEvent.SHOW_STEP_INDICATOR",showIndicator);
         Dispatcher.removeEventListener("HudEvent.HIDE_STEP_INDICATOR",hideIndicator);
         Dispatcher.removeEventListener("HudEvent.SHOW_FUNBID",showFunbid);
         Dispatcher.removeEventListener("HudEvent.HIDE_FUNBID",hideFunbid);
         Dispatcher.removeEventListener("HudEvent.SHOW_FUNWIN",showFunwin);
         Dispatcher.removeEventListener("HudEvent.HIDE_FUNWIN",hideFunwin);
         Dispatcher.removeEventListener("HudEvent.SHOW_RADIO",showRadio);
         Dispatcher.removeEventListener("HudEvent.HIDE_RADIO",hideRadio);
         Dispatcher.removeEventListener("HudEvent.SHOW_MATCHMAKING",showMatchmaking);
         Dispatcher.removeEventListener("HudEvent.HIDE_MATCHMAKING",hideMatchmaking);
         if(Sanalika.instance.softKeyboardModel.isSupported)
         {
            Dispatcher.removeEventListener("SOFT_KEYBOARD_ACTIVATE",onKeyboardShow);
            Dispatcher.removeEventListener("SOFT_KEYBOARD_DEACTIVATE",onKeyboardHide);
         }
      }
      
      public function addSpesificListener(param1:String, param2:Function) : void
      {
         Dispatcher.addEventListener(param1,param2);
      }
      
      public function removeSpesificListener(param1:String, param2:Function) : void
      {
         Dispatcher.removeEventListener(param1,param2);
      }
      
      private function onShowBW(param1:HudEvent) : void
      {
         TweenMax.to(avatarView,0.2,{
            "autoAlpha":1,
            "ease":Sine.easeOut
         });
         TweenMax.to(balanceView,0.2,{
            "autoAlpha":1,
            "ease":Sine.easeOut
         });
      }
      
      private function onHideBW(param1:HudEvent) : void
      {
         TweenMax.to(avatarView,0.3,{
            "autoAlpha":0,
            "ease":Sine.easeOut
         });
         TweenMax.to(balanceView,0.3,{
            "autoAlpha":0,
            "ease":Sine.easeOut
         });
      }
      
      protected function focusIn(param1:FocusEvent) : void
      {
         if(inputManager)
         {
            hud.inputText.text = "";
            inputManager.changeFormat(hud.inputText.defaultTextFormat);
         }
         else if(hud.inputText.text == defaultText)
         {
            hud.inputText.text = "";
         }
         hud.inputText.addEventListener("keyDown",keyPressed);
      }
      
      protected function focusOut(param1:FocusEvent) : void
      {
         stopTyping();
         hud.inputText.removeEventListener("keyDown",keyPressed);
         if(inputManager)
         {
            inputManager.clearText();
            inputManager.addText(defaultText);
            inputManager.draw();
         }
         else if(hud.inputText.text == "")
         {
            hud.inputText.text = defaultText;
         }
         if(Sanalika.instance.airModel.isMobile())
         {
         }
      }
      
      protected function stopTyping() : void
      {
         TweenMax.killDelayedCallsTo(stopTyping);
         if(Sanalika.instance.avatarModel.tp == 1)
         {
            Sanalika.instance.serviceModel.setUserVariable(["tp"],[0]);
         }
      }
      
      protected function keyPressed(param1:KeyboardEvent) : void
      {
         var _loc2_:HudEvent = null;
         if(getTimer() > lastTime + 2400 && Sanalika.instance.avatarModel.tp == 0)
         {
            Sanalika.instance.serviceModel.setUserVariable(["tp"],[1]);
            lastTime = getTimer();
            TweenMax.killDelayedCallsTo(stopTyping);
            TweenMax.delayedCall(5,stopTyping);
         }
         if(param1.keyCode == 13)
         {
            stopTyping();
            _loc2_ = new HudEvent("sendMessage");
            if(inputManager)
            {
               _loc2_.chatMessage = inputManager.getText();
               hud.inputText.text = "";
               inputManager.clearText();
            }
            else
            {
               _loc2_.chatMessage = hud.inputText.text;
               hud.inputText.text = "";
            }
            Dispatcher.dispatchEvent(_loc2_);
         }
      }
      
      private function showTutorialExitButton(param1:TutorialEvent) : void
      {
         if(tutorialExitButton == null && hud != null)
         {
            tutorialExitButton = new ExitTutorialButton();
            Sanalika.instance.layerModel.hudLayer.addChild(tutorialExitButton);
            Sanalika.instance.toolTipModel.addTip(tutorialExitButton,$("Exit Tutorial"));
            tutorialExitButton.addEventListener("click",exitTutorial);
         }
         else
         {
            tutorialExitButton.visible = true;
         }
         onSceneResize(null);
      }
      
      private function hideTutorialExitButton(param1:TutorialEvent) : void
      {
         Dispatcher.removeEventListener("TutorialEvent.SHOW_TUTORIAL_BUTTON",showTutorialExitButton);
         Dispatcher.removeEventListener("TutorialEvent.EXIT_TUTORIAL",hideTutorialExitButton);
         tutorialExitButton.removeEventListener("click",exitTutorial);
         tutorialExitButton.visible = false;
      }
      
      protected function exitTutorial(param1:MouseEvent) : void
      {
         Dispatcher.removeEventListener("TutorialEvent.SHOW_TUTORIAL_BUTTON",showTutorialExitButton);
         Dispatcher.removeEventListener("TutorialEvent.EXIT_TUTORIAL",hideTutorialExitButton);
         tutorialExitButton.removeEventListener("click",exitTutorial);
         tutorialExitButton.visible = false;
         Dispatcher.dispatchEvent(new TutorialEvent("TutorialEvent.EXIT_TUTORIAL"));
      }
      
      private function onUIScaleChanged(param1:ScaleEvent) : void
      {
         balanceView.scaleX = Sanalika.instance.scaleModel.uiScale;
         balanceView.scaleY = Sanalika.instance.scaleModel.uiScale;
         if(avatarView != null)
         {
            avatarView.scaleX = Sanalika.instance.scaleModel.uiScale;
            avatarView.scaleY = Sanalika.instance.scaleModel.uiScale;
         }
      }
      
      private function showPoolExitButton(param1:PoolEvent) : void
      {
         if(poolExitButton == null && hud != null)
         {
            poolExitButton = new ExitPoolButton();
            poolExitButton.width = poolExitButton.height = 45;
            Sanalika.instance.layerModel.hudLayer.addChild(poolExitButton);
            Sanalika.instance.toolTipModel.addTip(poolExitButton,$("Exit Pool"));
            poolExitButton.addEventListener("click",exitFromPool);
         }
         else
         {
            poolExitButton.visible = true;
         }
         Sanalika.instance.engine.scene.disable();
         onSceneResize(null);
      }
      
      protected function exitFromPool(param1:MouseEvent) : void
      {
         var _loc3_:GamePool = null;
         var _loc4_:IntPoint = null;
         if(!Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         Sanalika.instance.engine.scene.enable();
         poolExitButton.visible = false;
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc5_:ICharacter = _loc2_.myChar;
         if(_loc5_ != null)
         {
            _loc3_ = Sanalika.instance.engine.scene.elementsContainer.getChildByName(_loc2_.myChar.gameZoneId) as GamePool;
            if(_loc3_ != null && _loc5_.cell != null)
            {
               _loc4_ = _loc5_.cell.getFrontPos(Sanalika.instance.engine.scene);
               _loc5_.walkRequest(_loc4_.x,_loc4_.y);
               Sanalika.instance.serviceModel.setUserVariable(["direction","status"],[_loc5_.direction,"i"]);
            }
         }
      }
      
      private function hidePoolExitButton(param1:PoolEvent) : void
      {
         if(poolExitButton)
         {
            poolExitButton.visible = false;
         }
      }
      
      public function onSceneResize(param1:GameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         hud.x = Sanalika.instance.gameModel.canvasWidth / 2;
         hud.y = Sanalika.instance.layerModel.canvasHeight;
         hud.menuBg.width = Sanalika.instance.layerModel.canvasWidth;
         hud.menuContainer.scaleX = Sanalika.instance.scaleModel.uiScale;
         hud.menuContainer.scaleY = Sanalika.instance.scaleModel.uiScale;
         hud.chatBg.scaleX = Sanalika.instance.scaleModel.uiScale;
         hud.chatBg.scaleY = Sanalika.instance.scaleModel.uiScale;
         hud.inputText.scaleX = Sanalika.instance.scaleModel.uiScale;
         hud.inputText.scaleY = Sanalika.instance.scaleModel.uiScale;
         hud.whisperMc.scaleX = Sanalika.instance.scaleModel.uiScale;
         hud.whisperMc.scaleY = Sanalika.instance.scaleModel.uiScale;
         hud.colorPanel.scaleX = Sanalika.instance.scaleModel.uiScale;
         hud.colorPanel.scaleY = Sanalika.instance.scaleModel.uiScale;
         hud.colorPanel.x = -hud.colorPanel.width / 2;
         hud.colorPanel.y = 0;
         if(Sanalika.instance.layerModel.hudLayer.x > 0)
         {
            balanceView.x = Sanalika.instance.layerModel.canvasWidth - 246 * Sanalika.instance.scaleModel.uiScale;
         }
         balanceView.y = 10;
         if(poolExitButton)
         {
            poolExitButton.x = Sanalika.instance.gameModel.canvasWidth - poolExitButton.width - 10;
            poolExitButton.y = Sanalika.instance.gameModel.canvasHeight - poolExitButton.height - 10;
         }
         if(tutorialExitButton)
         {
            tutorialExitButton.x = Sanalika.instance.gameModel.canvasWidth - tutorialExitButton.width - 10;
            tutorialExitButton.y = Sanalika.instance.gameModel.canvasHeight - tutorialExitButton.height - 10;
         }
         if(Sanalika.instance.scaleModel.isLandscape && hud.menuBg.width > 780 * Sanalika.instance.scaleModel.uiScale || Sanalika.instance.airModel.isDesktop())
         {
            if(Sanalika.instance.airModel.isMobile())
            {
               Sanalika.instance.layerModel.hudHeight = defaultHudHeight;
            }
            trace("--------------------!***!---------------------");
            hud.menuContainer.cell.restore();
            hud.menuContainer.friend.restore();
            hud.menuContainer.cloth.restore();
            hud.menuContainer.inventory.restore();
            hud.menuContainer.smiley.restore();
            hud.menuContainer.achievement.restore();
            hud.menuContainer.island.restore();
            hud.menuContainer.setting.restore();
            hud.menuBg.height = 60 * Sanalika.instance.scaleModel.uiScale;
         }
         else
         {
            if(Sanalika.instance.airModel.isMobile())
            {
               Sanalika.instance.layerModel.hudHeight = defaultHudHeight * 2.5;
            }
            trace("--------------------!!---------------------");
            _loc2_ = -50;
            _loc3_ = 50;
            hud.menuContainer.cell.move(4 * _loc2_,_loc3_);
            hud.menuContainer.friend.move(3 * _loc2_,_loc3_);
            hud.menuContainer.cloth.move(2 * _loc2_,_loc3_);
            hud.menuContainer.inventory.move(1 * _loc2_,_loc3_);
            hud.menuContainer.smiley.move(0,_loc3_);
            hud.menuContainer.achievement.move(-1 * _loc2_,_loc3_);
            hud.menuContainer.island.move(-2 * _loc2_,_loc3_);
            hud.menuContainer.setting.move(-3 * _loc2_,_loc3_);
            hud.menuBg.height = 110 * Sanalika.instance.scaleModel.uiScale;
         }
         hud.menuContainer.getChildByName("settingsView").x = hud.menuContainer.setting.x + 30;
         hud.chatBg.x = -140 * Sanalika.instance.scaleModel.uiScale;
         hud.whisperMc.x = -140 * Sanalika.instance.scaleModel.uiScale;
         if(hud.whisperMc.visible)
         {
            hud.inputText.x = (-131 + hud.whisperText.x + hud.whisperText.width) * Sanalika.instance.scaleModel.uiScale;
         }
         else
         {
            hud.inputText.x = -131 * Sanalika.instance.scaleModel.uiScale;
         }
         hud.inputText.y = 9 * Sanalika.instance.scaleModel.uiScale;
      }
      
      private function transitionOutStarted(param1:GameEvent) : void
      {
         hud.mouseChildren = false;
         hud.mouseEnabled = false;
         hud.visible = false;
         Dispatcher.dispatchEvent(new HudEvent("HudEvent.HIDE_BALANCE_VIEW"));
         if(broadcastButton)
         {
            TweenMax.to(broadcastButton,0.2,{
               "autoAlpha":0,
               "ease":Sine.easeOut
            });
         }
         if(businessMenu)
         {
            businessMenu.visible = false;
            businessMenu.scaleX = Sanalika.instance.scaleModel.uiScale;
            businessMenu.scaleY = Sanalika.instance.scaleModel.uiScale;
            businessMenu.x = -businessMenu.width;
            businessMenu.y = (Sanalika.instance.gameModel.canvasHeight - businessMenu.height) / 2;
         }
         if(poolExitButton)
         {
            poolExitButton.visible = false;
         }
      }
      
      private function sceneLoaded(param1:GameEvent) : void
      {
         hud.visible = true;
         hud.mouseChildren = true;
         hud.mouseEnabled = true;
         if(Sanalika.instance.airModel.isAir())
         {
            zoomInButton = new ZoomInButton();
            zoomOutButton = new ZoomOutButton();
            zoomInButton.x = avatarView.x + 100;
            zoomOutButton.x = zoomInButton.x + 60;
            zoomInButton.y = zoomOutButton.y = -5;
            zoomInButton.addEventListener("click",zoomInClicked);
            zoomOutButton.addEventListener("click",zoomOutClicked);
            avatarView.addChild(zoomInButton);
            avatarView.addChild(zoomOutButton);
         }
         if(businessMenu)
         {
            businessMenu.visible = true;
            businessMenu.scaleX = Sanalika.instance.scaleModel.uiScale;
            businessMenu.scaleY = Sanalika.instance.scaleModel.uiScale;
         }
         if(Sanalika.instance.roomModel.ownerId != null)
         {
            if(businessMenu == null)
            {
               businessMenu = new BusinessMenu();
               businessMenu.scaleX = Sanalika.instance.scaleModel.uiScale;
               businessMenu.scaleY = Sanalika.instance.scaleModel.uiScale;
               Sanalika.instance.layerModel.hudLayer.addChild(businessMenu);
               if(Sanalika.instance.layerModel.hudLayer.x > businessMenu.width)
               {
                  businessMenu.x = -businessMenu.width;
               }
               else
               {
                  businessMenu.x = -Sanalika.instance.layerModel.hudLayer.x;
               }
               businessMenu.y = (Sanalika.instance.gameModel.canvasHeight - businessMenu.height) / 2;
            }
            businessMenu.init();
         }
         else if(businessMenu)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(businessMenu);
            businessMenu = null;
         }
      }
      
      private function zoomInClicked(param1:MouseEvent) : void
      {
         var _loc2_:HudEvent = new HudEvent("HudEvent.ZOOM_IN");
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      private function zoomOutClicked(param1:MouseEvent) : void
      {
         var _loc2_:HudEvent = new HudEvent("HudEvent.ZOOM_OUT");
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      private function transitionCompleted(param1:GameEvent) : void
      {
         if(visible)
         {
            Dispatcher.dispatchEvent(new HudEvent("HudEvent.SHOW_BALANCE_VIEW"));
         }
         if(broadcastButton)
         {
            TweenMax.to(broadcastButton,0.2,{
               "autoAlpha":1,
               "ease":Sine.easeOut
            });
         }
      }
      
      private function openRoomInfo(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = null;
         if(Sanalika.instance.roomModel.ownerId != null)
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "BusinessInfoPanel";
            _loc2_.type = "room";
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      private function openRoomListPanel(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = null;
         if(Sanalika.instance.roomModel.buildingData != null)
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "RoomListPanel";
            _loc2_.type = "static";
            _loc2_.params = Sanalika.instance.roomModel.buildingData;
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      private function openOrderPanel(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = null;
         if(Sanalika.instance.roomModel.buildingData != null)
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "GameOrderPanel";
            _loc2_.type = "hud";
            _loc2_.params = Sanalika.instance.roomModel.buildingData;
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      private function openRestrictedListPanel(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = null;
         if(Sanalika.instance.roomModel.buildingData != null)
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "RestrictedListPanel";
            _loc2_.type = "hud";
            _loc2_.params = Sanalika.instance.roomModel.buildingData;
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      private function sendBusinessMessage(param1:HudEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc6_:int = 0;
         var _loc4_:int = Sanalika.instance.layerModel.businessMessageLayer.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = Sanalika.instance.layerModel.businessMessageLayer.getChildAt(_loc6_);
            if(_loc2_ is BusinessMessage)
            {
               if((_loc2_ as BusinessMessage).writemode)
               {
                  return;
               }
            }
            _loc6_++;
         }
         var _loc5_:BusinessMessage = new BusinessMessage(true);
         _loc5_.scaleX = Sanalika.instance.scaleModel.uiScale;
         _loc5_.scaleY = Sanalika.instance.scaleModel.uiScale;
         var _loc3_:BusinessMessageEvent = new BusinessMessageEvent("BusinessMessageEvent.ADD_BUSINESS_MESSAGE");
         _loc3_.view = _loc5_;
         Dispatcher.dispatchEvent(_loc3_);
      }
      
      private function openRoomDesign(param1:HudEvent) : void
      {
         var vo:AlertVo;
         var event:HudEvent = param1;
         if(Sanalika.instance.matchmakingModel.isMatchmaking)
         {
            vo = new AlertVo();
            vo.alertType = "tooltip";
            vo.callBack = function(param1:int):*
            {
               if(param1 == 2)
               {
                  Sanalika.instance.engine.loadIsoDesigner();
               }
            };
            vo.description = Sanalika.instance.localizationModel.translate("You cannot design a room while matching for a game.");
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else
         {
            Sanalika.instance.engine.loadIsoDesigner();
         }
      }
      
      private function openSanilPurchasePanel(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "PaymentPanel";
         _loc2_.params = {};
         _loc2_.params.booth = "SANIL";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openDiamondPurchasePanel(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "PaymentPanel";
         _loc2_.params = {};
         _loc2_.params.booth = "DIAMOND";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openProductPurchasePanel(param1:HudEvent) : void
      {
         if(ExternalInterface.available)
         {
            if(Sanalika.instance.layerModel.stage.displayState == "fullScreen" || Sanalika.instance.layerModel.stage.displayState == "fullScreenInteractive")
            {
               Sanalika.instance.layerModel.stage.displayState = "normal";
            }
            ExternalInterface.call("Sanalika.openProductPurchasePanel");
         }
         else if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
         {
            navigateToURL(new URLRequest(Sanalika.instance.gameModel.webServer + "/payment"));
         }
      }
      
      private function openAvatarSwitchPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.params = {};
         _loc2_.name = "AvatarSwitchPanel";
         _loc2_.type = "static";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openMapPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.params = {};
         _loc2_.name = "MapPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openAchievementPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "AchievementPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      public function setQuestIndicator(param1:int) : void
      {
         if(questIndicator)
         {
            questIndicator.balanceUpdate(Sanalika.instance.avatarModel.stepCount.toString());
         }
      }
      
      private function showIndicator(param1:HudEvent = null) : void
      {
         if(!questIndicator)
         {
            questIndicator = new QuestIndicator();
            questIndicator.x = -124;
            TweenMax.to(questIndicator,0,{"glowFilter":{
               "color":0,
               "alpha":0.4,
               "blurX":4,
               "blurY":4,
               "strength":1
            }});
            balanceView.addChild(questIndicator);
         }
         questIndicator.balanceUpdate(Sanalika.instance.avatarModel.stepCount.toString());
      }
      
      private function hideIndicator(param1:HudEvent = null) : void
      {
         if(questIndicator)
         {
            balanceView.removeChild(questIndicator);
         }
      }
      
      private function showFunwin(param1:HudEvent = null) : void
      {
         if(!funwin)
         {
            funwin = new FunwinButton();
            funwin.x = topLocationX;
            topLocationX += -40;
            funwin.y = -4;
            funwin.addEventListener("click",openCellphoneFun);
            funwin.buttonMode = true;
            TweenMax.to(funwin,0,{"glowFilter":{
               "color":16777215,
               "alpha":1,
               "blurX":2,
               "blurY":2,
               "strength":6
            }});
            TweenMax.to(funwin,0.3,{
               "glowFilter":{
                  "color":16777215,
                  "alpha":1,
                  "blurX":8,
                  "blurY":8,
                  "strength":6
               },
               "repeat":33,
               "yoyo":true
            });
            balanceView.addChild(funwin);
         }
      }
      
      private function hideFunwin(param1:HudEvent = null) : void
      {
         topLocationX += 40;
         if(funwin && balanceView && balanceView.getChildIndex(funwin) > 0)
         {
            balanceView.removeChild(funwin);
            funwin = null;
         }
      }
      
      private function showFunbid(param1:HudEvent = null) : void
      {
         if(!funbidButton)
         {
            funbidButton = new FunbidButton();
            funbidButton.x = topLocationX;
            topLocationX += -40;
            funbidButton.y = -4;
            funbidButton.addEventListener("click",openCellphoneFun);
            funbidButton.buttonMode = true;
            TweenMax.to(funbidButton,0,{"glowFilter":{
               "color":16777215,
               "alpha":1,
               "blurX":2,
               "blurY":2,
               "strength":6
            }});
            TweenMax.to(funbidButton,0.3,{
               "glowFilter":{
                  "color":16777215,
                  "alpha":1,
                  "blurX":8,
                  "blurY":8,
                  "strength":6
               },
               "repeat":33,
               "yoyo":true
            });
            balanceView.addChild(funbidButton);
         }
      }
      
      private function hideFunbid(param1:HudEvent = null) : void
      {
         topLocationX += 40;
         if(funbidButton && balanceView && balanceView.getChildIndex(funbidButton) > 0)
         {
            balanceView.removeChild(funbidButton);
            funbidButton = null;
         }
      }
      
      private function showMatchmaking(param1:HudEvent = null) : void
      {
         var event:HudEvent = param1;
         if(matchmakingButton == null)
         {
            matchmakingButton = new MatchmakingButton();
            matchmakingButton.x = topLocationX - 44;
            topLocationX -= 94;
            matchmakingButton.y = -4;
            matchmakingButton.addEventListener("click",function(param1:MouseEvent):void
            {
               var e:MouseEvent = param1;
               var vo:AlertVo = new AlertVo();
               vo.alertType = "Confirm";
               vo.callBack = function(param1:int):void
               {
                  if(param1 == 2)
                  {
                     Sanalika.instance.matchmakingModel.cancel();
                  }
               };
               vo.description = Sanalika.instance.localizationModel.translate("Matchmaking will be cancelled");
               Dispatcher.dispatchEvent(new AlertEvent(vo));
            });
            matchmakingButton.buttonMode = true;
            balanceView.addChild(matchmakingButton);
         }
      }
      
      private function hideMatchmaking(param1:HudEvent = null) : void
      {
         if(matchmakingButton != null && balanceView != null && balanceView.getChildIndex(matchmakingButton) > 0)
         {
            topLocationX += 94;
            balanceView.removeChild(matchmakingButton);
            matchmakingButton = null;
         }
      }
      
      private function showRadio(param1:HudEvent = null) : void
      {
         var _loc2_:Object = null;
         if(!broadcastButton)
         {
            broadcastButton = new Radio();
            broadcastButton.x = topLocationX;
            topLocationX += -40;
            broadcastButton.y = -4;
            Sanalika.instance.toolTipModel.addTip(broadcastButton,$("Broadcast"));
            broadcastButton.addEventListener("click",muteBroadcast);
            isBroadcast = 1;
            TweenMax.to(broadcastButton,0,{"glowFilter":{
               "color":16777215,
               "alpha":1,
               "blurX":2,
               "blurY":2,
               "strength":6
            }});
            TweenMax.to(broadcastButton,0.3,{
               "glowFilter":{
                  "color":16777215,
                  "alpha":1,
                  "blurX":8,
                  "blurY":8,
                  "strength":6
               },
               "repeat":33,
               "yoyo":true
            });
            balanceView.addChild(broadcastButton);
            _loc2_ = {};
            _loc2_.groupName = null;
            _loc2_.stream_path = streamPath;
            Sanalika.instance.concertModel.playMedia(_loc2_,true);
         }
         onSceneResize(null);
      }
      
      private function showNewyear(param1:HudEvent = null) : void
      {
      }
      
      private function hideNewyear(param1:HudEvent = null) : void
      {
      }
      
      private function hideRadio(param1:HudEvent = null) : void
      {
         if(broadcastButton && balanceView && balanceView.getChildIndex(broadcastButton) > 0)
         {
            topLocationX += 40;
            balanceView.removeChild(broadcastButton);
            broadcastButton = null;
         }
      }
      
      private function showSnowball(param1:HudEvent = null) : void
      {
         trace("showSnowball");
      }
      
      private function hideSnowball(param1:HudEvent = null) : void
      {
         trace("hideSnowball");
      }
      
      private function throwItem(param1:HudEvent = null) : void
      {
         param1.xTarget;
         param1.yTarget;
         param1.clipTarget;
      }
      
      private function muteBroadcast(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(isBroadcast == 1)
         {
            TweenMax.to(broadcastButton,1,{"colorMatrixFilter":{"saturation":0}});
            isBroadcast = 0;
            Sanalika.instance.concertModel.disposeMedia(0);
         }
         else
         {
            TweenMax.to(broadcastButton,1,{"colorMatrixFilter":{"saturation":1}});
            isBroadcast = 1;
            _loc2_ = {};
            _loc2_.groupName = null;
            _loc2_.stream_path = streamPath;
            Sanalika.instance.concertModel.playMedia(_loc2_,true);
         }
      }
      
      private function openCellphoneFun(param1:MouseEvent) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "CellPhonePanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openCellPhone(param1:HudEvent) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "CellPhonePanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openClothPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "ClothPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      public function openInventoryPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "InventoryPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openIslandsPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "UniversePanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openSettingsPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "SettingsPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openSharePanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "SharePanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openInvitePanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "InvitePanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openSmileyPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "SmileyPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      public function showHideHud() : void
      {
         visible = !visible;
      }
      
      public function openBuddyPanel(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.params = {};
         _loc2_.params.page = "buddy";
         _loc2_.name = "BuddyListPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function openChatHistory(param1:HudEvent = null) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.name = "ChatHistoryPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function changeChatColorRequest(param1:HudEvent) : void
      {
         if(Sanalika.instance.chatModel.whisperMode)
         {
            return;
         }
         Sanalika.instance.serviceModel.requestData("usechatballoon",{"id":param1.colorId},changeChatColorResponse);
      }
      
      private function changeChatColorResponse(param1:Object) : void
      {
      }
      
      public function dispose() : void
      {
         if(broadcastButton)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(broadcastButton);
         }
         if(funwin)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(funwin);
         }
         if(zoomInButton)
         {
            avatarView.removeChild(zoomInButton);
         }
         if(zoomOutButton)
         {
            avatarView.removeChild(zoomOutButton);
         }
         if(avatarView)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(avatarView);
         }
         if(balanceView)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(balanceView);
         }
         if(hud)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(hud);
         }
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+SHIFT+S");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+1");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+2");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+3");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+4");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+5");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+6");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+7");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+8");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+0");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+37");
         Sanalika.instance.keyboardModel.clearKeyMapping("CTRL+39");
         removeHudEvents();
         Dispatcher.removeEventListener("RESIZE",onSceneResize);
         if(hud.inputText)
         {
            hud.inputText.removeEventListener("focusIn",focusIn);
            hud.inputText.removeEventListener("focusOut",focusOut);
         }
         Dispatcher.removeEventListener("UI_SCALE_CHANGED",onUIScaleChanged);
         Dispatcher.removeEventListener("PoolEvent.SHOW_EXIT_BUTTON",showPoolExitButton);
         Dispatcher.removeEventListener("PoolEvent.HIDE_EXIT_BUTTON",hidePoolExitButton);
         Dispatcher.removeEventListener("RESIZE",onSceneResize);
         Dispatcher.removeEventListener("HudEvent.SHOW_BALANCE_VIEW",onShowBW);
         Dispatcher.removeEventListener("HudEvent.HIDE_BALANCE_VIEW",onHideBW);
         Dispatcher.removeEventListener("TRANSITION_IN_COMPLETE",transitionCompleted);
         Dispatcher.removeEventListener("TRANSITION_OUT",transitionOutStarted);
         Dispatcher.removeEventListener("SCENE_LOADED",sceneLoaded);
         Dispatcher.removeEventListener("RESIZE",sceneResize);
      }
   }
}

