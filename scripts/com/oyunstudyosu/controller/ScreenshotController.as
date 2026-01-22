package com.oyunstudyosu.controller
{
   import com.adobe.images.PNGEncoder;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.local.$;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.net.FileReference;
   
   public class ScreenshotController
   {
      
      private var stage:Stage;
      
      private var _type:String;
      
      public function ScreenshotController()
      {
         super();
         stage = Sanalika.instance.layerModel.stage;
         Dispatcher.addEventListener("SS_IMAGE",ssImage);
      }
      
      private function ssImage(param1:GameEvent = null) : void
      {
         var _loc5_:AlertVo = null;
         var _loc4_:BitmapData = null;
         if(Sanalika.instance.airModel.isMobile())
         {
            _loc5_ = new AlertVo();
            _loc5_.alertType = "tooltip";
            _loc5_.description = $("screenShotNA");
            Dispatcher.dispatchEvent(new AlertEvent(_loc5_));
            return;
         }
         if(param1.data)
         {
            _loc4_ = new BitmapData(param1.data.width,param1.data.height,true,16446696);
            _loc4_.draw(param1.data as MovieClip);
         }
         else
         {
            _loc4_ = new BitmapData(Sanalika.instance.scaleModel.width,Sanalika.instance.scaleModel.height,true,16446696);
            _loc4_.draw(Sanalika.instance.engine.scene.container);
         }
         var _loc3_:FileReference = new FileReference();
         _loc3_ = new FileReference();
         var _loc2_:Date = new Date();
         _loc3_.save(PNGEncoder.encode(_loc4_),"Sanalika_" + _loc2_.fullYear + "." + (_loc2_.month + 1) + "." + _loc2_.date + "." + _loc2_.hours + "." + _loc2_.minutes + "." + _loc2_.seconds + ".png");
      }
   }
}

