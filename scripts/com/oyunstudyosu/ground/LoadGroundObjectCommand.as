package com.oyunstudyosu.ground
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.commands.Command;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import org.oyunstudyosu.assets.clips.CursorG;
   
   public class LoadGroundObjectCommand extends Command
   {
      
      private var questGroundObject:GroundObject;
      
      private var itemPath:String;
      
      private var request:AssetRequest;
      
      public function LoadGroundObjectCommand(param1:GroundObject)
      {
         super();
         this.questGroundObject = param1;
      }
      
      override public function execute() : void
      {
         itemPath = Sanalika.instance.moduleModel.getPath(questGroundObject.groundData.clip,"ModuleType.INVENTORY") + ".png";
         trace("itemPath",itemPath);
         request = new AssetRequest();
         request.assetId = itemPath;
         request.type = "ModuleType.PNG";
         request.loadedFunction = onLoaded;
         request.errorFunction = onError;
         request.context = Sanalika.instance.domainModel.generateContext("GroundObject");
         Sanalika.instance.assetModel.request(request);
      }
      
      private function onError(param1:Object) : void
      {
         request.dispose();
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:Bitmap = new Bitmap((param1.display as Bitmap).bitmapData.clone());
         if(_loc2_.height > 24)
         {
            _loc2_.width = _loc2_.width / _loc2_.height * 24;
            _loc2_.height = 24;
         }
         TweenMax.to(_loc2_,0.5,{
            "glowFilter":{
               "color":16777011,
               "alpha":1,
               "blurX":25,
               "blurY":25,
               "strength":3
            },
            "repeat":2,
            "yoyo":true
         });
         var _loc3_:MovieClip = new MovieClip();
         var _loc4_:CursorG = new CursorG();
         _loc2_.x = -_loc2_.width / 2;
         _loc2_.y = 4 - _loc2_.height;
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(_loc2_);
         questGroundObject.container.addChild(_loc3_);
         param1.dispose();
      }
   }
}

