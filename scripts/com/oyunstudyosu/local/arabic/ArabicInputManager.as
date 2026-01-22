package com.oyunstudyosu.local.arabic
{
   import com.oyunstudyosu.local.arabic.text.AddTextOperation;
   import com.oyunstudyosu.local.arabic.text.ExtendSelectionOperation;
   import com.oyunstudyosu.local.arabic.text.ITextOperation;
   import com.oyunstudyosu.local.arabic.text.ITextOperationContext;
   import com.oyunstudyosu.local.arabic.text.JumpToWordOperation;
   import com.oyunstudyosu.local.arabic.text.MoveSelectionOperation;
   import com.oyunstudyosu.local.arabic.text.Selection;
   import com.oyunstudyosu.local.arabic.text.SelectionDirection;
   import com.oyunstudyosu.local.arabic.text.SetSelectionPositionOperation;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   
   public class ArabicInputManager extends EventDispatcher implements ITextOperationContext
   {
      
      private static var parser:ArabicLight;
      
      private static const IS_WINDOWS:Boolean = Capabilities.version.toLowerCase().indexOf("win") != -1;
      
      public static const TEXTFIELD_DRAWN:String = "textfieldDrawn";
      
      public var textField:TextField;
      
      private var _isDisposed:Boolean = false;
      
      private var textFormat:TextFormat;
      
      private var text:String;
      
      private var lineWidth:Number;
      
      private var currentSelection:Selection;
      
      private var pendingOperations:Vector.<ITextOperation>;
      
      public function ArabicInputManager(param1:TextField, param2:TextFormat, param3:Number = NaN)
      {
         super();
         if(!param1)
         {
            throw new ArgumentError("textField parameter can not be null");
         }
         if(!param2)
         {
            throw new ArgumentError("textFormat parameter can not be null");
         }
         this.textFormat = param2;
         this.textField = param1;
         param1.type = TextFieldType.INPUT;
         param2.align = TextFormatAlign.RIGHT;
         if(isNaN(param3))
         {
            param3 = param1.width;
         }
         this.lineWidth = param3;
         this.text = param1.text;
         this.pendingOperations = new Vector.<ITextOperation>();
         parser = new ArabicLight();
         this.updateSelection();
         this.draw();
         this.processAndDraw();
         param1.addEventListener(Event.CHANGE,this.processAndDraw);
         param1.addEventListener(KeyboardEvent.KEY_UP,this.processAndDraw);
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.processAndDraw);
         param1.addEventListener(TextEvent.TEXT_INPUT,this.handleTextInput);
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         param1.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         param1.addEventListener(MouseEvent.MOUSE_UP,this.updateSelection);
      }
      
      public function changeFormat(param1:TextFormat) : void
      {
         this.textFormat = param1;
         this.textField.type = TextFieldType.INPUT;
         this.textFormat.align = TextFormatAlign.RIGHT;
      }
      
      public function addText(param1:String = "") : Selection
      {
         return this.addTextWithSelection(this.currentSelection,param1);
      }
      
      public function addTextWithSelection(param1:Selection, param2:String = "") : Selection
      {
         var _loc3_:String = this.text;
         _loc3_ = _loc3_.slice(0,param1.beginIndex) + param2 + _loc3_.slice(param1.endIndex);
         this.text = _loc3_;
         var _loc4_:int = param1.beginIndex + param2.length;
         this.setSelection(new Selection(_loc4_,_loc4_));
         return this.currentSelection;
      }
      
      public function draw() : void
      {
         this.textField.htmlText = parser.parseArabic(this.text,this.lineWidth,this.textFormat);
         this.dispatchEvent(new Event(TEXTFIELD_DRAWN));
      }
      
      public function setSelection(param1:Selection) : void
      {
         this.currentSelection = param1;
         this.applySelection();
      }
      
      public function getSelection() : Selection
      {
         return this.currentSelection;
      }
      
      public function getText() : String
      {
         return this.text;
      }
      
      public function dispose() : void
      {
         this.textField.removeEventListener(FocusEvent.FOCUS_IN,this.updateSelection);
         this.textField.removeEventListener(MouseEvent.MOUSE_UP,this.updateSelection);
         this.textField.removeEventListener(TextEvent.TEXT_INPUT,this.handleTextInput);
         this.textField.removeEventListener(KeyboardEvent.KEY_DOWN,this.processAndDraw);
         this.textField.removeEventListener(KeyboardEvent.KEY_UP,this.processAndDraw);
         this.textField.removeEventListener(Event.CHANGE,this.processAndDraw);
         this.textField.removeEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         this.textField.removeEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
         this._isDisposed = true;
      }
      
      public function get isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      protected function doOperations() : DoOperationsResult
      {
         var _loc3_:Boolean = false;
         var _loc4_:ITextOperation = null;
         var _loc1_:int = int(this.pendingOperations.length);
         var _loc2_:int = _loc1_;
         while(_loc2_ > 0)
         {
            _loc4_ = this.pendingOperations.splice(0,1)[0];
            _loc4_.perform(this);
            _loc3_ ||= _loc4_.requiresDraw();
            _loc2_--;
         }
         return _loc1_ > 0 ? new DoOperationsResult(_loc1_,_loc3_) : null;
      }
      
      private function applySelection() : void
      {
         var _loc1_:int = this.text.length;
         this.textField.setSelection(_loc1_ - this.currentSelection.beginIndex,_loc1_ - this.currentSelection.endIndex);
      }
      
      private function processAndDraw(param1:Event = null) : void
      {
         var _loc2_:DoOperationsResult = this.doOperations();
         if(_loc2_)
         {
            if(_loc2_.redrawRequired)
            {
               this.draw();
            }
            this.applySelection();
            this.textField.selectable = true;
         }
      }
      
      private function handleTextInput(param1:TextEvent) : void
      {
         if(param1.text == ">" || param1.text == "<")
         {
            param1.preventDefault();
            return;
         }
         if(this.textField.length >= this.textField.maxChars)
         {
            param1.preventDefault();
            return;
         }
         if(!this.isAvailableText())
         {
            param1.preventDefault();
            return;
         }
         if(param1.text.length == 1)
         {
            this.pendingOperations.push(new AddTextOperation(param1.text));
         }
      }
      
      private function handleKeyUp(param1:KeyboardEvent) : void
      {
         this.textField.removeEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
         this.textField.addEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
      }
      
      private function isAvailableText() : Boolean
      {
         var _loc3_:String = null;
         var _loc1_:String = this.getText();
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 1;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            if(_loc3_ != _loc1_.charAt(_loc5_))
            {
               _loc4_ = 1;
               _loc3_ = _loc1_.charAt(_loc5_);
            }
            else
            {
               _loc4_++;
            }
            if(_loc4_ == 10)
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      private function handleKeyDown(param1:KeyboardEvent) : void
      {
         this.textField.addEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
         this.textField.removeEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         var _loc2_:uint = param1.keyCode;
         switch(_loc2_)
         {
            case Keyboard.BACKSPACE:
            case Keyboard.DELETE:
               if(this.currentSelection.length == 0)
               {
                  if(_loc2_ == Keyboard.BACKSPACE)
                  {
                     this.pendingOperations.push(new ExtendSelectionOperation(1,SelectionDirection.LEFT));
                  }
                  else
                  {
                     this.pendingOperations.push(new ExtendSelectionOperation(1,SelectionDirection.RIGHT));
                  }
               }
               this.pendingOperations.push(new AddTextOperation());
               break;
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
               if(param1.shiftKey && this.checkAltKey(param1))
               {
                  this.pendingOperations.push(new JumpToWordOperation(_loc2_ == Keyboard.RIGHT ? SelectionDirection.RIGHT : SelectionDirection.LEFT,true));
               }
               else if(param1.shiftKey)
               {
                  this.pendingOperations.push(new ExtendSelectionOperation(1,_loc2_ == Keyboard.RIGHT ? SelectionDirection.RIGHT : SelectionDirection.LEFT));
               }
               else if(this.checkAltKey(param1))
               {
                  this.pendingOperations.push(new JumpToWordOperation(_loc2_ == Keyboard.RIGHT ? SelectionDirection.RIGHT : SelectionDirection.LEFT));
               }
               else
               {
                  this.pendingOperations.push(new MoveSelectionOperation(_loc2_ == Keyboard.RIGHT ? 1 : -1));
               }
               this.textField.selectable = false;
               break;
            case Keyboard.HOME:
               if(param1.shiftKey)
               {
                  this.pendingOperations.push(new ExtendSelectionOperation(1000,SelectionDirection.LEFT));
               }
               else
               {
                  this.pendingOperations.push(new SetSelectionPositionOperation(0));
               }
               this.textField.selectable = false;
               break;
            case Keyboard.END:
               if(param1.shiftKey)
               {
                  this.pendingOperations.push(new ExtendSelectionOperation(1000,SelectionDirection.RIGHT));
               }
               else
               {
                  this.pendingOperations.push(new SetSelectionPositionOperation(this.text.length));
               }
               this.textField.selectable = false;
               break;
            case Keyboard.A:
            case Keyboard.TAB:
               if(_loc2_ == Keyboard.TAB || param1.ctrlKey)
               {
                  this.pendingOperations.push(new SetSelectionPositionOperation(0));
                  this.pendingOperations.push(new ExtendSelectionOperation(this.text.length,SelectionDirection.RIGHT));
               }
         }
      }
      
      public function clearText() : void
      {
         this.text = "";
      }
      
      private function checkAltKey(param1:KeyboardEvent) : Boolean
      {
         return param1.altKey && !IS_WINDOWS || param1.ctrlKey && IS_WINDOWS;
      }
      
      protected function focusIn(param1:FocusEvent) : void
      {
         this.clearText();
         this.updateSelection();
      }
      
      private function updateSelection(param1:Event = null) : void
      {
         this.currentSelection = Selection.fromRTLTextField(this.textField);
      }
   }
}

class DoOperationsResult
{
   
   public var numOperationsDone:int;
   
   public var redrawRequired:Boolean;
   
   public function DoOperationsResult(param1:int, param2:Boolean)
   {
      super();
      this.redrawRequired = param2;
      this.numOperationsDone = param1;
   }
}
