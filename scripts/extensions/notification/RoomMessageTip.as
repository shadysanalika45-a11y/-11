package extensions.notification
{
   import com.oyunstudyosu.door.IProperty;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.assets.clips.RoomMessageTipUI;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   public class RoomMessageTip extends CoreMovieClip
   {
      
      private static const PADDING:int = 10;
      
      public var property:IProperty;
      
      public var ui:RoomMessageTipUI;
      
      public function RoomMessageTip()
      {
         super();
         ui = new RoomMessageTipUI();
         addChild(ui);
         ui.cacheAsBitmap = true;
      }
      
      override public function added() : void
      {
         ui.btnClose.addEventListener("click",closeClicked);
         this.addEventListener("mouseOver",overHandler);
         this.addEventListener("mouseOut",outHandler);
      }
      
      public function addClickEvent(param1:IProperty) : void
      {
         this.property = param1;
         this.buttonMode = true;
         this.mouseChildren = true;
         ui.background.addEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         property.execute();
      }
      
      private function addedToStage(param1:Event) : void
      {
      }
      
      private function closeClicked(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("closeClicked"));
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("overMessage"));
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("outMessage"));
      }
      
      override public function removed() : void
      {
         this.removeEventListener("mouseOver",overHandler);
         this.removeEventListener("mouseOut",outHandler);
         ui.btnClose.removeEventListener("click",closeClicked);
      }
   }
}

