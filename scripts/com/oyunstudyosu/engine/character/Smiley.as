package com.oyunstudyosu.engine.character
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.net.URLRequest;
   
   public class Smiley extends MovieClip
   {
      
      public var key:String;
      
      private var loader:Loader;
      
      private var urlRequest:URLRequest;
      
      public var classType:Class;
      
      public var loadedInstance:DisplayObject;
      
      private var request:IAssetRequest;
      
      public function Smiley(param1:String)
      {
         super();
         this.key = param1;
         load();
      }
      
      private function load() : void
      {
         var _loc2_:int = Sanalika.instance.itemModel.getVersion(key);
         var _loc1_:String = "";
         if(_loc2_ > 0)
         {
            _loc1_ = "." + _loc2_;
         }
         request = new AssetRequest();
         request.name = key;
         request.assetId = Sanalika.instance.moduleModel.getPath(key,"ModuleType.SMILEY") + _loc1_ + ".swf";
         request.type = "ModuleType.SMILEY";
         request.loadedFunction = onLoaded;
         request.context = Sanalika.instance.domainModel.subContext;
         request.priority = 0;
         request.clone = true;
         Sanalika.instance.assetModel.request(request);
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         loadedInstance = param1.display;
         loadedInstance.x = -loadedInstance.width / 2;
         loadedInstance.y = -loadedInstance.height - 4;
         this.addChild(loadedInstance);
      }
   }
}

