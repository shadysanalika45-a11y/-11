package org.oyunstudyosu.settings
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertResponse;
   import com.oyunstudyosu.alert.AlertType;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.enums.AvatarPermission;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.SettingsEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelType;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.requests.LogoutRequest;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1489")]
   public class InGameSettingsView extends CoreMovieClip
   {
      
      public var soundOn:SimpleButton;
      
      public var soundOff:SimpleButton;
      
      public var fullScreen:SimpleButton;
      
      public var settings:SimpleButton;
      
      public var knight:SimpleButton;
      
      public var guide:SimpleButton;
      
      public var screenshot:SimpleButton;
      
      public var sanalikaMap:SimpleButton;
      
      public var gameExit:SimpleButton;
      
      private var menuList:Array;
      
      public function InGameSettingsView()
      {
         super();
      }
      
      override public function added() : void
      {
         this.fullScreen.addEventListener(MouseEvent.CLICK,this.fullScreenClicked);
         this.soundOn.addEventListener(MouseEvent.CLICK,this.soundOnClicked);
         this.soundOff.addEventListener(MouseEvent.CLICK,this.soundOffClicked);
         this.settings.addEventListener(MouseEvent.CLICK,this.settingsClicked);
         this.knight.addEventListener(MouseEvent.CLICK,this.knightClicked);
         this.guide.addEventListener(MouseEvent.CLICK,this.guideClicked);
         this.gameExit.addEventListener(MouseEvent.CLICK,this.exitClicked);
         this.screenshot.addEventListener(MouseEvent.CLICK,this.screenshotClicked);
         this.sanalikaMap.addEventListener(MouseEvent.CLICK,this.sanalikaMapClicked);
         Connectr.instance.toolTipModel.addTip(this.fullScreen,"FullScreen");
         Connectr.instance.toolTipModel.addTip(this.soundOn,"Sound On");
         Connectr.instance.toolTipModel.addTip(this.soundOff,"Sound Off");
         Connectr.instance.toolTipModel.addTip(this.settings,"Settings");
         Connectr.instance.toolTipModel.addTip(this.knight,"Knight Panel");
         Connectr.instance.toolTipModel.addTip(this.guide,"Guide Panel");
         Connectr.instance.toolTipModel.addTip(this.screenshot,"Screenshot");
         Connectr.instance.toolTipModel.addTip(this.sanalikaMap,"SanalikaMap");
         Connectr.instance.toolTipModel.addTip(this.gameExit,"Exit");
      }
      
      protected function screenshotClicked(param1:MouseEvent) : void
      {
         var _loc2_:GameEvent = new GameEvent(GameEvent.SS_IMAGE);
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      protected function sanalikaMapClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new HudEvent(HudEvent.OPEN_MAP_PANEL));
      }
      
      protected function knightClicked(param1:MouseEvent) : void
      {
         var _loc2_:PanelVO = null;
         var _loc3_:AlertVo = null;
         if(Connectr.instance.avatarModel.permission.check(AvatarPermission.CARD_SECURITY))
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "ComplaintPanel";
            _loc2_.type = PanelType.HUD;
            Connectr.instance.panelModel.openPanel(_loc2_);
            _loc2_ = null;
         }
         else
         {
            _loc3_ = new AlertVo();
            _loc3_.alertType = AlertType.TOOLTIP;
            _loc3_.description = $("Only for Knights");
            Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
            _loc3_ = null;
         }
      }
      
      protected function exitClicked(param1:MouseEvent) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = AlertType.CONFIRM;
         _loc2_.callBack = this.exitAnswer;
         _loc2_.description = $("You are about to logout");
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function onLogout(param1:SFSEvent) : void
      {
         trace("logout");
         Connectr.instance.restartApplication();
      }
      
      private function exitAnswer(param1:int) : void
      {
         var _loc2_:* = undefined;
         if(param1 == AlertResponse.OK)
         {
            trace("exitAnswer");
            Connectr.instance.serviceModel.sfs.addEventListener(SFSEvent.LOGOUT,this.onLogout);
            Connectr.instance.serviceModel.sfs.send(new LogoutRequest());
            if(!Connectr.instance.airModel.isAir())
            {
               navigateToURL(new URLRequest(Connectr.instance.gameModel.webServer + "/logout"),"_self");
            }
            else if(Connectr.instance.airModel.isAir())
            {
               if(stage.loaderInfo.applicationDomain.hasDefinition("com.oyunstudyosu.air.controller.DataStorageController"))
               {
                  _loc2_ = stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.air.controller.DataStorageController") as Class;
                  _loc2_._SafeStr_1("token",null);
               }
            }
         }
      }
      
      protected function guideClicked(param1:MouseEvent) : void
      {
         var _loc2_:PanelVO = null;
         var _loc3_:AlertVo = null;
         if(Connectr.instance.avatarModel.permission.check(AvatarPermission.CARD_GUIDE))
         {
            _loc2_ = new PanelVO();
            _loc2_.name = "GuidePanel";
            _loc2_.type = PanelType.HUD;
            Connectr.instance.panelModel.openPanel(_loc2_);
            _loc2_ = null;
         }
         else
         {
            _loc3_ = new AlertVo();
            _loc3_.alertType = AlertType.TOOLTIP;
            _loc3_.description = $("Only for Guides");
            Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
            _loc3_ = null;
         }
      }
      
      protected function settingsClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new HudEvent(HudEvent.OPEN_SETTINGS_PANEL));
      }
      
      public function update() : void
      {
         if(Connectr.instance.avatarModel.settings.muteSound)
         {
            this.soundOn.visible = false;
            this.soundOff.visible = true;
         }
         else
         {
            this.soundOn.visible = true;
            this.soundOff.visible = false;
         }
      }
      
      protected function soundOnClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.SOUND_ON));
         this.soundOff.visible = true;
         this.soundOn.visible = false;
      }
      
      protected function soundOffClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.SOUND_OFF));
         this.soundOff.visible = false;
         this.soundOn.visible = true;
      }
      
      protected function fullScreenClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.FULLSCREEN));
      }
      
      protected function zoomOutClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.ZOOM_OUT));
      }
      
      protected function zoomInClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.ZOOM_IN));
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 */
