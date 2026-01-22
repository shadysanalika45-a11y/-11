package com.oyunstudyosu.cloth
{
   public class CharPreviewManager
   {
      
      public static var list:Vector.<CharPreview> = new Vector.<CharPreview>();
      
      public function CharPreviewManager()
      {
         super();
      }
      
      public static function register(param1:CharPreview) : void
      {
         list.push(param1);
      }
      
      public static function remove(param1:CharPreview) : void
      {
         var _loc2_:CharPreview = null;
         for(var _loc3_ in list)
         {
            _loc2_ = list[_loc3_];
            if(param1 == _loc2_)
            {
               trace("Remove Char Preview!");
               list.removeAt(_loc3_);
               _loc2_ = null;
               param1 = null;
            }
         }
      }
      
      public static function getUsingItems() : Vector.<String>
      {
         var _loc4_:String = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each(var _loc1_ in list)
         {
            for each(var _loc3_ in _loc1_.getClothes())
            {
               _loc4_ = _loc3_.getKey();
               if(_loc2_.indexOf(_loc4_) == -1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         return _loc2_;
      }
      
      public static function clear() : void
      {
         var _loc1_:CharPreview = null;
         for(var _loc2_ in list)
         {
            _loc1_ = list[_loc2_];
            if(_loc1_.isTerminated)
            {
               list.removeAt(_loc2_);
            }
         }
      }
   }
}

