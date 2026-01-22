package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.AlertResponse;
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.components.CloseButton;
   import com.oyunstudyosu.local.$;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol255")]
   public class PromptView extends CoreMovieClip implements IAlertView
   {
      
      public var background:MovieClip;
      
      public var lbl_Title:TextField;
      
      public var lblMsg:TextField;
      
      private var sTitle:STextField;
      
      public var btnOk:YellowButton;
      
      public var btnClose:CloseButton;
      
      private var defaulMsg:String;
      
      public var mcDragger:MovieClip;
      
      private var _vo:IAlertVo;
      
      public function PromptView()
      {
         super();
      }
      
      public function dragger() : MovieClip
      {
         return this.mcDragger;
      }
      
      public function init() : void
      {
         this.btnOk.setText($("Confirm"));
         if(this.sTitle == null)
         {
            this.sTitle = TextFieldManager.convertAsArabicTextField(getChildByName("lbl_Title") as TextField,false,false);
         }
         this.sTitle.centerText = this.vo.title;
         this.lblMsg.text = this.vo.description;
         this.lblMsg.border = true;
         this.lblMsg.borderColor = 14134647;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         this.lblMsg.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.lblMsg.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         Connectr.instance.layerModel.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUp);
      }
      
      protected function keyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            if(this.vo.callBack != null)
            {
               this.vo.callBack(AlertResponse.OK,this.lblMsg.text);
            }
            dispatchEvent(new Event("closeClicked"));
         }
      }
      
      protected function focusIn(param1:FocusEvent) : void
      {
         this.lblMsg.text = "";
      }
      
      protected function focusOut(param1:FocusEvent) : void
      {
         if(this.lblMsg.text == "")
         {
            this.lblMsg.text = this.vo.description;
         }
      }
      
      protected function closeClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.CLOSE,"");
         }
         dispatchEvent(new Event("closeClicked"));
      }
      
      protected function okClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.OK,this.lblMsg.text);
         }
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
         this.btnClose.removeEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.removeEventListener(MouseEvent.CLICK,this.okClicked);
         this.lblMsg.removeEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.lblMsg.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         Connectr.instance.layerModel.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUp);
      }
   }
}

