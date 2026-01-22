package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertType;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.components.CloseButton;
   import com.oyunstudyosu.enums.RequestDataKey;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.local.arabic.ArabicInputManager;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import org.oyunstudyosu.alert.IAlertView;
   import org.oyunstudyosu.alert.buttons.RedButton;
   import org.oyunstudyosu.alert.buttons.YellowButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol271")]
   public class RoomChangePasswordView extends CoreMovieClip implements IAlertView
   {
      
      public var background:MovieClip;
      
      public var quantityBg:MovieClip;
      
      public var txtAge:TextField;
      
      public var txtVip:TextField;
      
      public var txtVisitor:TextField;
      
      public var btnClose:CloseButton;
      
      public var btnOk:YellowButton;
      
      public var btnReset:RedButton;
      
      public var keyTxt:TextField;
      
      public var lbl_Title:TextField;
      
      public var password:String;
      
      public var vip:int;
      
      public var plus18:int;
      
      public var notVisitor:int;
      
      private var defaultTxt:String;
      
      private var errorVo:AlertVo;
      
      private var sessionID:String;
      
      public var mcDragger:MovieClip;
      
      public var checkboxVip:MovieClip;
      
      public var checkboxAge:MovieClip;
      
      public var checkboxVisitor:MovieClip;
      
      public var sTxtAge:STextField;
      
      public var sTxtVip:STextField;
      
      public var sTxtVisitor:STextField;
      
      private var inputManager:ArabicInputManager;
      
      private var _vo:IAlertVo;
      
      public function RoomChangePasswordView()
      {
         visible = false;
         super();
      }
      
      public function dragger() : MovieClip
      {
         return this.mcDragger;
      }
      
      public function init() : void
      {
         visible = false;
         this.btnOk.setText($("Save"));
         this.btnReset.setText($("Remove"));
         this.sessionID = this.vo.secretSession;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         this.btnReset.addEventListener(MouseEvent.CLICK,this.resetClicked);
         this.defaultTxt = $("Room Password");
         this.keyTxt.maxChars = 60;
         this.keyTxt.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.keyTxt.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.checkboxVip.addEventListener(MouseEvent.CLICK,this.onCheckVip);
         this.checkboxAge.addEventListener(MouseEvent.CLICK,this.onCheckAge);
         this.checkboxVisitor.addEventListener(MouseEvent.CLICK,this.onCheckVisitor);
         if(this.sTxtAge == null)
         {
            this.sTxtAge = TextFieldManager.convertAsArabicTextField(getChildByName("txtAge") as TextField,false,false);
            this.sTxtVip = TextFieldManager.convertAsArabicTextField(getChildByName("txtVip") as TextField,false,false);
            this.sTxtVisitor = TextFieldManager.convertAsArabicTextField(getChildByName("txtVisitor") as TextField,false,false);
            this.lbl_Title = TextFieldManager.convertAsArabicTextField(this.lbl_Title);
            if(Connectr.instance.gameModel.language == "ar")
            {
               this.inputManager = new ArabicInputManager(this.keyTxt,this.keyTxt.defaultTextFormat);
            }
         }
         this.lbl_Title.text = this.vo.title;
         this.sTxtVip.addEventListener(MouseEvent.CLICK,this.onCheckVip);
         this.sTxtAge.addEventListener(MouseEvent.CLICK,this.onCheckAge);
         this.sTxtAge.htmlText = $("roomAgeRestriction");
         this.sTxtVip.htmlText = $("roomVipRestriction");
         this.sTxtVisitor.htmlText = $("roomVisitorRestriction");
         this.checkboxVip.gotoAndStop(1);
         this.vip = 0;
         this.checkboxVip.gotoAndStop(1);
         this.plus18 = 0;
         Connectr.instance.serviceModel.requestData(RequestDataKey.ROOM_SETTINGS,{},this.onSettingResponse);
      }
      
      protected function onSettingResponse(param1:Object) : void
      {
         if(param1.passwordSet)
         {
            this.defaultTxt = "*******";
         }
         else
         {
            this.btnReset.visible = false;
            this.btnOk.x = (this.width / this.scaleX - this.btnOk.width) / 2;
         }
         if(param1.vip)
         {
            this.checkboxVip.gotoAndStop(2);
            this.vip = 1;
         }
         if(param1.plus18)
         {
            this.checkboxAge.gotoAndStop(2);
            this.plus18 = 1;
         }
         if(param1.notVisitor)
         {
            this.checkboxVisitor.gotoAndStop(2);
            this.notVisitor = 1;
         }
         this.focusOut();
         visible = true;
      }
      
      protected function onCheckVip(param1:MouseEvent) : void
      {
         if(this.checkboxVip.currentFrame == 2)
         {
            this.checkboxVip.gotoAndStop(1);
            this.vip = 0;
         }
         else
         {
            this.checkboxVip.gotoAndStop(2);
            this.vip = 1;
         }
      }
      
      protected function onCheckAge(param1:MouseEvent) : void
      {
         if(this.checkboxAge.currentFrame == 2)
         {
            this.checkboxAge.gotoAndStop(1);
            this.plus18 = 0;
         }
         else
         {
            this.checkboxAge.gotoAndStop(2);
            this.plus18 = 1;
         }
      }
      
      protected function onCheckVisitor(param1:MouseEvent) : void
      {
         if(this.checkboxVisitor.currentFrame == 2)
         {
            this.checkboxVisitor.gotoAndStop(1);
            this.notVisitor = 0;
         }
         else
         {
            this.checkboxVisitor.gotoAndStop(2);
            this.notVisitor = 1;
         }
      }
      
      protected function focusOut(param1:FocusEvent = null) : void
      {
         var _loc2_:String = this.inputManager != null ? this.inputManager.getText() : this.keyTxt.text;
         if(_loc2_ == "")
         {
            this.keyTxt.displayAsPassword = false;
            if(this.inputManager != null)
            {
               this.inputManager.clearText();
               this.inputManager.addText(this.defaultTxt);
               this.inputManager.draw();
            }
            else
            {
               this.keyTxt.text = this.defaultTxt;
            }
         }
         try
         {
            Connectr.instance.layerModel.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
         }
         catch(e:Error)
         {
         }
      }
      
      protected function focusIn(param1:FocusEvent) : void
      {
         if(this.inputManager != null)
         {
            this.keyTxt.text = "";
            this.inputManager.changeFormat(this.keyTxt.defaultTextFormat);
         }
         else if(this.keyTxt.text == this.defaultTxt)
         {
            this.keyTxt.text = "";
         }
         this.keyTxt.displayAsPassword = true;
         Connectr.instance.layerModel.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
      
      protected function keyUpHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.checkValidation();
         }
      }
      
      protected function closeClicked(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("closeClicked"));
      }
      
      protected function okClicked(param1:MouseEvent) : void
      {
         this.checkValidation();
      }
      
      private function checkValidation() : void
      {
         this.password = "";
         var _loc1_:String = this.inputManager != null ? this.inputManager.getText() : this.keyTxt.text;
         if(_loc1_ != this.defaultTxt && _loc1_ != "")
         {
            if(_loc1_.length < 6)
            {
               this.errorVo = new AlertVo();
               this.errorVo.alertType = AlertType.TOOLTIP;
               this.errorVo.description = $("minimumRoomPasswordKeyLengthError");
               Dispatcher.dispatchEvent(new AlertEvent(this.errorVo));
               return;
            }
            if(_loc1_.length > 12)
            {
               this.errorVo = new AlertVo();
               this.errorVo.alertType = AlertType.TOOLTIP;
               this.errorVo.description = $("maximumRoomPasswordKeyLengthError");
               Dispatcher.dispatchEvent(new AlertEvent(this.errorVo));
               return;
            }
            this.password = _loc1_;
         }
         this.sendKey();
      }
      
      public function sendKey() : void
      {
         Connectr.instance.serviceModel.requestData(RequestDataKey.ROOM_CHANGE_PASSWORD,{
            "password":this.password,
            "vip":this.vip,
            "plus18":this.plus18,
            "notVisitor":this.notVisitor
         },this.roomPasswordResponse);
      }
      
      protected function resetClicked(param1:MouseEvent) : void
      {
         Connectr.instance.serviceModel.requestData(RequestDataKey.ROOM_CHANGE_PASSWORD,{"password":"-1"},this.roomPasswordResponse);
      }
      
      private function roomPasswordResponse(param1:Object) : void
      {
         Connectr.instance.serviceModel.removeRequestData(RequestDataKey.ROOM_CHANGE_PASSWORD,this.roomPasswordResponse);
         if(!param1.errorCode)
         {
            this.errorVo = new AlertVo();
            this.errorVo.alertType = AlertType.TOOLTIP;
            this.errorVo.description = $("roomSettingsSuccess");
            Dispatcher.dispatchEvent(new AlertEvent(this.errorVo));
            dispatchEvent(new Event("closeClicked"));
         }
      }
      
      public function get vo() : IAlertVo
      {
         return this._vo;
      }
      
      public function set vo(param1:IAlertVo) : void
      {
         if(this._vo == param1)
         {
            return;
         }
         this._vo = param1;
      }
      
      public function dispose() : void
      {
         this.sTxtVip.removeEventListener(MouseEvent.CLICK,this.onCheckVip);
         this.sTxtAge.removeEventListener(MouseEvent.CLICK,this.onCheckAge);
         this.checkboxVip.removeEventListener(MouseEvent.CLICK,this.onCheckVip);
         this.checkboxAge.removeEventListener(MouseEvent.CLICK,this.onCheckAge);
         this.keyTxt.removeEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.keyTxt.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.btnClose.removeEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.removeEventListener(MouseEvent.CLICK,this.okClicked);
         this.btnReset.removeEventListener(MouseEvent.CLICK,this.resetClicked);
         Connectr.instance.layerModel.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
   }
}

