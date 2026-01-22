package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.AlertResponse;
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.combobox.ComboBoxVo;
   import com.oyunstudyosu.components.CloseButton;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.roomkick.KickData;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import org.oyunstudyosu.alert.IAlertView;
   import org.oyunstudyosu.alert.buttons.YellowButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   import org.oyunstudyosu.components.combobox.CoreComboBox;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol252")]
   public class KickSelectTimeView extends CoreMovieClip implements IAlertView
   {
      
      public var lblStepperComment:TextField;
      
      public var lbl_Title:TextField;
      
      public var btnClose:CloseButton;
      
      public var btnOk:YellowButton;
      
      private var sTitle:STextField;
      
      private var sStepperTextField:STextField;
      
      private var comboBox:CoreComboBox;
      
      public var background:MovieClip;
      
      public var mcDragger:MovieClip;
      
      private var _vo:IAlertVo;
      
      public function KickSelectTimeView()
      {
         super();
      }
      
      public function dragger() : MovieClip
      {
         return this.mcDragger;
      }
      
      public function init() : void
      {
         this.btnOk.setText($("KICK"));
         if(this.sTitle == null)
         {
            this.sTitle = TextFieldManager.convertAsArabicTextField(getChildByName("lbl_Title") as TextField,false,true);
            this.sTitle.autoSize = TextFieldAutoSize.CENTER;
            this.sTitle.mouseEnabled = false;
            this.sStepperTextField = TextFieldManager.convertAsArabicTextField(getChildByName("lblStepperComment") as TextField,true,false);
            this.sStepperTextField.autoSize = TextFieldAutoSize.CENTER;
         }
         this.initData();
         this.sTitle.text = this.vo.title;
         this.sStepperTextField.text = this.vo.stepperComment;
         this.sStepperTextField.x = this.comboBox.x + this.comboBox.width + 5;
         this.sStepperTextField.y = this.comboBox.y;
         this.sStepperTextField.width = this.background.width - this.sStepperTextField.x - 15;
         this.sStepperTextField.height = 50;
         this.btnOk.addEventListener(MouseEvent.CLICK,this.okClicked);
         this.btnClose.addEventListener(MouseEvent.CLICK,this.closeClicked);
      }
      
      private function initData() : void
      {
         var _loc2_:ComboBoxVo = null;
         var _loc1_:Vector.<ComboBoxVo> = new Vector.<ComboBoxVo>();
         var _loc3_:int = int(KickData.KICK_LIST.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ComboBoxVo();
            _loc2_.label = KickData.KICK_LIST[_loc4_].label;
            _loc2_.index = _loc4_;
            _loc2_.data.second = KickData.KICK_LIST[_loc4_].second;
            _loc1_.push(_loc2_);
            _loc4_++;
         }
         this.comboBox = new CoreComboBox();
         this.comboBox.x = 25;
         this.comboBox.y = 60;
         this.comboBox.dataProvider = _loc1_;
         this.comboBox.rowCount = 3;
         addChild(this.comboBox);
         this.comboBox.selectedIndex = 0;
      }
      
      protected function closeClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.CLOSE,-1);
         }
         dispatchEvent(new Event("closeClicked"));
      }
      
      protected function okClicked(param1:MouseEvent) : void
      {
         if(this.vo.callBack != null)
         {
            this.vo.callBack(AlertResponse.OK,this.comboBox.selectedData.second);
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
         this.btnOk.removeEventListener(MouseEvent.CLICK,this.okClicked);
         this.btnClose.removeEventListener(MouseEvent.CLICK,this.closeClicked);
      }
   }
}

