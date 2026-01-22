package com.greensock.plugins
{
   import com.greensock.*;
   
   public class EndVectorPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected var _v:Vector.<Number>;
      
      protected var _info:Vector.<VectorInfo> = new Vector.<VectorInfo>();
      
      public function EndVectorPlugin()
      {
         super();
         this.propName = "endVector";
         this.overwriteProps = ["endVector"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is Vector.<Number>) || !(param2 is Vector.<Number>))
         {
            return false;
         }
         this.init(param1 as Vector.<Number>,param2 as Vector.<Number>);
         return true;
      }
      
      public function init(param1:Vector.<Number>, param2:Vector.<Number>) : void
      {
         this._v = param1;
         var _loc3_:int = int(param2.length);
         var _loc4_:uint = 0;
         while(_loc3_--)
         {
            if(this._v[_loc3_] != param2[_loc3_])
            {
               var _loc5_:*;
               this._info[_loc5_ = _loc4_++] = new VectorInfo(_loc3_,this._v[_loc3_],param2[_loc3_] - this._v[_loc3_]);
            }
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc3_:VectorInfo = null;
         var _loc4_:Number = NaN;
         var _loc2_:int = int(this._info.length);
         if(this.round)
         {
            while(_loc2_--)
            {
               _loc3_ = this._info[_loc2_];
               _loc4_ = _loc3_.start + _loc3_.change * param1;
               if(_loc4_ > 0)
               {
                  this._v[_loc3_.index] = _loc4_ + 0.5 >> 0;
               }
               else
               {
                  this._v[_loc3_.index] = _loc4_ - 0.5 >> 0;
               }
            }
         }
         else
         {
            while(_loc2_--)
            {
               _loc3_ = this._info[_loc2_];
               this._v[_loc3_.index] = _loc3_.start + _loc3_.change * param1;
            }
         }
      }
   }
}

class VectorInfo
{
   
   public var index:uint;
   
   public var start:Number;
   
   public var change:Number;
   
   public function VectorInfo(param1:uint, param2:Number, param3:Number)
   {
      super();
      this.index = param1;
      this.start = param2;
      this.change = param3;
   }
}
