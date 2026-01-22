package com.oyunstudyosu.video
{
   import flash.display.Sprite;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class VideoPlayer extends Sprite
   {
      
      private var videoURL:String;
      
      private var connection:NetConnection;
      
      private var stream:NetStream;
      
      private var video:Video = new Video(294 * 1.77,300);
      
      public function VideoPlayer()
      {
         super();
      }
      
      public function setDimension(param1:int, param2:int) : void
      {
         this.video.width = param1;
         this.video.height = param2;
      }
      
      public function setVideoURL(param1:String) : void
      {
         trace("setVideoURL:" + param1);
         this.videoURL = param1;
         this.connection = new NetConnection();
         this.connection.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
         this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this.connection.connect(null);
      }
      
      private function netStatusHandler(param1:NetStatusEvent) : void
      {
         switch(param1.info.code)
         {
            case "NetConnection.Connect.Success":
               this.connectStream();
               break;
            case "NetStream.Play.StreamNotFound":
               trace("Stream not found: " + this.videoURL);
         }
         dispatchEvent(param1);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         trace("securityErrorHandler: " + param1);
      }
      
      private function connectStream() : void
      {
         addChild(this.video);
         this.stream = new NetStream(this.connection);
         this.stream.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
         this.stream.client = new CustomClient();
         this.video.attachNetStream(this.stream);
         this.stream.play(this.videoURL);
      }
      
      public function onClose() : void
      {
         if(this.stream)
         {
            this.stream.close();
         }
      }
   }
}

class CustomClient
{
   
   public function CustomClient()
   {
      super();
   }
   
   public function onMetaData(param1:Object) : void
   {
      trace("metadata: duration=" + param1.duration + " width=" + param1.width + " height=" + param1.height + " framerate=" + param1.framerate);
   }
   
   public function onXMPData(param1:Object) : void
   {
   }
   
   public function onCuePoint(param1:Object) : void
   {
      trace("cuepoint: time=" + param1.time + " name=" + param1.name + " type=" + param1.type);
   }
   
   public function onPlayStatus(param1:Object) : void
   {
   }
}
