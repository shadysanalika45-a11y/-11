package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.AlertResponse;
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.components.CloseButton;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import org.oyunstudyosu.alert.IAlertView;
   import org.oyunstudyosu.alert.buttons.RedButton;
   import org.oyunstudyosu.alert.buttons.YellowButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   import org.oyunstudyosu.components.numericStepper.NumericStepper;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol259")]
   public class QuantityView extends CoreMovieClip implements IAlertView
   {
      
      public var background:MovieClip;
      
      public var lblMsg:TextField;
      
      public var lblStepperComment:TextField;
      
      public var lbl_Title:TextField;
      
      public var btnClose:CloseButton;
      
      public var btnOk:YellowButton;
      
      public var btnCancel:RedButton;
      
      private var messageTextField:STextField;
      
      private var sTitle:STextField;
      
      private var sStepperTextField:STextField;
      
      public var stepper:NumericStepper;
      
      public var mcDragger:MovieClip;
      
      private var _vo:IAlertVo;
      
      public function QuantityView()
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
         this.btnCancel.setText($("Cancel"));
         this.stepper.minimum = this.vo.minQuantity;
         this.stepper.maximum = this.vo.maxQuantity;
         this.stepper.stepSize = this.vo.stepSize;
         if(this.messageTextField == null)
         {
            this.sTitle = TextFieldManager.convertAsArabicTextField(getChildByName("lbl_Title") as TextField,false,true);
            this.messageTextField = TextFieldManager.convertAsArabicTextField(this.getChildByName("lblMsg") as TextField,true,false);
            this.messageTextField.width = 305;
            this.sStepperTextField = TextFieldManager.convertAsArabicTextField(getChildByName("lblStepperComment") as TextField,false,true);
            this.sStepperTextField.autoSize = TextFieldAutoSize.CENTER;
         }
         this.sTitle.centerText = this.vo.title;
         this.messageTextField.htmlText = this.vo.description;
         this.sStepperTextField.text = this.vo.stepperComment;
         this.sStepperTextField.x = this.stepper.x + this.stepper.width + 5;
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.cancelClicked);
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
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
            this.vo.callBack(AlertResponse.OK,this.stepper.currentValue);
         }
         dispatchEvent(new Event("closeClicked"));
      }
      
      protected function cancelClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.CANCEL);
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
         this.btnClose.removeEventListener(MouseEvent.CLICK,this.closeClicked);
      }
   }
}

