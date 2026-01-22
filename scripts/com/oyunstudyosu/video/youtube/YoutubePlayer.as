package com.oyunstudyosu.video.youtube
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class YoutubePlayer extends Bitmap
   {
      
      private var stageWebView:Object;
      
      public var isReady:Boolean = true;
      
      public var superX:Number = 0;
      
      public var superY:Number = 0;
      
      public var superWidth:Number = 0;
      
      public var superHeight:Number = 0;
      
      public function YoutubePlayer()
      {
         super();
         Sanalika.instance.stage.addEventListener("enterFrame",onEnterFrame);
         if(!Sanalika.instance.loaderInfo.applicationDomain.hasDefinition("flash.media.StageWebView"))
         {
            stageWebView = null;
            return;
         }
         var _loc1_:Class = Sanalika.instance.loaderInfo.applicationDomain.getDefinition("flash.media.StageWebView") as Class;
         stageWebView = new _loc1_(false);
         stageWebView.stage = Sanalika.instance.stage;
         stageWebView.mediaPlaybackRequiresUserAction = false;
         Sanalika.instance.layerModel.youtubeLayer.addChildAt(this,0);
      }
      
      public function loadVideoById(param1:String, param2:Number, param3:String) : void
      {
         if(stageWebView == null)
         {
            return;
         }
         stageWebView.loadURL("https://www.youtube.com/embed/" + param1 + "?autoplay=1&start=" + param2 + "&vq=" + param3);
         stageWebView.assignFocus();
      }
      
      public function stopVideo() : void
      {
         if(stageWebView == null)
         {
            return;
         }
         stageWebView.loadURL("about:blank");
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(stageWebView == null)
         {
            return;
         }
         __updatePlayerSize();
         var _loc2_:Number = Sanalika.instance.scaleModel.currentScale;
         var _loc4_:Number = Math.floor(superWidth * _loc2_);
         var _loc3_:Number = Math.floor(superHeight * _loc2_);
         stageWebView.viewPort = new Rectangle(-_loc4_,-_loc3_,_loc4_,_loc3_);
         if(bitmapData == null || bitmapData.width != _loc4_ || bitmapData.height != _loc3_)
         {
            bitmapData = new BitmapData(_loc4_,_loc3_);
         }
         stageWebView.drawViewPortToBitmapData(bitmapData);
      }
      
      private function __updatePlayerSize() : void
      {
         if(Sanalika.instance.engine == null || Sanalika.instance.engine.scene == null)
         {
            return;
         }
         var _loc1_:Number = Sanalika.instance.scaleModel.currentScale;
         var _loc3_:Number = Sanalika.instance.engine.scene.xBase / _loc1_;
         var _loc2_:Number = Sanalika.instance.engine.scene.yBase / _loc1_;
         this.x = Math.floor((superX + Sanalika.instance.layerModel.gameLayer.x / _loc1_ + _loc3_) * _loc1_);
         this.y = Math.floor((superY + Sanalika.instance.layerModel.gameLayer.y / _loc1_ + _loc2_) * _loc1_);
      }
   }
}

