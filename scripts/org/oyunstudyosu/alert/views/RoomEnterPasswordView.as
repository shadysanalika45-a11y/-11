package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertType;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.components.CloseButton;
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
   import org.oyunstudyosu.alert.buttons.YellowButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol274")]
   public class RoomEnterPasswordView extends CoreMovieClip implements IAlertView
   {
      
      public var background:MovieClip;
      
      public var quantityBg:MovieClip;
      
      public var btnClose:CloseButton;
      
      public var btnOk:YellowButton;
      
      public var keyTxt:TextField;
      
      public var lbl_Title:TextField;
      
      private var defaultTxt:String;
      
      private var errorVo:AlertVo;
      
      private var sessionID:String;
      
      public var mcDragger:MovieClip;
      
      private var inputManager:ArabicInputManager;
      
      private var sTitle:STextField;
      
      private var _vo:IAlertVo;
      
      public function RoomEnterPasswordView()
      {
         super();
      }
      
      public function dragger() : MovieClip
      {
         return this.mcDragger;
      }
      
      public function init() : void
      {
         this.btnOk.setText($("OK"));
         if(this.sTitle == null)
         {
            this.sTitle = TextFieldManager.convertAsArabicTextField(getChildByName("lbl_Title") as TextField,false,false);
            if(Connectr.instance.gameModel.language == "ar")
            {
               this.inputManager = new ArabicInputManager(this.keyTxt,this.keyTxt.defaultTextFormat);
            }
         }
         this.sTitle.centerText = this.vo.title;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         this.defaultTxt = $("Room Password");
         this.keyTxt.maxChars = 60;
         this.keyTxt.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.keyTxt.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.focusIn();
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
         Connectr.instance.layerModel.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
      
      protected function focusIn(param1:FocusEvent = null) : void
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
         this.vo.callBack("");
         dispatchEvent(new Event("closeClicked"));
      }
      
      protected function okClicked(param1:MouseEvent) : void
      {
         this.checkValidation();
      }
      
      private function checkValidation() : void
      {
         var _loc1_:String = this.inputManager != null ? this.inputManager.getText() : this.keyTxt.text;
         if(_loc1_ == this.defaultTxt || _loc1_ == "")
         {
            return;
         }
         if(_loc1_.length < 6)
         {
            this.errorVo = new AlertVo();
            this.errorVo.alertType = AlertType.TOOLTIP;
            this.errorVo.description = $("minimumRoomPasswordKeyLengthError");
            Dispatcher.dispatchEvent(new AlertEvent(this.errorVo));
         }
         else if(_loc1_.length > 12)
         {
            this.errorVo = new AlertVo();
            this.errorVo.alertType = AlertType.TOOLTIP;
            this.errorVo.description = $("maximumRoomPasswordKeyLengthError");
            Dispatcher.dispatchEvent(new AlertEvent(this.errorVo));
         }
         else
         {
            this.sendKey();
         }
      }
      
      public function sendKey() : void
      {
         var _loc1_:String = this.inputManager != null ? this.inputManager.getText() : this.keyTxt.text;
         this.vo.callBack(_loc1_);
         dispatchEvent(new Event("closeClicked"));
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
         this.keyTxt.removeEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.keyTxt.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.btnClose.removeEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.removeEventListener(MouseEvent.CLICK,this.okClicked);
         Connectr.instance.layerModel.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
   }
}

