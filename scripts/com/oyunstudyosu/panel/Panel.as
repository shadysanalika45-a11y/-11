package com.oyunstudyosu.panel
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.greensock.plugins.GlowFilterPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   
   public class Panel extends MovieClip implements IPanel
   {
      
      protected var _isDisposed:Boolean;
      
      protected var lastLocation:Point;
      
      protected var fPoint:Point;
      
      public var panelWidth:int;
      
      public var panelHeight:int;
      
      private var _bgHandler:MovieClip;
      
      private var _dragHandler:MovieClip;
      
      private var _data:PanelVO;
      
      public function Panel()
      {
         super();
      }
      
      protected function close() : void
      {
         Dispatcher.dispatchEvent(new PanelEvent(PanelEvent.CLOSE,this));
         this.dispose();
      }
      
      public function get bgHandler() : MovieClip
      {
         return this._bgHandler;
      }
      
      public function set bgHandler(param1:MovieClip) : void
      {
         if(this._bgHandler == param1)
         {
            return;
         }
         this._bgHandler = param1;
         this._bgHandler.mouseChildren = false;
         this._bgHandler.mouseEnabled = false;
      }
      
      public function set dragHandler(param1:MovieClip) : void
      {
         if(this._dragHandler == param1)
         {
            return;
         }
         if(this._dragHandler != null)
         {
            this._dragHandler.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         }
         this._dragHandler = param1;
         this._dragHandler.mouseChildren = false;
         this._dragHandler.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
      }
      
      protected function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
         this._dragHandler.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this._dragHandler.addEventListener(MouseEvent.RIGHT_CLICK,this.onStopDrag);
         TweenPlugin.activate([GlowFilterPlugin]);
         TweenMax.to(this,1,{"glowFilter":{
            "color":13491257,
            "blurX":6,
            "blurY":6,
            "strength":10,
            "alpha":1
         }});
         TweenMax.delayedCall(10,this.onStopDrag);
      }
      
      public function onStopDrag(param1:MouseEvent = null) : void
      {
         this.stopDrag();
         this._dragHandler.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this._dragHandler.removeEventListener(MouseEvent.RIGHT_CLICK,this.onStopDrag);
         this.lastLocation.x = this.x;
         this.lastLocation.y = this.y;
         this.fPoint.x = Connectr.instance.layerModel.stage.stageWidth;
         this.fPoint.y = Connectr.instance.layerModel.stage.stageHeight;
         TweenPlugin.activate([GlowFilterPlugin]);
         TweenMax.to(this,1,{"glowFilter":{
            "color":13491257,
            "blurX":6,
            "blurY":6,
            "strength":10,
            "alpha":0
         }});
      }
      
      public function dispose() : void
      {
         TweenMax.killDelayedCallsTo(this.onStopDrag);
         if(this._isDisposed)
         {
            return;
         }
         this.panelWidth = this.panelHeight = 0;
         Dispatcher.removeEventListener(GameEvent.RESIZE,this.onResize);
         if(this.lastLocation == null)
         {
            this.lastLocation = new Point();
         }
         this.lastLocation.x = this.x;
         this.lastLocation.y = this.y;
         this.fPoint.x = Connectr.instance.layerModel.stage.stageWidth;
         this.fPoint.y = Connectr.instance.layerModel.stage.stageHeight;
         this.visible = false;
         if(this._bgHandler)
         {
            this._bgHandler = null;
         }
         if(this._dragHandler)
         {
            this.stopDrag();
            this._dragHandler.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
            this._dragHandler.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
            this._dragHandler.removeEventListener(MouseEvent.RIGHT_CLICK,this.onStopDrag);
            this._dragHandler = null;
         }
         this._isDisposed = true;
      }
      
      public function init() : void
      {
         this.visible = false;
         this._isDisposed = false;
         if(this.panelWidth == 0)
         {
            this.panelWidth = this.width;
         }
         if(this.panelHeight == 0)
         {
            this.panelHeight = this.height;
         }
         if(this.lastLocation == null)
         {
            this.x = (Connectr.instance.layerModel.stage.stageWidth - this.panelWidth) / 2;
            this.y = (Connectr.instance.layerModel.stage.stageHeight - this.panelHeight) / 2;
            this.lastLocation = new Point(this.x,this.y);
            this.fPoint = new Point();
            this.fPoint.x = Connectr.instance.layerModel.stage.stageWidth;
            this.fPoint.y = Connectr.instance.layerModel.stage.stageHeight;
         }
         else
         {
            this.onResize(null);
         }
         Dispatcher.addEventListener(GameEvent.RESIZE,this.onResize);
      }
      
      private function onResize(param1:GameEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.parent == Connectr.instance.layerModel.notificationMessageLayer)
         {
            return;
         }
         if(this.data.type == PanelType.STATIC)
         {
            this.x = (Connectr.instance.layerModel.stage.stageWidth - this.panelWidth) / 2;
            this.y = (Connectr.instance.layerModel.stage.stageHeight - this.panelHeight) / 2;
         }
         else
         {
            _loc2_ = Connectr.instance.layerModel.stage.stageWidth / this.fPoint.x;
            _loc3_ = Connectr.instance.layerModel.stage.stageHeight / this.fPoint.y;
            this.x = _loc2_ * this.lastLocation.x;
            this.y = _loc3_ * this.lastLocation.y;
         }
      }
      
      public function get data() : PanelVO
      {
         return this._data;
      }
      
      public function set data(param1:PanelVO) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
      }
      
      public function get isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function show() : void
      {
         if(Connectr.instance.panelModel)
         {
            Connectr.instance.panelModel.showBg(this.data,this);
         }
         Mouse.cursor = MouseCursor.AUTO;
         this.visible = true;
         this.alpha = 1;
         if(this.data && this.data.type != null && this.data.type == PanelType.STATIC)
         {
            this.x = (Connectr.instance.layerModel.stage.stageWidth - this.panelWidth) / 2;
            this.y = (Connectr.instance.layerModel.stage.stageHeight - this.panelHeight) / 2;
         }
         if(this.data && this.data.type != null && this.data.type != PanelType.CORE && this.data.type != PanelType.ALERT)
         {
            TweenMax.from(this,0.3,{
               "y":this.y - 20,
               "alpha":0.5,
               "ease":Back.easeOut
            });
         }
      }
   }
}

