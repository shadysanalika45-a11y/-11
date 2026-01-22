package org.oyunstudyosu.assets.snowball
{
   import com.oyunstudyosu.local.$;
   import feathers.controls.ScrollContainer;
   import feathers.controls.ScrollPolicy;
   import feathers.layout.HorizontalAlign;
   import feathers.layout.VerticalLayout;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol962")]
   public class Board extends MovieClip
   {
      
      public var bg:MovieClip;
      
      private var container:ScrollContainer;
      
      public var txtHeader:TextField;
      
      public function Board()
      {
         super();
         this.txtHeader.text = $("bestPlayer");
         this.container = new ScrollContainer();
         this.container.backgroundSkin = new Sprite();
         this.container.scrollPolicyY = ScrollPolicy.OFF;
         this.container.width = 200;
         this.container.height = 100;
         this.container.y = 25;
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.set_horizontalAlign(HorizontalAlign.CENTER);
         this.container.layout = _loc1_;
         addChild(this.container);
      }
      
      public function add(param1:Object) : void
      {
         var _loc2_:String = param1.avatarName;
         var _loc3_:int = int(param1.score);
         var _loc4_:int = int(param1.amount);
         var _loc5_:Boolean = Boolean(param1.hasItem);
         var _loc6_:Boolean = Boolean(param1.hasSticker);
         var _loc7_:BoardItem = new BoardItem();
         _loc7_.x = _loc7_.y = 0;
         _loc7_.txtPosition.text = this.container.numChildren + 1 + ".";
         _loc7_.txtAvatarName.text = _loc2_;
         _loc7_.txtHit.text = Std.string(_loc3_);
         _loc7_.txtSanil.text = Std.string(_loc4_);
         _loc7_.mcGift.visible = _loc5_;
         _loc7_.mcSticker.visible = _loc6_;
         if(param1.team == "BLUE")
         {
            _loc7_.txtPosition.textColor = 65535;
            _loc7_.txtAvatarName.textColor = 65535;
         }
         if(param1.team == "GREEN")
         {
            _loc7_.txtPosition.textColor = 6750054;
            _loc7_.txtAvatarName.textColor = 6750054;
         }
         this.container.addChild(_loc7_);
      }
      
      public function clear() : void
      {
         this.container.removeChildren();
      }
   }
}

