package com.oyunstudyosu.model
{
   import com.oyunstudyosu.sanalika.interfaces.IGiftModel;
   import flash.utils.Dictionary;
   
   public class GiftModel implements IGiftModel
   {
      
      private var gifts:Dictionary;
      
      public function GiftModel()
      {
         super();
         gifts = new Dictionary(true);
      }
      
      public function add(param1:String) : void
      {
         gifts[param1] = true;
      }
      
      public function contains(param1:String) : Boolean
      {
         if(gifts[param1])
         {
            return true;
         }
         return false;
      }
   }
}

