package com.oyunstudyosu.engine.pool.controls
{
   import com.oyunstudyosu.controls.Gamepad;
   import com.oyunstudyosu.controls.GamepadInput;
   import com.oyunstudyosu.engine.pool.chars.PoolItem;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   
   public class ItemControl extends Gamepad
   {
      
      protected var item:PoolItem;
      
      public function ItemControl(param1:Stage, param2:PoolItem, param3:Boolean, param4:Number = 0.2, param5:Boolean = true)
      {
         var _loc7_:Object = null;
         super(param1,param3,param4,param5);
         this.item = param2;
         for(var _loc6_ in param2)
         {
            _loc7_ = param2[_loc6_];
         }
         param1.removeEventListener("keyDown",onKeyDown);
         param1.removeEventListener("keyUp",onKeyUp);
      }
      
      public function enableKeys() : void
      {
         stage.addEventListener("keyDown",onKeyDown);
         stage.addEventListener("keyUp",onKeyUp);
      }
      
      public function setKeyDown(param1:uint) : void
      {
         for each(var _loc2_ in _inputs)
         {
            trace("keyCode" + param1);
            _loc2_.keyDown(param1);
         }
         updateState();
      }
      
      public function setKeyUp(param1:uint) : void
      {
         for each(var _loc2_ in _inputs)
         {
            trace("setKeyUp");
            _loc2_.keyUp(param1);
         }
         updateState();
      }
      
      override protected function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(var _loc5_ in _inputs)
         {
            if(_loc5_.containsKey(param1.keyCode))
            {
               _loc4_ = true;
               if(_loc5_.isDown)
               {
                  _loc3_ = true;
               }
            }
            _loc5_.keyDown(param1.keyCode);
         }
         if(_loc4_ && !_loc3_)
         {
            _loc2_ = item.pool.name + "," + param1.keyCode + ",down," + item.coordinates + "," + item.bodyclip;
            Sanalika.instance.serviceModel.setUserVariable(["poolVars"],[_loc2_]);
         }
         updateState();
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(var _loc5_ in _inputs)
         {
            if(_loc5_.containsKey(param1.keyCode))
            {
               _loc4_ = true;
               if(!_loc5_.isDown)
               {
                  _loc3_ = true;
               }
            }
            _loc5_.keyUp(param1.keyCode);
         }
         if(_loc4_ && !_loc3_)
         {
            _loc2_ = item.pool.name + "," + param1.keyCode + ",up," + item.coordinates + "," + item.bodyclip;
            Sanalika.instance.serviceModel.setUserVariable(["poolVars"],[_loc2_]);
         }
         updateState();
      }
      
      protected function processKeyEvent(param1:KeyboardEvent, param2:String) : void
      {
      }
      
      public function set initX(param1:Number) : void
      {
         _x = param1;
      }
      
      public function set initY(param1:Number) : void
      {
         _y = param1;
      }
      
      public function set initRotation(param1:Number) : void
      {
         _rotation = param1;
      }
      
      public function set initAngle(param1:Number) : void
      {
         _angle = param1;
      }
   }
}

