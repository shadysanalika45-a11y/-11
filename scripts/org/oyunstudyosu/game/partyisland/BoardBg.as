package org.oyunstudyosu.game.partyisland
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import com.oyunstudyosu.game.partyisland.components.IIslandLeaderboardComponent;
   import com.oyunstudyosu.game.partyisland.components.IIslandPartyPlayerComponent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import feathers.controls.LayoutGroup;
   import feathers.layout.VerticalLayout;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1377")]
   public class BoardBg extends MovieClip
   {
      
      public var txtSpectator:TextField;
      
      public var container:LayoutGroup;
      
      public function BoardBg()
      {
         super();
         this.container = new LayoutGroup();
         this.container.width = 230;
         this.container.height = 330;
         this.container.y = 30;
         this.container.x = 0;
         var _loc1_:VerticalLayout = new VerticalLayout();
         this.container.layout = _loc1_;
         addChild(this.container);
      }
      
      public function updateSpectatorCount(param1:int) : void
      {
         this.txtSpectator.text = param1.toString();
      }
      
      public function add(param1:PartyPlayerVo) : void
      {
         var _loc2_:BoardItem = new BoardItem();
         _loc2_.name = "character_" + param1.character.id;
         this.container.addChild(_loc2_);
      }
      
      public function remove(param1:PartyPlayerVo) : void
      {
         var _loc2_:BoardItem = this.container.getChildByName("character_" + param1.character.id) as BoardItem;
         if(_loc2_ != null)
         {
            this.container.removeChild(_loc2_);
         }
      }
      
      public function update() : void
      {
         var _loc3_:PartyPlayerVo = null;
         var _loc4_:BoardItem = null;
         var _loc1_:IIslandLeaderboardComponent = Connectr.instance.engine.scene.getComponent(IIslandLeaderboardComponent) as IIslandLeaderboardComponent;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_.orderedItems.length)
         {
            _loc3_ = _loc1_.orderedItems[_loc2_];
            _loc4_ = this.container.getChildByName("character_" + _loc3_.character.id) as BoardItem;
            if(_loc4_ != null)
            {
               _loc4_.txtPosition.text = (_loc2_ + 1).toString() + ".";
               _loc4_.txtAvatarName.text = _loc3_.character.avatarName;
               if(_loc3_.balance != _loc3_.lastBalance)
               {
                  this.updateAnimatedTextField(_loc4_.txtBalance,_loc3_.balance);
                  _loc3_.lastBalance = _loc3_.balance;
               }
               if(_loc3_.poolBalance != _loc3_.lastPoolBalance)
               {
                  this.updateAnimatedTextField(_loc4_.txtPool,_loc3_.poolBalance);
                  _loc3_.lastPoolBalance = _loc3_.poolBalance;
               }
               if(_loc3_.turnIndex == -1)
               {
                  _loc4_.alpha = 0.5;
                  this.container.setChildIndex(_loc4_,this.container.numChildren - 1);
               }
               else
               {
                  _loc4_.alpha = 1;
                  this.container.setChildIndex(_loc4_,_loc3_.turnIndex);
               }
            }
            _loc2_++;
         }
      }
      
      public function highlightTurn(param1:String) : void
      {
         var _loc4_:PartyPlayerVo = null;
         var _loc5_:BoardItem = null;
         if(!Connectr.instance.engine.scene.existsComponent(IIslandPartyPlayerComponent))
         {
            return;
         }
         var _loc2_:IIslandPartyPlayerComponent = Connectr.instance.engine.scene.getComponent(IIslandPartyPlayerComponent);
         var _loc3_:Dictionary = _loc2_.items;
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this.container.getChildByName("character_" + _loc4_.character.id) as BoardItem;
            if(_loc5_ != null)
            {
               if(_loc4_.character.id == param1)
               {
                  _loc5_.filters = [new GlowFilter(16776960,1,10,10,1,1,false,false)];
               }
               else
               {
                  _loc5_.filters = [];
               }
            }
         }
      }
      
      public function updateAnimatedTextField(param1:TextField, param2:int) : void
      {
         var valueObject:Object = null;
         var textfield:TextField = param1;
         var value:int = param2;
         var textValue:int = parseInt(textfield.text);
         if(textValue == value)
         {
            return;
         }
         valueObject = {};
         valueObject.value = textValue;
         TweenLite.to(valueObject,0.5,{
            "value":value,
            "ease":Quad.easeOut,
            "onUpdate":function():*
            {
               textfield.text = Math.round(valueObject.value).toString();
            }
         });
      }
   }
}

