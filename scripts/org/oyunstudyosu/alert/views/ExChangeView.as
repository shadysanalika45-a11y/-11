package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.AlertResponse;
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.components.CloseButton;
   import com.oyunstudyosu.events.NumericStepperEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.oyunstudyosu.alert.IAlertView;
   import org.oyunstudyosu.alert.buttons.YellowButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   import org.oyunstudyosu.components.numericStepper.NumericStepper;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol246")]
   public class ExChangeView extends CoreMovieClip implements IAlertView
   {
      
      public var background:MovieClip;
      
      public var diamondTxt:TextField;
      
      public var lbl_Title:TextField;
      
      public var quantityBg:MovieClip;
      
      public var sanilInfoTxt:TextField;
      
      public var btnClose:CloseButton;
      
      public var btnOk:YellowButton;
      
      private var sTitle:STextField;
      
      private var diamondText:STextField;
      
      private var sanilInfoText:STextField;
      
      public var sanilTxt:TextField;
      
      public var stepper:NumericStepper;
      
      public var mcDragger:MovieClip;
      
      private var _vo:IAlertVo;
      
      public function ExChangeView()
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
            this.diamondText = TextFieldManager.convertAsArabicTextField(getChildByName("diamondTxt") as TextField);
            this.sanilInfoText = TextFieldManager.convertAsArabicTextField(getChildByName("sanilInfoTxt") as TextField);
         }
         this.sTitle.centerText = this.vo.title;
         this.diamondText.text = $("diamond");
         this.sanilInfoText.text = $("sanil");
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
         this.stepper.addEventListener(NumericStepperEvent.STEPPER_CHANGE,this.updateExChangeValue);
         this.stepper.minimum = this.vo.minQuantity;
         this.stepper.maximum = this.vo.maxQuantity;
         this.stepper.stepSize = this.vo.stepSize;
         this.updateExChangeValue();
      }
      
      protected function updateExChangeValue(param1:NumericStepperEvent = null) : void
      {
         this.sanilTxt.text = (Connectr.instance.gameModel.exchangeratio * this.stepper.currentValue).toString();
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
         this.stepper.removeEventListener(NumericStepperEvent.STEPPER_CHANGE,this.updateExChangeValue);
         this.stepper = null;
      }
   }
}

