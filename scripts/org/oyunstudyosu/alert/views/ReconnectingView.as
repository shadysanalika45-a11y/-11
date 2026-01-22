package org.oyunstudyosu.alert.views
{
   import com.oyunstudyosu.alert.IAlertVo;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.TextFieldManager;
   import com.smartfoxserver.v2.core.SFSEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import org.oyunstudyosu.alert.IAlertView;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol260")]
   public class ReconnectingView extends CoreMovieClip implements IAlertView
   {
      
      private var title:TextField;
      
      private var description:TextField;
      
      private var dot:Sprite;
      
      private var direction:int;
      
      private var _vo:IAlertVo;
      
      public function ReconnectingView()
      {
         super();
         var _loc1_:Sprite = new Sprite();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.graphics.beginFill(2236962);
         _loc1_.graphics.drawRoundRect(0,0,300,62,12,12);
         _loc1_.graphics.endFill();
         _loc1_.alpha = 0.9;
         this.addChild(_loc1_);
         var _loc2_:TextFormat = new TextFormat("Co Text Bold",16,null,false);
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.color = 16448250;
         this.title = new TextField();
         this.title.x = 10;
         this.title.width = _loc1_.width - 20;
         this.title.defaultTextFormat = _loc2_;
         this.addChild(this.title);
         this.title = TextFieldManager.convertAsArabicTextField(this.title);
         var _loc3_:TextFormat = new TextFormat("Co Text",14,null,false);
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.color = 13290186;
         this.description = new TextField();
         this.description.defaultTextFormat = _loc3_;
         this.description.y = 20;
         this.description.x = 10;
         this.description.width = _loc1_.width - 20;
         this.description.wordWrap = true;
         this.description.multiline = true;
         this.addChild(this.description);
         this.description = TextFieldManager.convertAsArabicTextField(this.description);
         this.direction = 1;
         this.dot = new Sprite();
         this.dot.x = 10;
         this.dot.y = 50;
         this.dot.graphics.beginFill(16777215);
         this.dot.graphics.drawCircle(0,0,8);
         this.dot.graphics.endFill();
         this.addChild(this.dot);
      }
      
      public function get vo() : IAlertVo
      {
         return this._vo;
      }
      
      public function set vo(param1:IAlertVo) : void
      {
         this._vo = param1;
      }
      
      public function onEnterFrameHandler(param1:Event) : void
      {
         this.dot.x += 5 * this.direction;
         if(this.dot.x > 280)
         {
            this.direction = -1;
         }
         else if(this.dot.x < 10)
         {
            this.direction = 1;
         }
      }
      
      public function dragger() : MovieClip
      {
         return new MovieClip();
      }
      
      public function init() : void
      {
         this.title.text = Connectr.instance.localizationModel.translate(this.vo.title);
         this.description.text = Connectr.instance.localizationModel.translate(this.vo.description);
         Connectr.instance.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         Connectr.instance.serviceModel.sfs.addEventListener(SFSEvent.CONNECTION_RESUME,this.onConnectionStateEvent);
         Connectr.instance.serviceModel.sfs.addEventListener(SFSEvent.CONNECTION_LOST,this.onConnectionStateEvent);
      }
      
      private function onConnectionStateEvent(param1:SFSEvent) : void
      {
         dispatchEvent(new Event("closeClicked"));
      }
      
      public function dispose() : void
      {
         Connectr.instance.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         Connectr.instance.serviceModel.sfs.removeEventListener(SFSEvent.CONNECTION_RESUME,this.onConnectionStateEvent);
         Connectr.instance.serviceModel.sfs.removeEventListener(SFSEvent.CONNECTION_LOST,this.onConnectionStateEvent);
      }
   }
}

