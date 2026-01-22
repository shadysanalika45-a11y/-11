package org.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.timer.SyncTimer;
   import feathers.controls.ScrollContainer;
   import feathers.controls.ScrollPolicy;
   import feathers.layout.HorizontalAlign;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalAlign;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1398")]
   public class LobbyUI extends MovieClip
   {
      
      public var timer:LobbyUITimer;
      
      public var container:ScrollContainer;
      
      private var items:Array = [];
      
      public var maxUsers:int = 0;
      
      private var targetTimestamp:int = 0;
      
      public function LobbyUI()
      {
         super();
         this.timer.visible = false;
         this.container = new ScrollContainer();
         this.container.backgroundSkin = new Sprite();
         this.container.scrollPolicyY = ScrollPolicy.OFF;
         this.container.width = 400;
         this.container.height = 210;
         this.container.x = 5;
         this.container.y = 5;
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.set_gap(5);
         _loc1_.set_horizontalAlign(HorizontalAlign.CENTER);
         _loc1_.set_verticalAlign(VerticalAlign.MIDDLE);
         this.container.layout = _loc1_;
         addChild(this.container);
         this.addEventListener(Event.ENTER_FRAME,this.onUpdate);
      }
      
      public function setTimer(param1:int) : void
      {
         this.targetTimestamp = param1;
      }
      
      private function onUpdate(param1:Event) : void
      {
         var _loc2_:int = this.targetTimestamp - SyncTimer.timestamp;
         if(_loc2_ > -5)
         {
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.timer.visible = true;
            this.timer.txtTimer.text = _loc2_.toString();
         }
         else
         {
            this.timer.visible = false;
         }
      }
      
      public function add(param1:LobbyUIItem) : void
      {
         this.items.push(param1);
         this.update();
      }
      
      public function remove(param1:LobbyUIItem) : void
      {
         this.items.removeAt(this.items.indexOf(param1));
         this.update();
      }
      
      private function update() : void
      {
         var _loc1_:LobbyUIItem = null;
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:LobbyUIItem = null;
         this.container.removeChildren();
         for each(_loc1_ in this.items)
         {
            this.container.addChild(_loc1_);
         }
         _loc2_ = this.maxUsers - this.items.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new LobbyUIItem();
            _loc4_.init();
            this.container.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      public function updateStatus(param1:String, param2:Boolean) : void
      {
         var _loc3_:LobbyUIItem = this.container.getChildByName(param1) as LobbyUIItem;
         if(_loc3_ != null)
         {
            if(param2)
            {
               _loc3_.sTxtStatus.text = Connectr.instance.localizationModel.translate("Joined");
            }
            else
            {
               _loc3_.sTxtStatus.text = Connectr.instance.localizationModel.translate("Joining");
            }
         }
      }
   }
}

