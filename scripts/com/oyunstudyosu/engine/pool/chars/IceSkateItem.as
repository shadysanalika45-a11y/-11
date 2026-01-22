package com.oyunstudyosu.engine.pool.chars
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.oyunstudyosu.cloth.ClothType;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.pool.controls.ItemControl;
   import com.oyunstudyosu.engine.pool.model.GamePoolModel;
   import com.oyunstudyosu.engine.pool.model.PoolItemDirection;
   import com.oyunstudyosu.engine.scene.components.ISceneCameraComponent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class IceSkateItem extends PoolItem
   {
      
      protected var _timeoutId:uint;
      
      protected var _isActive:Boolean = false;
      
      protected var _isAction:Boolean = false;
      
      protected var actionDirections:Array;
      
      protected var cloths:Array;
      
      protected var char:ICharacter;
      
      public function IceSkateItem(param1:IScene, param2:ICharacter, param3:Number = 0, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         this.char = param2;
         if(param2.isMe)
         {
            if(setCloth() != -1)
            {
               updateBody();
               isActive = true;
               visible = false;
            }
         }
         else
         {
            if(param2.sex == "m")
            {
               bodyclip = "m_0804_9";
            }
            else
            {
               bodyclip = "f_0804_3";
            }
            updateBody();
            isActive = true;
            visible = false;
         }
      }
      
      private function setCloth() : int
      {
         if(GamePoolModel.canskateByCloth())
         {
            if(char.sex == "m")
            {
               bodyclip = "m_0804_" + GamePoolModel.iceClothColor;
            }
            else
            {
               bodyclip = "f_0804_" + GamePoolModel.iceClothColor;
            }
            return GamePoolModel.iceClothColor;
         }
         return -1;
      }
      
      protected function onBodyClipLoaded(param1:Event) : void
      {
         var _loc2_:MovieClip = Sanalika.instance.itemModel.getBodyPart(bodyclip);
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
         if(!isAction)
         {
            PoolItemDirection.setDirection(this);
            updateItem();
            pool.depthSort();
            visible = true;
         }
      }
      
      override public function updateBody() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:int = numChildren;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            removeChildAt(0);
            _loc5_++;
         }
         var _loc4_:MovieClip = Sanalika.instance.itemModel.getBodyPart(bodyclip);
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
            _loc1_ = MovieClip(character.container.getChildAt(_loc6_));
            if(_loc1_.hasOwnProperty("placeBit"))
            {
               if(_loc1_.placeBit >= ClothType.BIT16_FACIAL_HAIR && _loc1_.placeBit <= ClothType.BIT20_HAT || _loc1_.placeBit == ClothType.BIT02_BODY_TOP)
               {
                  _loc2_ = duplicateDisplayObject(_loc1_) as MovieClip;
                  _loc2_.gotoAndStop("i" + _direction.toString());
                  addChild(_loc2_);
               }
            }
            _loc6_++;
         }
         super.updateBody();
      }
      
      override public function update(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         if(_loc2_[2] == "space")
         {
            _status = "ga";
            setAction();
            return;
         }
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
         var _loc4_:Point = null;
         var _loc2_:ISceneCameraComponent = null;
         var _loc1_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc3_:String = null;
         var _loc6_:MovieClip = null;
         try
         {
            _loc4_ = scene.getPosFromGrid(pool.location.x + _nonIsoX,pool.location.y + _nonIsoY);
            y = _loc4_.y - parent.y;
            x = _loc4_.x - parent.x;
            if(character.isMe && scene.existsComponent(ISceneCameraComponent))
            {
               _loc2_ = scene.getComponent(ISceneCameraComponent) as ISceneCameraComponent;
               _loc2_.screenShiftTo(x + pool.x,y + pool.y);
            }
            _loc1_ = getChildByName("body") as MovieClip;
            _loc5_ = -1;
            _loc7_ = _status + _direction.toString();
            if(_loc1_ != null)
            {
               if(hasLabel(_loc1_,_loc7_))
               {
                  _loc1_.gotoAndStop(_loc7_);
               }
               _loc5_ = getChildIndex(_loc1_);
            }
            _loc8_ = 0;
            while(_loc8_ < numChildren)
            {
               if(_loc8_ != _loc5_)
               {
                  _loc3_ = "i" + _direction.toString();
                  _loc6_ = getChildAt(_loc8_) as MovieClip;
                  if(hasLabel(_loc6_,_loc3_))
                  {
                     _loc6_.gotoAndStop(_loc3_);
                     _loc6_.y = 1;
                  }
               }
               _loc8_++;
            }
            if(numChildren < 2)
            {
               updateBody();
            }
         }
         catch(error:Error)
         {
            trace("ice skate catch:",error.message);
         }
         super.updateItem();
      }
      
      protected function setAction() : void
      {
         var _loc3_:ISceneCameraComponent = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc2_:MovieClip = null;
         Sanalika.instance.stage.removeEventListener("enterFrame",enterFrameHandler);
         isAction = true;
         var _loc4_:Point = scene.getPosFromGrid(pool.location.x + _nonIsoX,pool.location.y + _nonIsoY);
         y = _loc4_.y - parent.y;
         x = _loc4_.x - parent.x;
         if(character.isMe && scene.existsComponent(ISceneCameraComponent))
         {
            _loc3_ = scene.getComponent(ISceneCameraComponent) as ISceneCameraComponent;
            _loc3_.screenShiftTo(x + pool.x,y + pool.y);
         }
         var _loc1_:MovieClip = getChildByName("body") as MovieClip;
         PoolItemDirection.setActionDirection(this);
         _direction == 3 ? (actionDirections = PoolItemDirection.action3Directions) : (actionDirections = PoolItemDirection.action5Directions);
         if(_loc1_ != null)
         {
            _loc6_ = _status + _direction.toString();
            _loc5_ = -1;
            _loc5_ = getChildIndex(_loc1_);
            if(hasLabel(_loc1_,_loc6_))
            {
               _loc1_.gotoAndStop(_loc6_);
               _loc2_ = _loc1_.getChildByName("action") as MovieClip;
               TweenMax.to(_loc2_,1,{
                  "frame":26,
                  "ease":Linear.easeNone,
                  "onUpdate":updateAction,
                  "onUpdateParams":[_loc2_,_loc5_],
                  "onComplete":completeAction
               });
            }
         }
      }
      
      protected function updateAction(param1:MovieClip, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:String = null;
         var _loc5_:MovieClip = null;
         var _loc3_:int = 37;
         _loc6_ = 0;
         while(_loc6_ < numChildren)
         {
            if(_loc6_ != param2)
            {
               _loc4_ = "i" + actionDirections[param1.currentFrame - 1];
               _loc5_ = getChildAt(_loc6_) as MovieClip;
               if(hasLabel(_loc5_,_loc4_))
               {
                  _loc5_.gotoAndStop(_loc4_);
                  _loc5_.y = _loc3_ - param1.height;
               }
            }
            _loc6_++;
         }
      }
      
      protected function completeAction() : void
      {
         isAction = false;
         _status = "gi";
         updateItem();
         Sanalika.instance.stage.addEventListener("enterFrame",enterFrameHandler);
      }
      
      protected function keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         if(param1.keyCode == 32)
         {
            if(_status != "ga")
            {
               _status = "ga";
               setAction();
               _loc2_ = pool.name + "," + param1.keyCode + ",space," + coordinates;
            }
         }
      }
      
      protected function hasLabel(param1:MovieClip, param2:String) : Boolean
      {
         var _loc4_:* = 0;
         var _loc3_:int = int(param1.currentLabels.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.currentLabels[_loc4_].name == param2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
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
               Sanalika.instance.layerModel.stage.addEventListener("keyDown",keyDown);
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
      
      public function get isAction() : Boolean
      {
         return _isAction;
      }
      
      public function set isAction(param1:Boolean) : void
      {
         this._isAction = param1;
      }
      
      override public function kill() : void
      {
         Sanalika.instance.layerModel.stage.removeEventListener("keyDown",keyDown);
         Sanalika.instance.layerModel.stage.removeEventListener("enterFrame",enterFrameHandler);
         control.destroy();
         isActive = false;
         super.kill();
      }
   }
}

