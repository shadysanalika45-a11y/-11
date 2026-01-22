package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   
   public class SceneZoomComponent extends BaseSceneComponent
   {
      
      public function SceneZoomComponent(param1:IScene)
      {
         super(param1);
         Dispatcher.addEventListener("HudEvent.ZOOM_IN",onGestureZoom);
         Dispatcher.addEventListener("HudEvent.ZOOM_OUT",onGestureZoom);
      }
      
      private function onGestureZoom(param1:HudEvent) : void
      {
         if(Sanalika.instance.scaleModel.enabled)
         {
            if(Sanalika.instance.scaleModel.isLandscape)
            {
            }
            if(param1.type == "HudEvent.ZOOM_OUT")
            {
               if(Sanalika.instance.airModel.isMobile())
               {
                  Sanalika.instance.scaleModel.currentScale -= 0.5;
               }
               else
               {
                  Sanalika.instance.scaleModel.currentScale -= 0.1;
               }
            }
            else if(Sanalika.instance.airModel.isMobile())
            {
               Sanalika.instance.scaleModel.currentScale += 0.5;
            }
            else
            {
               Sanalika.instance.scaleModel.currentScale += 0.1;
            }
         }
      }
      
      override public function dispose() : void
      {
         isDisposed = true;
         Dispatcher.removeEventListener("HudEvent.ZOOM_IN",onGestureZoom);
         Dispatcher.removeEventListener("HudEvent.ZOOM_OUT",onGestureZoom);
      }
   }
}

