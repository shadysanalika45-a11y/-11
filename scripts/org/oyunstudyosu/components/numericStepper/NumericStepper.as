package org.oyunstudyosu.components.numericStepper
{
   import com.oyunstudyosu.enums.UpdateGroups;
   import com.oyunstudyosu.events.NumericStepperEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol220")]
   public class NumericStepper extends CoreMovieClip
   {
      
      public var quantityBg:MovieClip;
      
      private var _minimum:int = 1;
      
      private var _maximum:int = 100;
      
      private var _stepSize:int = 1;
      
      private var _selectable:Boolean = false;
      
      private var _currentValue:int;
      
      public var upButton:SimpleButton;
      
      public var downButton:SimpleButton;
      
      public var tf:TextField;
      
      private var steppedSide:String;
      
      public function NumericStepper()
      {
         super();
         this.upButton.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this.downButton.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this.tf.restrict = "0-9";
         this.tf.type = TextFieldType.INPUT;
         this.tf.selectable = true;
         this.tf.addEventListener(Event.CHANGE,this.tfChangeHandler);
      }
      
      protected function tfChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.tf.text == "")
         {
            _loc2_ = this.minimum;
         }
         else
         {
            _loc2_ = parseInt(this.tf.text);
         }
         this.currentValue = _loc2_ > this.maximum ? this.maximum : _loc2_;
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "upButton")
         {
            this.steppedSide = "up";
            this.changeStepperValue();
         }
         else
         {
            this.steppedSide = "down";
            this.changeStepperValue();
         }
         Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_100).addFunction(this.changeStepperValue);
         this.upButton.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.downButton.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         Connectr.instance.layerModel.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      private function changeStepperValue(param1:uint = 0, param2:uint = 0) : void
      {
         if(this.steppedSide == "up")
         {
            if(this.currentValue + this.stepSize <= this.maximum)
            {
               this.currentValue += this.stepSize;
            }
            else
            {
               this.currentValue = this.maximum;
            }
         }
         else if(this.steppedSide == "down")
         {
            if(this.currentValue - this.stepSize >= this.minimum)
            {
               this.currentValue -= this.stepSize;
            }
            else
            {
               this.currentValue = this.minimum;
            }
         }
      }
      
      protected function mouseUpHandler(param1:MouseEvent) : void
      {
         Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_100).removeFunction(this.changeStepperValue);
         this.upButton.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.downButton.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         Connectr.instance.layerModel.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      override public function added() : void
      {
         this.currentValue = this.minimum;
         this.tf.text = this.currentValue.toString();
      }
      
      public function get currentValue() : int
      {
         return this._currentValue;
      }
      
      public function set currentValue(param1:int) : void
      {
         if(this._currentValue == param1)
         {
            return;
         }
         this._currentValue = param1;
         this.tf.text = param1.toString();
         dispatchEvent(new NumericStepperEvent(NumericStepperEvent.STEPPER_CHANGE));
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
         this.tf.selectable = param1;
      }
      
      public function get stepSize() : int
      {
         return this._stepSize;
      }
      
      public function set stepSize(param1:int) : void
      {
         this._stepSize = param1;
      }
      
      public function get maximum() : int
      {
         return this._maximum;
      }
      
      public function set maximum(param1:int) : void
      {
         this._maximum = param1;
         var _loc2_:String = param1.toString();
         this.tf.maxChars = _loc2_.length;
      }
      
      public function get minimum() : int
      {
         return this._minimum;
      }
      
      public function set minimum(param1:int) : void
      {
         this._minimum = param1;
         this.currentValue = param1;
         this.tf.text = this.currentValue.toString();
      }
      
      override public function removed() : void
      {
         this.upButton.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.downButton.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         Connectr.instance.layerModel.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.tf.removeEventListener(Event.CHANGE,this.tfChangeHandler);
         Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_100).removeFunction(this.changeStepperValue);
      }
   }
}

