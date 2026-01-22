package org.oyunstudyosu.alert
{
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.Panel;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol281")]
   public class SanalikaAlert extends Panel
   {
      
      private var view:IAlertView;
      
      public function SanalikaAlert()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         var _loc1_:Object = ApplicationDomain.currentDomain.getDefinition("org.oyunstudyosu.alert.views::" + data.params.alertType + "View");
         trace(data.params.alertType);
         this.view = new _loc1_();
         this.view.vo = Connectr.instance.alertModel.toAlertVo(data.params);
         if(this.view.vo.title == null)
         {
            this.view.vo.title = $(this.view.vo.alertType);
         }
         try
         {
            (this.view as MovieClip).height *= Connectr.instance.scaleModel.uiScale;
            (this.view as MovieClip).width *= Connectr.instance.scaleModel.uiScale;
         }
         catch(e:Error)
         {
         }
         addChild(this.view as CoreMovieClip);
         this.view.init();
         dragHandler = this.view.dragger();
         (this.view as EventDispatcher).addEventListener("closeClicked",this.closeClicked);
         show();
      }
      
      protected function closeClicked(param1:Event) : void
      {
         close();
      }
      
      override public function dispose() : void
      {
         if(this.view)
         {
            this.view.dispose();
            removeChild(this.view as CoreMovieClip);
            this.view = null;
         }
         super.dispose();
      }
   }
}

