package com.oyunstudyosu.model
{
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class VersionModel
   {
      
      public var filePath:String;
      
      private var FileLoader:URLLoader;
      
      public function VersionModel(param1:String)
      {
         super();
         this.filePath = param1;
         getFile();
      }
      
      public function getFile() : void
      {
         if(!Sanalika.instance.gameModel.debug)
         {
            filePath = Sanalika.instance.gameModel.fileServer + filePath;
         }
         FileLoader = new URLLoader();
         FileLoader.addEventListener("complete",fileLoaded);
         FileLoader.addEventListener("ioError",ioError);
         FileLoader.addEventListener("securityError",securityError);
         FileLoader.load(new URLRequest(filePath));
      }
      
      private function fileLoaded(param1:Event) : void
      {
         trace("loadingVersionFile");
         if(param1.target.data == null)
         {
            infoFileError(107);
            return;
         }
         var _loc2_:String = param1.target.data;
         if(_loc2_.length == 0)
         {
            infoFileError(108);
            return;
         }
         var _loc3_:String = Base64.decode(_loc2_);
         if(_loc3_ == null)
         {
            infoFileError(109);
            return;
         }
         if(_loc3_.length == 0)
         {
            infoFileError(110);
            return;
         }
         Sanalika.instance.moduleModel.init(_loc3_);
         _loc3_ = null;
         _loc2_ = null;
         Dispatcher.dispatchEvent(new GameEvent("VERSION_FILE_LOADED"));
         terminate();
      }
      
      private function ioError(param1:IOErrorEvent) : void
      {
         trace("IoError");
         trace(param1);
      }
      
      private function securityError(param1:Event) : void
      {
         trace("SecurityError");
      }
      
      public function updateVersionFile() : void
      {
      }
      
      private function infoFileError(param1:int) : void
      {
         trace("version file fail:" + param1);
      }
      
      private function terminate() : void
      {
         if(FileLoader == null)
         {
            return;
         }
         FileLoader.removeEventListener("complete",fileLoaded);
         FileLoader.removeEventListener("ioError",ioError);
         FileLoader.removeEventListener("securityError",securityError);
         FileLoader = null;
      }
   }
}

