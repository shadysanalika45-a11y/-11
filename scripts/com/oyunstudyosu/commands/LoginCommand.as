package com.oyunstudyosu.commands
{
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.local.LocalTranslation;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.utils.Logger;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.data.SFSObject;
   import com.smartfoxserver.v2.requests.LoginRequest;
   import com.smartfoxserver.v2.util.SFSErrorCodes;
   import flash.globalization.DateTimeFormatter;
   import flash.system.Capabilities;
   import flash.utils.setTimeout;
   
   public class LoginCommand extends Command
   {
      
      private static const ALLOWED_LOGIN_REQUEST_RATE:int = 3000;
      
      private static var lastLoginTimestamp:Number = 0;
      
      private var sfs:SmartFox;
      
      private var _progress:Boolean;
      
      public function LoginCommand(param1:* = true)
      {
         super();
         _progress = param1;
         sfs = Sanalika.instance.serviceModel.sfs;
         sfs.addEventListener("login",onLogin);
         sfs.addEventListener("loginError",onLoginError);
      }
      
      override public function execute() : void
      {
         var _loc3_:LoginRequest = null;
         var _loc4_:int = 0;
         var _loc2_:ISFSObject = new SFSObject();
         _loc2_.putUtfString("token",Sanalika.instance.avatarModel.accessToken);
         _loc2_.putUtfString("fbToken",Sanalika.instance.avatarModel.fbToken);
         _loc2_.putUtfString("location",Sanalika.instance.avatarModel.location);
         _loc2_.putUtfString("platform",Sanalika.instance.avatarModel.platform);
         setClient(_loc2_);
         _loc2_.putUtfString("agent",Sanalika.instance.gameModel.agentData);
         SFSErrorCodes.setErrorMessage(4,"{0}");
         if(Sanalika.instance.avatarModel.accessToken == "")
         {
            _loc2_ = new SFSObject();
            _loc2_.putUtfString("agent",Sanalika.instance.gameModel.agentData);
            setClient(_loc2_);
            _loc3_ = new LoginRequest("","",Sanalika.instance.gameModel.serverName,_loc2_);
         }
         else
         {
            _loc3_ = new LoginRequest("","",Sanalika.instance.gameModel.serverName,_loc2_);
         }
         var _loc1_:Number = Number(new Date().getTime());
         trace("ts: " + _loc1_);
         if(lastLoginTimestamp == 0 || _loc1_ > lastLoginTimestamp + 3000)
         {
            sfs.send(_loc3_);
         }
         else
         {
            _loc4_ = lastLoginTimestamp + 3000 - _loc1_;
            trace("setTimeout: " + _loc4_);
            setTimeout(sfs.send,_loc4_,_loc3_);
         }
         Cc.info(JSON.stringify(_loc2_.toObject()));
         Cc.info("LoginRequest senttt!");
      }
      
      private function setClient(param1:ISFSObject) : *
      {
         if(Capabilities.isDebugger)
         {
            param1.putUtfString("client","debugger");
         }
         else if(!Sanalika.instance.airModel.isAir())
         {
            param1.putUtfString("client","web");
         }
         else if(Sanalika.instance.airModel.isAir() && !Sanalika.instance.airModel.isMobile())
         {
            param1.putUtfString("client","desktop");
         }
         else if(Sanalika.instance.airModel.isMobile())
         {
            param1.putUtfString("client","mobile");
         }
         else
         {
            param1.putUtfString("client","undefined");
         }
      }
      
      private function a() : int
      {
         return 123456789;
      }
      
      private function onUdpInit(param1:SFSEvent) : void
      {
         if(param1.params.success)
         {
            Cc.info("UDP ready!");
         }
         else
         {
            Cc.warn("UDP is not ready.");
         }
      }
      
      private function onLogin(param1:SFSEvent) : void
      {
         lastLoginTimestamp = new Date().getTime();
         Cc.info("onLogin");
         if(Sanalika.instance.airModel.isAir())
         {
         }
         trace("sfs logged in");
         var _loc2_:ISFSObject = param1.params.data;
         Sanalika.instance.serviceModel.activate();
         if(_progress)
         {
            Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.LOGINED));
         }
         Dispatcher.dispatchEvent(new GameEvent("INITIALIZE"));
         complete();
         dispose();
      }
      
      private function onLoginError(param1:SFSEvent) : void
      {
         var _loc7_:* = undefined;
         var _loc12_:int = 0;
         var _loc5_:Number = NaN;
         var _loc3_:Date = null;
         var _loc11_:DateTimeFormatter = null;
         var _loc6_:String = null;
         var _loc2_:int = 0;
         var _loc10_:String = null;
         lastLoginTimestamp = new Date().getTime();
         Cc.error("onLoginError");
         Logger.log("Login Error: " + param1.params.errorMessage,true);
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.PROGRESS_FULL));
         var _loc8_:AlertVo = new AlertVo();
         if((param1.params.errorMessage.indexOf("tokenNotValid") != -1 || param1.params.errorMessage.indexOf("TOKEN_NOT_VALID") != -1) && Sanalika.instance.stage.loaderInfo.applicationDomain.hasDefinition("com.oyunstudyosu.air.controller.DataStorageController"))
         {
            _loc7_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.air.controller.DataStorageController") as Class;
            Sanalika.instance.avatarModel.accessToken = "";
            _loc7_._SafeStr_1("instance",null);
            _loc7_._SafeStr_1("token",null);
            execute();
            return;
         }
         var _loc9_:int = int(param1.params.errorCode);
         var _loc4_:String = param1.params.errorMessage;
         switch(_loc9_ - 4)
         {
            case 0:
               _loc8_.alertType = "Error";
               _loc8_.title = LocalTranslation.translate("LOGIN_ERROR_TITLE");
               _loc12_ = int(_loc4_.indexOf(" "));
               if(_loc12_ == -1)
               {
                  _loc12_ = _loc4_.length;
               }
               _loc5_ = parseFloat(_loc4_.substring(0,_loc12_));
               _loc3_ = new Date(_loc5_);
               _loc11_ = new DateTimeFormatter("en-US");
               _loc11_.setDateTimePattern("yyyy-MM-dd HH:mm:ss");
               _loc6_ = _loc11_.format(_loc3_).toString();
               _loc2_ = _loc12_ + 1;
               if(_loc2_ >= _loc4_.length)
               {
                  _loc8_.description = LocalTranslation.translate("LOGIN_BANNED_USER",_loc6_);
               }
               else
               {
                  _loc10_ = _loc4_.substring(_loc2_,_loc4_.length);
                  _loc8_.description = LocalTranslation.translate("LOGIN_BANNED_USER_WITH_REASON",_loc6_,LocalTranslation.translate(_loc10_));
               }
               _loc8_.callBack = bannedCallback;
               Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
               break;
            default:
               _loc8_.alertType = "Error";
               _loc8_.title = _loc9_ == 10000 ? LocalTranslation.translate("LOGIN_ACCOUNT_REVIEWING_TITLE") : LocalTranslation.translate("LOGIN_ERROR_TITLE");
               _loc8_.description = _loc4_;
               Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
         }
         dispose();
      }
      
      private function bannedCallback(param1:int) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.callBack = logoutCallback;
         _loc2_.alertType = "Confirm";
         _loc2_.title = LocalTranslation.translate("Do you want logout?");
         _loc2_.description = LocalTranslation.translate("You will be logged out.");
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function logoutCallback(param1:int) : void
      {
         var _loc3_:* = undefined;
         var _loc7_:* = undefined;
         var _loc5_:Class = null;
         var _loc9_:Class = null;
         var _loc10_:Class = null;
         var _loc4_:Class = null;
         var _loc13_:XML = null;
         var _loc8_:Namespace = null;
         var _loc6_:String = null;
         var _loc12_:* = undefined;
         var _loc11_:* = undefined;
         var _loc2_:* = undefined;
         if(param1 == 2)
         {
            if(Sanalika.instance.stage.loaderInfo.applicationDomain.hasDefinition("com.oyunstudyosu.air.controller.DataStorageController"))
            {
               _loc3_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.air.controller.DataStorageController") as Class;
               _loc3_._SafeStr_1("token",null);
            }
            if(Sanalika.instance.airModel.isMobile())
            {
               _loc7_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.restart.RestartApplication") as Class;
               _loc7_.restart();
            }
            else
            {
               _loc5_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("flash.filesystem.File") as Class;
               _loc9_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeApplication") as Class;
               _loc10_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeProcessStartupInfo") as Class;
               _loc4_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeProcess") as Class;
               _loc13_ = _loc9_.nativeApplication.applicationDescriptor;
               _loc8_ = new Namespace(_loc13_.namespace());
               _loc6_ = _loc13_._loc8_::filename;
               _loc12_ = new _loc10_();
               _loc11_ = new _loc4_();
               if(Capabilities.os.indexOf("Win") > -1)
               {
                  _loc2_ = new _loc5_(_loc5_.applicationDirectory.nativePath + "/" + _loc6_ + ".exe");
               }
               else
               {
                  _loc2_ = new _loc5_(_loc5_.applicationDirectory.nativePath.replace("Resources","MacOS/" + _loc6_));
               }
               _loc12_.executable = _loc2_;
               _loc11_.start(_loc12_);
               _loc9_.nativeApplication.exit();
            }
         }
      }
      
      private function dispose() : void
      {
         sfs.removeEventListener("login",onLogin);
         sfs.removeEventListener("loginError",onLoginError);
         sfs = null;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 */
