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
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import org.oyunstudyosu.alert.IAlertView;
   import org.oyunstudyosu.alert.buttons.RedButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol208")]
   public class ErrorView extends CoreMovieClip implements IAlertView
   {
      
      public var background:MovieClip;
      
      public var lblMsg:TextField;
      
      public var lbl_Title:TextField;
      
      public var btnClose:CloseButton;
      
      public var btnOk:RedButton;
      
      private var messageTextField:STextField;
      
      private var sTitle:STextField;
      
      public var mcDragger:MovieClip;
      
      private var _vo:IAlertVo;
      
      public function ErrorView()
      {
         super();
      }
      
      public function dragger() : MovieClip
      {
         return this.mcDragger;
      }
      
      public function init() : void
      {
         if(Connectr.instance.localizationModel == null)
         {
            this.btnOk.setText("OK");
         }
         else
         {
            this.btnOk.setText($("OK"));
         }
         if(this.messageTextField == null)
         {
            this.sTitle = TextFieldManager.convertAsArabicTextField(getChildByName("lbl_Title") as TextField,false,false);
            this.sTitle.autoSize = TextFieldAutoSize.CENTER;
            this.messageTextField = TextFieldManager.convertAsArabicTextField(this.getChildByName("lblMsg") as TextField,true,false);
            this.messageTextField.width = 305;
         }
         this.sTitle.centerText = this.vo.title;
         var _loc1_:TextFormat = this.messageTextField.defaultTextFormat;
         _loc1_.align = TextFormatAlign.CENTER;
         this.messageTextField.setTextFormat(_loc1_);
         this.messageTextField.htmlText = this.vo.description;
         this.messageTextField.height = this.messageTextField.textHeight + 8;
         this.messageTextField.y = (this.height / Connectr.instance.scaleModel.uiScale - this.messageTextField.height) / 2 - 10;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         trace("EmessageTextField.width" + this.messageTextField.width);
      }
      
      protected function closeClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.CLOSE);
         }
         dispatchEvent(new Event("closeClicked"));
      }
      
      protected function okClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.OK);
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
      }
   }
}

