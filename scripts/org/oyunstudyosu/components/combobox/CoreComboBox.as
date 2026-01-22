package org.oyunstudyosu.components.combobox
{
   import com.oyunstudyosu.combobox.ComboBoxVo;
   import com.oyunstudyosu.events.ComboBoxEvent;
   import com.oyunstudyosu.utils.DrawUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.components.CoreMovieClip;
   import org.oyunstudyosu.components.scrollBar.CoreScrollBar;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1099")]
   public class CoreComboBox extends CoreMovieClip
   {
      
      private var _selectedIndex:int;
      
      private var _selectedText:String;
      
      private var _rowCount:int = 5;
      
      private var _dataProvider:Vector.<ComboBoxVo>;
      
      private var listW:int;
      
      private var _opened:Boolean = false;
      
      private var item:ComboBoxItemUI;
      
      private var header:ComboBoxHeader;
      
      private var comboContainer:Sprite;
      
      private var listContainer:Sprite;
      
      private var maskContainer:Sprite;
      
      public var itemBg:ComboBoxItemBg;
      
      private var scrollBar:CoreScrollBar;
      
      private var boxLen:int;
      
      private const BUTTON_MARGIN:uint = 5;
      
      private var direction:String;
      
      private var _selectedData:Object;
      
      public function CoreComboBox(param1:String = "down")
      {
         super();
         this.header = new ComboBoxHeader();
         addChild(this.header);
         this.direction = param1;
      }
      
      override public function added() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         this.header.buttonMode = true;
         this.header.addEventListener(MouseEvent.CLICK,this.showMenu);
         this.comboContainer = new Sprite();
         this.comboContainer.y = this.header.bg.height;
         addChildAt(this.comboContainer,0);
         this.comboContainer.visible = false;
         this.listContainer = new Sprite();
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < this.dataProvider.length)
         {
            this.item = new ComboBoxItemUI();
            this.item.vo = this.dataProvider[_loc3_];
            this.item.setW = this.dataProvider[_loc3_].bgW - 2;
            this.item.x = 1;
            this.item.y = _loc3_ * (this.item.bg.height + 1);
            this.listContainer.addChild(this.item);
            if(_loc1_ < this.item.bg.width)
            {
               _loc1_ = this.item.bg.width;
            }
            this.item.addEventListener(MouseEvent.CLICK,this.comboBoxItemSelected);
            _loc2_.push(this.item);
            _loc3_++;
         }
         if(this.dataProvider.length > 0)
         {
            this.maskContainer = DrawUtils.getRectangleSprite(this.listContainer.width,(this.item.bg.height + 1) * this.rowCount - 1,0,1);
            this.maskContainer.x = this.listContainer.x;
            if(this.direction != "down")
            {
               this.maskContainer.y = this.listContainer.y = -this.maskContainer.height;
               this.header.comboboxButton.rotation = 180;
            }
            if(this.listContainer.height > this.maskContainer.height)
            {
               this.width = _loc1_ + 10;
            }
            else
            {
               this.width = _loc1_ + 10;
            }
            this.itemBg = new ComboBoxItemBg();
            this.itemBg.y = this.maskContainer.y - 1;
            this.itemBg.height = this.maskContainer.height;
            this.itemBg.width = this.maskContainer.width;
            this.comboContainer.addChild(this.itemBg);
            this.comboContainer.addChild(this.listContainer);
            this.comboContainer.addChild(this.maskContainer);
            this.scrollBar = new CoreScrollBar();
            this.comboContainer.addChild(this.scrollBar);
            this.scrollBar.direction = "vertical";
            this.scrollBar.bgColor = 15658734;
            this.scrollBar.barColor = 10395294;
            this.scrollBar.bar.width = this.scrollBar.scrollBackground.width = this.scrollBar.barMask.width = 8;
            this.scrollBar.snap = this.item.bg.height;
            this.scrollBar.x = this.header.width - this.scrollBar.width - 5;
            this.scrollBar.y = this.listContainer.y;
            this.scrollBar.setTarget(this.listContainer,this.maskContainer);
         }
         else
         {
            this.visible = false;
         }
      }
      
      protected function comboBoxItemSelected(param1:MouseEvent) : void
      {
         this.opened = false;
         var _loc2_:ComboBoxItemUI = param1.currentTarget as ComboBoxItemUI;
         if(this.selectedIndex == _loc2_.vo.index)
         {
            return;
         }
         this.selectedIndex = _loc2_.vo.index;
         dispatchEvent(new ComboBoxEvent(ComboBoxEvent.ITEM_SELECTED));
      }
      
      protected function showMenu(param1:MouseEvent) : void
      {
         this.opened = !this.opened;
      }
      
      public function get dataProvider() : Vector.<ComboBoxVo>
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:Vector.<ComboBoxVo>) : void
      {
         this._dataProvider = param1;
         this.boxLen = param1.length;
      }
      
      public function get rowCount() : int
      {
         return this._rowCount;
      }
      
      public function set rowCount(param1:int) : void
      {
         this._rowCount = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this.dataProvider.length == 0)
         {
            return;
         }
         this._selectedIndex = param1;
         this.header.sText.text = this.dataProvider[param1].label;
         this.header.sText.width = this.header.bg.width - 30;
         this.selectedData = this.dataProvider[param1].data;
      }
      
      public function get selectedData() : Object
      {
         return this._selectedData;
      }
      
      public function set selectedData(param1:Object) : void
      {
         if(this._selectedData == param1)
         {
            return;
         }
         this._selectedData = param1;
      }
      
      public function get opened() : Boolean
      {
         return this._opened;
      }
      
      public function get selectedText() : String
      {
         return this.dataProvider[this.selectedIndex].label;
      }
      
      public function set opened(param1:Boolean) : void
      {
         this._opened = param1;
         if(param1)
         {
            this.comboContainer.visible = true;
         }
         else
         {
            this.comboContainer.visible = false;
         }
      }
      
      public function addItem(param1:ComboBoxVo) : void
      {
         this._dataProvider.push(param1);
      }
      
      override public function set width(param1:Number) : void
      {
         this.header.bg.width = param1;
         this.header.comboboxButton.x = this.header.bg.width - 15;
      }
      
      override public function get width() : Number
      {
         return this.header.bg.width;
      }
      
      override public function set height(param1:Number) : void
      {
         this.header.bg.height = param1;
         this.header.comboboxButton.y = (this.header.bg.height - this.header.comboboxButton.height) * 0.5;
         this.header.sText.y = (this.header.bg.height - this.header.sText.height) * 0.5;
         if(this.comboContainer)
         {
            this.comboContainer.y = this.header.bg.height + 2;
         }
      }
      
      override public function get height() : Number
      {
         return this.header.bg.height;
      }
      
      override public function removed() : void
      {
         while(this.listContainer.numChildren > 0)
         {
            this.listContainer.getChildAt(0).removeEventListener(MouseEvent.CLICK,this.comboBoxItemSelected);
            this.listContainer.removeChildAt(0);
         }
         this.header.comboboxButton.removeEventListener(MouseEvent.CLICK,this.showMenu);
         this._dataProvider = null;
         this.header = null;
         this.listContainer = null;
         this.maskContainer = null;
         this.itemBg = null;
         this.scrollBar = null;
         while(this.comboContainer.numChildren > 0)
         {
            this.comboContainer.removeChildAt(0);
         }
         this.comboContainer = null;
      }
   }
}

