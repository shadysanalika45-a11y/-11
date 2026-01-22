package com.oyunstudyosu.engine.character
{
   import com.oyunstudyosu.cloth.ClothType;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class IdleCacher extends Sprite
   {
      
      private static var compatibleItemList:Dictionary = new Dictionary();
      
      public function IdleCacher()
      {
         super();
      }
      
      public static function check(param1:Character, param2:String) : Boolean
      {
         var _loc3_:Sprite = null;
         if(param1.isCachingCompatible(param2) == null)
         {
            _loc3_ = new Sprite();
            param1.drawCharWithoutDrawTest(_loc3_);
            gotoAndStopAll(_loc3_,param2);
            if(checkStaticAnimation(_loc3_))
            {
               param1.addCachingCompatibleItem(param2,true);
            }
            else
            {
               param1.addCachingCompatibleItem(param2,false);
            }
         }
         return param1.isCachingCompatible(param2);
      }
      
      public static function cache(param1:Character, param2:String, param3:Boolean) : SimpleCachedCharacterClip
      {
         var _loc10_:int = 0;
         var _loc12_:* = undefined;
         var _loc14_:int = 0;
         _loc12_ = undefined;
         var _loc8_:Rectangle = null;
         var _loc17_:Array = null;
         var _loc7_:int = -1;
         var _loc9_:int = -1;
         var _loc18_:int = -1;
         var _loc15_:Sprite = new Sprite();
         param1.drawCharWithoutDrawTest(_loc15_);
         try
         {
            gotoAndStopAll(_loc15_,param2);
         }
         catch(e:Error)
         {
            return null;
         }
         if(param3)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc15_.numChildren)
            {
               _loc12_ = _loc15_.getChildAt(_loc10_);
               if(!(_loc12_ is SimpleCachedCharacterClip || !_loc12_.hasOwnProperty("frameBit") || _loc12_.placeBit == ClothType.BIT22_HANDITEM))
               {
                  if(searchFrameLabel((_loc12_ as MovieClip).currentLabels,"k" + param2))
                  {
                     _loc12_.gotoAndStop("k" + param2);
                  }
               }
               _loc10_++;
            }
         }
         _loc17_ = getAllParentChilds(_loc15_);
         _loc14_ = 0;
         while(_loc14_ < _loc15_.numChildren)
         {
            _loc12_ = _loc15_.getChildAt(_loc14_);
            if(!(_loc12_ is SimpleCachedCharacterClip))
            {
               if(_loc12_.placeBit > _loc7_)
               {
                  _loc7_ = int(_loc12_.placeBit);
               }
               if(_loc12_.maxPlaceBit > _loc9_)
               {
                  _loc9_ = int(_loc12_.maxPlaceBit);
               }
               if(_loc12_.frameBit > _loc18_)
               {
                  _loc18_ = int(_loc12_.frameBit);
               }
            }
            _loc14_++;
         }
         var _loc16_:Array = [];
         try
         {
         }
         catch(e:Error)
         {
            return null;
         }
         var _loc6_:Sprite = new Sprite();
         for each(var _loc4_ in _loc17_)
         {
            _loc8_ = _loc4_.getRect(Sanalika.instance.stage);
            _loc6_.addChild(_loc4_);
         }
         if(_loc6_.numChildren == 0)
         {
            return null;
         }
         var _loc11_:Rectangle = _loc6_.getBounds(_loc6_);
         var _loc13_:BitmapData = new BitmapData(int(_loc11_.width + 0.5),int(_loc11_.height + 0.5),true,0);
         _loc13_.draw(_loc6_,new Matrix(1,0,0,1,-_loc11_.x,-_loc11_.y));
         var _loc5_:SimpleCachedCharacterClip = new SimpleCachedCharacterClip(_loc13_);
         _loc5_.x = _loc11_.x;
         _loc5_.y = _loc11_.y;
         return _loc5_;
      }
      
      private static function searchFrameLabel(param1:Array, param2:String) : Boolean
      {
         var _loc3_:* = undefined;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].name == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private static function checkStaticAnimation(param1:Sprite) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc4_);
            if(!(_loc2_ is SimpleCachedCharacterClip))
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_.numChildren)
               {
                  if(!(!_loc2_.hasOwnProperty("frameBit") || _loc2_.placeBit == ClothType.BIT22_HANDITEM))
                  {
                     _loc3_ = checkChildStaticAnimation(_loc2_);
                     if(_loc3_ == false)
                     {
                        return false;
                     }
                  }
                  _loc5_++;
               }
            }
            _loc4_++;
         }
         return true;
      }
      
      private static function checkChildStaticAnimation(param1:Sprite) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_);
            if(_loc2_ is MovieClip)
            {
               if((_loc2_ as MovieClip).totalFrames > 1)
               {
                  return false;
               }
               return checkChildStaticAnimation(_loc2_);
            }
            _loc3_++;
         }
         return true;
      }
      
      private static function getAllParentChilds(param1:Sprite) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_);
            if(!(_loc2_ is SimpleCachedCharacterClip || !_loc2_.hasOwnProperty("frameBit") || _loc2_.placeBit == ClothType.BIT22_HANDITEM))
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.numChildren)
               {
                  _loc5_.push(_loc2_.getChildAt(_loc4_));
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      private static function gotoAndStopAll(param1:Sprite, param2:Object, param3:String = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         _loc5_ = 0;
         while(_loc5_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc5_);
            if(!(_loc4_ is SimpleCachedCharacterClip || !_loc4_.hasOwnProperty("frameBit") || _loc4_.placeBit == ClothType.BIT22_HANDITEM))
            {
               _loc4_.gotoAndStop(param2,param3);
            }
            _loc5_++;
         }
      }
      
      private function dispose() : void
      {
      }
   }
}

