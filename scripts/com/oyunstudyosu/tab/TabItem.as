package com.oyunstudyosu.tab
{
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TabItem extends MovieClip
   {
      
      private var _skin:MovieClip;
      
      private var _targetMovieClip:MovieClip;
      
      private var _title:String;
      
      private var _index:int;
      
      private var _background:MovieClip;
      
      private var _tf:STextField;
      
      public function TabItem()
      {
         super();
      }
      
      public function init() : void
      {
         this.unlock();
      }
      
      public function get skin() : MovieClip
      {
         return this._skin;
      }
      
      public function set skin(param1:MovieClip) : void
      {
         if(this._skin == param1)
         {
            return;
         }
         this._skin = param1;
         this._tf = TextFieldManager.convertAsArabicTextField(this.skin.getChildByName("label") as TextField,false,true);
         this._background = this.skin.getChildByName("background") as MovieClip;
         this.addChild(this.skin);
         this.buttonMode = true;
         this.mouseChildren = false;
      }
      
      public function get targetMovieClip() : MovieClip
      {
         return this._targetMovieClip;
      }
      
      public function set targetMovieClip(param1:MovieClip) : void
      {
         if(this._targetMovieClip == param1)
         {
            return;
         }
         this._targetMovieClip = param1;
      }
      
      public function lock() : void
      {
         if(this.targetMovieClip)
         {
            this.targetMovieClip.visible = true;
         }
         this.mouseEnabled = false;
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.upHandler);
         this.overHandler();
      }
      
      public function unlock() : void
      {
         if(this.targetMovieClip)
         {
            this.targetMovieClip.visible = false;
         }
         this.mouseEnabled = true;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this.addEventListener(MouseEvent.MOUSE_UP,this.upHandler);
         this.outHandler();
      }
      
      protected function overHandler(param1:MouseEvent = null) : void
      {
         this.background.gotoAndStop(2);
      }
      
      protected function outHandler(param1:MouseEvent = null) : void
      {
         this.background.gotoAndStop(1);
      }
      
      protected function downHandler(param1:MouseEvent = null) : void
      {
         this.background.gotoAndStop(3);
      }
      
      protected function upHandler(param1:MouseEvent = null) : void
      {
         this.background.gotoAndStop(1);
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         if(this._title == param1)
         {
            return;
         }
         this._title = param1;
         if(this.tf)
         {
            this.tf.htmlText = this.title;
            this.background.width = this.tf.width + this.tf.x * 2;
         }
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         if(this._index == param1)
         {
            return;
         }
         this._index = param1;
      }
      
      public function get background() : MovieClip
      {
         return this._background;
      }
      
      public function get tf() : STextField
      {
         return this._tf;
      }
   }
}

