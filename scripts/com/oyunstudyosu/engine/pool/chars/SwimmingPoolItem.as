package com.oyunstudyosu.engine.pool.chars
{
   import com.oyunstudyosu.cloth.ClothType;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.character.SimpleCachedCharacterClip;
   import com.oyunstudyosu.engine.pool.controls.ItemControl;
   import com.oyunstudyosu.engine.pool.model.PoolItemDirection;
   import com.oyunstudyosu.engine.scene.components.SceneCameraComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.ProfileEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SwimmingPoolItem extends PoolItem
   {
      
      protected var bodyClipName:String = "m_SW_1";
      
      protected var _timeoutId:uint;
      
      protected var _isActive:Boolean = false;
      
      private var delta:Number;
      
      private var p:Point;
      
      private var body:MovieClip;
      
      private var bodyIndex:int;
      
      private var bodyDirection:String;
      
      private var hairDirection:String;
      
      private var hairClip:MovieClip;
      
      public function SwimmingPoolItem(param1:IScene, param2:ICharacter, param3:Number = 0, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         if(param2.sex == "f")
         {
            bodyClipName = "f_SW_1";
         }
         updateBody();
         isActive = true;
         visible = false;
      }
      
      protected function onBodyClipLoaded(param1:Event) : void
      {
         var _loc2_:MovieClip = Sanalika.instance.itemModel.getBodyPart(bodyClipName);
         if(_loc2_ != null)
         {
            _loc2_.name = "body";
            Sanalika.instance.itemModel.removeItemListener(onBodyClipLoaded);
            _loc2_.gotoAndStop(_status + _direction.toString());
            addChildAt(_loc2_,0);
         }
      }
      
      protected function enterFrameHandler(param1:Event) : void
      {
         if(pool == null)
         {
            Sanalika.instance.stage.removeEventListener("enterFrame",enterFrameHandler);
            removeEventListener("click",onMouseClick);
            control.destroy();
            visible = true;
            return;
         }
         PoolItemDirection.setDirection(this);
         updateItem();
         pool.depthSort();
         visible = true;
      }
      
      protected function getOut() : void
      {
         control.setKeyUp(32);
      }
      
      override public function updateBody() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:* = undefined;
         var _loc2_:MovieClip = null;
         var _loc3_:int = numChildren;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            removeChildAt(0);
            _loc5_++;
         }
         var _loc4_:MovieClip = Sanalika.instance.itemModel.getBodyPart(bodyClipName);
         if(_loc4_ == null)
         {
            Sanalika.instance.itemModel.addItemListener(onBodyClipLoaded);
         }
         else
         {
            _loc4_.name = "body";
            _loc4_.gotoAndStop(_status + _direction.toString());
            addChildAt(_loc4_,0);
         }
         _loc6_ = 0;
         while(_loc6_ < character.container.numChildren)
         {
            _loc1_ = character.container.getChildAt(_loc6_);
            if(!(_loc1_ is SimpleCachedCharacterClip))
            {
               if(_loc1_.hasOwnProperty("placeBit"))
               {
                  if(_loc1_.placeBit >= ClothType.BIT16_FACIAL_HAIR && _loc1_.placeBit <= ClothType.BIT20_HAT || _loc1_.placeBit == ClothType.BIT02_BODY_TOP)
                  {
                     _loc2_ = duplicateDisplayObject(_loc1_) as MovieClip;
                     _loc2_.gotoAndStop("i" + _direction.toString());
                     addChild(_loc2_);
                  }
               }
            }
            _loc6_++;
         }
         super.updateBody();
      }
      
      override public function update(param1:String) : void
      {
         super.update(param1);
      }
      
      override public function initialize(param1:String) : void
      {
         visible = true;
         super.initialize(param1);
         updateItem();
      }
      
      override public function updateItem() : void
      {
         var _loc1_:SceneCameraComponent = null;
         var _loc2_:int = 0;
         try
         {
            delta = _status == "ga" ? 60 : 30;
            p = Sanalika.instance.engine.scene.getPosFromGrid(pool.location.x + _nonIsoX,pool.location.y + _nonIsoY);
            if(this.x == p.x - parent.x && this.y == p.y - parent.y + delta)
            {
               return;
            }
            this.y = p.y - parent.y + delta;
            this.x = p.x - parent.x;
            if(character.isMe && scene.existsComponent(SceneCameraComponent))
            {
               _loc1_ = scene.getComponent(SceneCameraComponent) as SceneCameraComponent;
               _loc1_.screenShiftTo(x + pool.x,y + pool.y);
            }
            body = getChildByName("body") as MovieClip;
            bodyIndex = -1;
            bodyDirection = _status + _direction.toString();
            if(body != null)
            {
               body.gotoAndStop(bodyDirection);
               bodyIndex = getChildIndex(body);
            }
            _loc2_ = 0;
            while(_loc2_ < numChildren)
            {
               if(_loc2_ != bodyIndex)
               {
                  hairDirection = "i" + _direction.toString();
                  hairClip = getChildAt(_loc2_) as MovieClip;
                  hairClip.gotoAndStop(hairDirection);
               }
               _loc2_++;
            }
            if(numChildren < 2)
            {
               updateBody();
            }
         }
         catch(error:Error)
         {
            (getChildAt(0) as MovieClip).stop();
         }
         super.updateItem();
      }
      
      public function duplicateDisplayObject(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc5_:Rectangle = null;
         var _loc4_:Class = Object(param1).constructor as Class;
         var _loc3_:DisplayObject = new _loc4_();
         _loc3_.transform = param1.transform;
         _loc3_.filters = param1.filters;
         _loc3_.cacheAsBitmap = param1.cacheAsBitmap;
         if(Sanalika.instance.airModel.isMobile())
         {
            _loc3_.cacheAsBitmap = true;
            (_loc3_ as MovieClip).cacheAsBitmapMatrix = new Matrix();
         }
         _loc3_.opaqueBackground = param1.opaqueBackground;
         if(param1.scale9Grid)
         {
            _loc5_ = param1.scale9Grid;
            _loc3_.scale9Grid = _loc5_;
         }
         if(param2 && param1.parent)
         {
            param1.parent.addChild(_loc3_);
         }
         return _loc3_;
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:ProfileEvent = new ProfileEvent("AvatarProfileEvent.SHOW_PROFILE");
         _loc2_.avatarID = character.id;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(_isActive)
         {
            return;
         }
         _isActive = param1;
         if(_isActive)
         {
            control = new ItemControl(Sanalika.instance.layerModel.stage,this,true,0.15);
            if(character.isMe)
            {
               control.enableKeys();
            }
            Sanalika.instance.layerModel.stage.addEventListener("enterFrame",enterFrameHandler);
            this.addEventListener("click",onMouseClick);
         }
         else
         {
            Sanalika.instance.layerModel.stage.removeEventListener("enterFrame",enterFrameHandler);
            removeEventListener("click",onMouseClick);
            control.destroy();
            visible = true;
         }
      }
      
      protected function setControl(param1:int, param2:int) : void
      {
         control.initRotation = param2;
         control.initX = param1;
      }
      
      override public function kill() : void
      {
         Sanalika.instance.layerModel.stage.removeEventListener("enterFrame",enterFrameHandler);
         control.destroy();
         isActive = false;
         super.kill();
      }
   }
}

