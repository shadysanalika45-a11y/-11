package com.oyunstudyosu.tab
{
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class TabMenu extends EventDispatcher
   {
      
      public static const TAB_MENU_CHANGED:String = "TabMenu.TAB_MENU_CHANGED";
      
      private var container:MovieClip;
      
      private var activeTabItem:TabItem;
      
      private var item:TabItem;
      
      private var _margin:int = 10;
      
      private var _activeTabId:int;
      
      public function TabMenu()
      {
         super();
      }
      
      public function init() : void
      {
         this.container = new MovieClip();
      }
      
      public function get margin() : int
      {
         return this._margin;
      }
      
      public function set margin(param1:int) : void
      {
         if(this._margin == param1)
         {
            return;
         }
         this._margin = param1;
      }
      
      public function get activeTabId() : int
      {
         return this._activeTabId;
      }
      
      public function set activeTabId(param1:int) : void
      {
         if(this._activeTabId == param1)
         {
            return;
         }
         this._activeTabId = param1;
         if(this.container.numChildren > param1)
         {
            if(this.activeTabItem)
            {
               this.activeTabItem.unlock();
            }
            this.activeTabItem = this.container.getChildAt(param1) as TabItem;
            this.activeTabItem.lock();
         }
      }
      
      public function addMenu(param1:MovieClip, param2:MovieClip, param3:String) : void
      {
         this.item = new TabItem();
         this.item.skin = param2;
         this.item.targetMovieClip = param1;
         this.item.title = param3;
         this.item.index = this.container.numChildren;
         this.item.init();
         if(this.container.numChildren == 0)
         {
            this.item.x = 0;
            this.activeTabItem = this.item;
            this.activeTabItem.lock();
         }
         else
         {
            this.item.x = this.container.width + this.margin;
         }
         this.container.addChild(this.item);
         this.item.addEventListener(MouseEvent.CLICK,this.tabItemClicked);
      }
      
      protected function tabItemClicked(param1:MouseEvent) : void
      {
         this.item = param1.currentTarget as TabItem;
         this.activeTabId = this.item.index;
      }
      
      public function getContainer() : MovieClip
      {
         return this.container;
      }
      
      public function dispose() : void
      {
      }
   }
}

