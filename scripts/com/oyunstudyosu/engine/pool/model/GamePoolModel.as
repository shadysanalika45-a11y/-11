package com.oyunstudyosu.engine.pool.model
{
   import com.oyunstudyosu.cloth.Cloth;
   
   public class GamePoolModel
   {
      
      public static var gamesuits:Array;
      
      public static var suitID:uint;
      
      public static var cloths:Array;
      
      public static var iceClothColor:int;
      
      public static var swimsuits:Array = ["m_0374","f_0365","m_kpentewu","f_jcthay92"];
      
      public static var iceColors:Array = ["10","5","3","2","7","9"];
      
      public static var icesuits:Array = ["m_0804","f_0804"];
      
      public function GamePoolModel()
      {
         super();
      }
      
      public static function canskateByCloth() : Boolean
      {
         var _loc3_:* = 0;
         var _loc1_:Cloth = null;
         var _loc2_:* = 0;
         cloths = Sanalika.instance.clothModel.allClothes;
         _loc3_ = 0;
         while(_loc3_ < cloths.length)
         {
            _loc1_ = cloths[_loc3_];
            _loc2_ = 0;
            while(_loc2_ < GamePoolModel.icesuits.length)
            {
               if(_loc1_.key.indexOf(GamePoolModel.icesuits[_loc2_]) > -1)
               {
                  iceClothColor = _loc1_.color;
                  return true;
               }
               _loc2_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function canSwimByCloth() : Boolean
      {
         trace("permission",Sanalika.instance.avatarModel.permission.value);
         if(Sanalika.instance.avatarModel.permission.check(41))
         {
            trace("can swimmmm");
            return true;
         }
         return false;
      }
   }
}

