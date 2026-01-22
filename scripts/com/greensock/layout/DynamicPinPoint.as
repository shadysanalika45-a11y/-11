package com.greensock.layout
{
   import com.greensock.layout.core.LiquidData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class DynamicPinPoint extends PinPoint
   {
      
      public static const version:Number = 2.2;
      
      private var _getter:Function;
      
      public function DynamicPinPoint(param1:DisplayObject, param2:Function, param3:LiquidStage = null)
      {
         super(param2().x,param2().y,param1,param3);
         this._getter = _data.getter = param2;
         if(!(this._getter() is Point))
         {
            throw new Error("The getter function passed to the DynamicPinPoint constructor did not return a Point instance.");
         }
      }
      
      override protected function init(param1:DisplayObject, param2:LiquidStage) : void
      {
         _data = new LiquidData(this,param1,1,param2 || LiquidStage.getByStage(param1.stage),false,0,null,false);
         LiquidData.addCacheData(_data.liquidStage,_data);
      }
      
      override public function clone() : Point
      {
         var _loc1_:DynamicPinPoint = new DynamicPinPoint(_data.target,this._getter,_data.liquidStage);
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         return _loc1_;
      }
      
      public function get getter() : Function
      {
         return this._getter;
      }
      
      public function set getter(param1:Function) : void
      {
         this._getter = _data.getter = param1;
         var _loc2_:Point = this._getter();
         this.x = _loc2_.x;
         this.y = _loc2_.y;
      }
   }
}

