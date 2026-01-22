package org.oyunstudyosu.business
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertType;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.cloth.ICharPreview;
   import com.oyunstudyosu.components.CloseButton;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.enums.RequestDataKey;
   import com.oyunstudyosu.events.BusinessMessageEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.local.arabic.ArabicInputManager;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import org.oyunstudyosu.alert.buttons.YellowButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1085")]
   public class BusinessMessage extends CoreMovieClip
   {
      
      public var readTf:TextField;
      
      public var writemode:Boolean;
      
      private var message:String;
      
      private var senderID:String;
      
      private var charPreview:ICharPreview;
      
      public var reportButton:SimpleButton;
      
      public var writeTf:TextField;
      
      public var btnClose:CloseButton;
      
      public var btnOk:YellowButton;
      
      public var preview:MovieClip;
      
      public var mcDragger:MovieClip;
      
      private var sRead:STextField;
      
      private var inputManager:ArabicInputManager;
      
      private var regexp:RegExp = /\s+/g;
      
      private var defaultText:String;
      
      public function BusinessMessage(param1:Boolean, param2:String = "", param3:String = "")
      {
         super();
         this.writemode = param1;
         this.message = param2;
         this.senderID = param3;
      }
      
      public function dragger() : MovieClip
      {
         return this.mcDragger;
      }
      
      override public function added() : void
      {
         var _loc1_:ICharacter = null;
         if(this.sRead == null)
         {
            this.sRead = TextFieldManager.convertAsArabicTextField(this.getChildByName("readTf") as TextField,true,true);
            this.sRead.width = 210;
            this.sRead.height = 63;
            this.sRead.x = 90;
            this.sRead.y = 38;
         }
         this.reportButton.visible = false;
         this.writeTf.visible = this.writemode;
         this.sRead.visible = !this.writemode;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.btnCloseClicked);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.sendOrOkClicked);
         this.defaultText = $("Write your message!");
         this.writeTf.text = this.defaultText;
         if(this.writemode)
         {
            Connectr.instance.layerModel.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyPressed);
         }
         if(Connectr.instance.gameModel.language == "ar")
         {
            this.inputManager = new ArabicInputManager(this.writeTf,this.writeTf.getTextFormat());
         }
         if(this.writemode)
         {
            this.btnOk.setText($("send"));
            _loc1_ = Connectr.instance.engine.scene.getAvatarById(Connectr.instance.avatarModel.avatarId);
            this.charPreview = Connectr.instance.clothModel.getNewCharPreview(this.preview,_loc1_);
            if(this.charPreview)
            {
               this.charPreview.rotate(3);
            }
            this.writeTf.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
            this.writeTf.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         }
         else
         {
            this.btnOk.setText($("OK"));
            this.readMessage();
         }
      }
      
      protected function focusOut(param1:FocusEvent) : void
      {
      }
      
      protected function focusIn(param1:FocusEvent) : void
      {
         if(this.inputManager)
         {
            this.inputManager.changeFormat(this.writeTf.defaultTextFormat);
         }
         this.writeTf.text = "";
      }
      
      protected function keyPressed(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.sendOrOkClicked(null);
         }
      }
      
      private function readMessage() : void
      {
         var _loc1_:ICharacter = null;
         if(this.message == null)
         {
            return;
         }
         if(this.message.length == 0)
         {
            return;
         }
         this.message = this.message.replace(this.regexp," ");
         if(this.senderID != "")
         {
            _loc1_ = Connectr.instance.engine.scene.getAvatarById(this.senderID);
            this.sRead.htmlText = "<font color=\"#5F7900\">" + _loc1_.avatarName + "</font> : " + this.message;
            this.sRead.width = 210;
            this.sRead.height = 63;
            this.charPreview = Connectr.instance.clothModel.getNewCharPreview(this.preview,_loc1_);
            if(this.charPreview)
            {
               this.charPreview.rotate(3);
            }
            if(_loc1_.isMe)
            {
            }
         }
      }
      
      private function reportButtonClicked(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         this.reportButton.visible = false;
         var _loc2_:PanelVO = new PanelVO("ReportPanel");
         _loc2_.params = {};
         _loc2_.params.lastMessage = this.message;
         _loc2_.params.avatarId = this.senderID;
         Connectr.instance.panelModel.openPanel(_loc2_);
      }
      
      private function sendOrOkClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.writemode)
         {
            if(this.inputManager)
            {
               _loc2_ = this.inputManager.getText();
               this.inputManager.clearText();
            }
            else
            {
               _loc2_ = this.writeTf.text;
            }
            if(_loc2_.length == 0)
            {
               return;
            }
            this.writeTf.text = "";
            if(this.charPreview)
            {
               this.charPreview.terminate();
            }
            Connectr.instance.serviceModel.requestExtension(RequestDataKey.ROOM_MESSAGE,{"message":_loc2_},this.onResponse);
         }
      }
      
      private function onResponse(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         if(param1.errorCode)
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = AlertType.TOOLTIP;
            _loc2_.description = $(param1.message);
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
      }
      
      private function btnCloseClicked(param1:MouseEvent) : void
      {
         var _loc2_:BusinessMessageEvent = new BusinessMessageEvent(BusinessMessageEvent.REMOVE_BUSINESS_MESSAGE);
         _loc2_.view = this;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      override public function removed() : void
      {
         if(this.inputManager)
         {
            this.inputManager.dispose();
            this.inputManager = null;
         }
         this.writeTf.removeEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.writeTf.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.reportButton.removeEventListener(MouseEvent.CLICK,this.reportButtonClicked);
         this.btnClose.removeEventListener(MouseEvent.CLICK,this.btnCloseClicked);
         this.btnOk.removeEventListener(MouseEvent.CLICK,this.sendOrOkClicked);
         Connectr.instance.layerModel.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyPressed);
      }
   }
}

