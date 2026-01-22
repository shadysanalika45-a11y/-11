package com.oyunstudyosu.door
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.scene.components.SceneDoorComponent;
   import com.oyunstudyosu.pooling.OPM;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.DoorIcon;
   
   public class DoorIconModel
   {
      
      private var scene:IScene;
      
      private var icons:Array;
      
      private var clipMap:Dictionary;
      
      private var inited:Boolean;
      
      public function DoorIconModel(param1:IScene)
      {
         super();
         this.scene = param1;
         Sanalika.instance.layerModel.stage.addEventListener("keyDown",onTabKeyDown);
         Sanalika.instance.layerModel.stage.addEventListener("keyUp",onTabKeyUp);
      }
      
      protected function onTabKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.keyCode == 118)
         {
            _loc2_ = 0;
            while(_loc2_ < icons.length)
            {
               icons[_loc2_].visible = false;
               _loc2_++;
            }
         }
      }
      
      protected function onTabKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.keyCode == 118)
         {
            _loc2_ = 0;
            while(_loc2_ < icons.length)
            {
               icons[_loc2_].visible = true;
               _loc2_++;
            }
         }
      }
      
      public function init() : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:DoorIcon = null;
         var _loc5_:int = 0;
         icons = [];
         clipMap = new Dictionary();
         var _loc4_:SceneDoorComponent = scene.getComponent(SceneDoorComponent) as SceneDoorComponent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc1_:Array = _loc4_.doorList;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = OPM.borrowObjectByType(DoorIcon);
            _loc3_ = _loc1_[_loc5_];
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
            _loc2_.useHandCursor = true;
            _loc2_.buttonMode = true;
            _loc2_.addEventListener("mouseOver",onDoorIconOver);
            _loc2_.addEventListener("mouseOut",onDoorIconOut);
            _loc2_.addEventListener("click",onDoorIconClick);
            _loc2_.visible = false;
            scene.ceilingContainer.addChild(_loc2_);
            clipMap[_loc2_] = _loc3_;
            icons.push(_loc2_);
            _loc5_++;
         }
         inited = true;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc1_:DoorIcon = null;
         var _loc3_:int = 0;
         if(!inited)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < icons.length)
         {
            _loc1_ = icons[_loc3_];
            _loc1_.removeEventListener("mouseOver",onDoorIconOver);
            _loc1_.removeEventListener("mouseOut",onDoorIconOut);
            _loc1_.removeEventListener("click",onDoorIconClick);
            scene.ceilingContainer.removeChild(_loc1_);
            delete clipMap[_loc1_];
            _loc3_++;
         }
         OPM.returnObjectByType(_loc1_,DoorIcon);
         icons = null;
         clipMap = null;
         inited = false;
      }
      
      protected function onDoorIconClick(param1:MouseEvent) : void
      {
         var _loc3_:SceneDoorComponent = scene.getComponent(SceneDoorComponent) as SceneDoorComponent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:MovieClip = clipMap[param1.target];
         if(_loc2_)
         {
            _loc3_.runDoorById(_loc2_.name,_loc2_);
         }
      }
      
      protected function onDoorIconOut(param1:MouseEvent) : void
      {
         var _loc2_:DoorIcon = param1.target as DoorIcon;
         if(_loc2_)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      protected function onDoorIconOver(param1:MouseEvent) : void
      {
         var _loc2_:DoorIcon = param1.target as DoorIcon;
         if(_loc2_)
         {
            _loc2_.gotoAndPlay(1);
         }
      }
   }
}

