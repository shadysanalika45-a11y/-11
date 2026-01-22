package com.oyunstudyosu.model
{
   import com.adobe.images.JPGEncoder;
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.utils.Logger;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.ByteArray;
   
   public class ExternalModel
   {
      
      public function ExternalModel()
      {
         super();
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("exportScreenshot",exportScreenshot);
            ExternalInterface.addCallback("scroll",scroll);
         }
         if(Capabilities.playerType != "Desktop")
         {
            Security.allowDomain("*");
         }
      }
      
      private function exportScreenshot() : String
      {
         var _loc2_:* = null;
         var _loc4_:BlurFilter = null;
         var _loc3_:BitmapData = null;
         var _loc6_:JPGEncoder = null;
         var _loc1_:ByteArray = null;
         var _loc5_:String = null;
         try
         {
            _loc2_ = null;
            _loc4_ = new BlurFilter(2,2,1);
            _loc3_ = new BitmapData(Sanalika.instance.layerModel.stage.stageWidth,Sanalika.instance.layerModel.stage.stageHeight,false,16446696);
            _loc3_.draw(Sanalika.instance.layerModel.stage);
            _loc3_.applyFilter(_loc3_,_loc3_.rect,new Point(0,0),_loc4_);
            _loc6_ = new JPGEncoder(80);
            _loc1_ = _loc6_.encode(_loc3_);
            if(_loc1_)
            {
               _loc5_ = Base64.encodeByteArray(_loc1_);
               if(_loc5_)
               {
                  _loc2_ = _loc5_;
               }
            }
            return _loc2_;
         }
         catch(error:Error)
         {
            Logger.log(error.getStackTrace(),true);
         }
         return null;
      }
      
      private function scroll(param1:int) : void
      {
      }
   }
}

