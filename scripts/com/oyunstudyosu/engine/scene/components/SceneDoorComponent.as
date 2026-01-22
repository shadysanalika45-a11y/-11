package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.door.IDoorVO;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.events.BotEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.property.FlatEnterProperty;
   import com.oyunstudyosu.property.FlatExitProperty;
   import com.oyunstudyosu.property.PassageProperty;
   import com.oyunstudyosu.utils.Logger;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class SceneDoorComponent extends BaseSceneComponent
   {
      
      private var _doorList:Array;
      
      private var _isOnDoor:Boolean;
      
      public function SceneDoorComponent(param1:IScene)
      {
         super(param1);
         doorList = [];
      }
      
      public function get doorList() : Array
      {
         return _doorList;
      }
      
      public function set doorList(param1:Array) : void
      {
         _doorList = param1;
      }
      
      public function get isOnDoor() : Boolean
      {
         return _isOnDoor;
      }
      
      public function set isOnDoor(param1:Boolean) : void
      {
         _isOnDoor = param1;
      }
      
      override public function enable() : void
      {
         for each(var _loc1_ in doorList)
         {
            _loc1_.mouseEnabled = true;
            _loc1_.mouseChildren = true;
         }
      }
      
      override public function disable() : void
      {
         for each(var _loc1_ in doorList)
         {
            _loc1_.mouseEnabled = false;
            _loc1_.mouseChildren = false;
         }
      }
      
      public function processCeiling() : void
      {
         var _loc1_:MovieClip = scene.getMovieClip("ceiling");
         _loc1_.init();
         _loc1_.name = "ceiling";
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.alpha = 1;
         _loc1_.visible = true;
         scene.ceilingContainer.addChild(_loc1_);
      }
      
      public function processDoors() : void
      {
         var _loc1_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc4_:int = Sanalika.instance.roomModel.doorModel.count;
         var _loc3_:Array = Sanalika.instance.roomModel.doorModel.keyList;
         var _loc2_:MovieClip = scene.ceilingContainer.getChildByName("ceiling") as MovieClip;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = MovieClip(_loc2_.getChildByName(_loc3_[_loc5_]));
            if(_loc1_)
            {
               _loc1_.addEventListener("mouseOver",mouseOverDoor);
               _loc1_.addEventListener("mouseOut",mouseOutDoor);
               _loc1_.addEventListener("click",doorClicked);
               doorList.push(_loc1_);
            }
            else
            {
               Logger.log("Door clip with id " + _loc3_[_loc5_] + " not found on street named " + Sanalika.instance.roomModel.key,true);
            }
            _loc5_++;
         }
      }
      
      private function mouseOverDoor(param1:MouseEvent) : void
      {
         if(isOnDoor || !scene.mouseEnabled)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(Sanalika.instance.engine.scene.existsComponent(SceneMouseInteractionComponent))
         {
         }
         var _loc3_:IDoorVO = Sanalika.instance.roomModel.doorModel.getDoorById(_loc2_.name);
         try
         {
            Mouse.cursor = "doorarrow" + _loc3_.direction;
         }
         catch(e:Error)
         {
            trace("e.message",e.message);
         }
         isOnDoor = true;
      }
      
      private function mouseOutDoor(param1:MouseEvent) : void
      {
         if(!scene.mouseEnabled)
         {
            return;
         }
         Mouse.cursor = "auto";
         isOnDoor = false;
      }
      
      private function doorClicked(param1:MouseEvent) : void
      {
         if(!scene.mouseEnabled)
         {
            return;
         }
         param1.stopPropagation();
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(param1.ctrlKey)
         {
            trace("[doorClip.name: ",_loc2_.name + "]");
            Sanalika.instance.localConnectionModel.send("door",{"id":_loc2_.name});
         }
         else
         {
            runDoorById(_loc2_.name,_loc2_);
            Dispatcher.dispatchEvent(new BotEvent("speech","goodbye"));
         }
         _loc2_ = null;
      }
      
      public function clearDoors() : void
      {
         var _loc1_:MovieClip = null;
         var _loc5_:int = 0;
         doorList = [];
         var _loc4_:int = Sanalika.instance.roomModel.doorModel.count;
         var _loc3_:Array = Sanalika.instance.roomModel.doorModel.keyList;
         var _loc2_:MovieClip = scene.ceilingContainer.getChildByName("ceiling") as MovieClip;
         if(_loc2_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc1_ = _loc2_.getChildByName(_loc3_[_loc5_]) as MovieClip;
               if(_loc1_)
               {
                  _loc1_.removeEventListener("mouseOver",mouseOverDoor);
                  _loc1_.removeEventListener("mouseOut",mouseOutDoor);
                  _loc1_.removeEventListener("click",doorClicked);
               }
               _loc5_++;
            }
         }
      }
      
      public function runDoorById(param1:String, param2:MovieClip) : void
      {
         var _loc4_:IDoorVO = Sanalika.instance.roomModel.doorModel.getDoorById(param1);
         var _loc3_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(_loc4_ != null && _loc3_ != null && _loc3_.myChar != null)
         {
            if(_loc3_.myChar.currentTile != null)
            {
               if(_loc3_.myChar.currentTile.x == _loc4_.x && _loc3_.myChar.currentTile.y == _loc4_.y)
               {
                  if(_loc4_.property is PassageProperty || _loc4_.property is FlatExitProperty || _loc4_.property is FlatEnterProperty)
                  {
                     _loc3_.myChar.walkRequest(_loc4_.x,_loc4_.y,param2);
                  }
                  else
                  {
                     Sanalika.instance.roomModel.doorModel.useDoorByKey(param2.name);
                  }
               }
               else
               {
                  _loc3_.myChar.walkRequest(_loc4_.x,_loc4_.y,param2);
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         isDisposed = true;
         clearDoors();
      }
   }
}

