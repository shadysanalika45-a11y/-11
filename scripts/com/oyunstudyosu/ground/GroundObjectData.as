package com.oyunstudyosu.ground
{
   public class GroundObjectData
   {
      
      private var _requiredItemClip:String;
      
      private var _questID:String;
      
      private var _clip:String;
      
      private var _posX:int;
      
      private var _posY:int;
      
      public function GroundObjectData()
      {
         super();
      }
      
      public function get requiredItemClip() : String
      {
         return _requiredItemClip;
      }
      
      public function set requiredItemClip(param1:String) : void
      {
         if(_requiredItemClip == param1)
         {
            return;
         }
         _requiredItemClip = param1;
      }
      
      public function get questID() : String
      {
         return _questID;
      }
      
      public function set questID(param1:String) : void
      {
         if(_questID == param1)
         {
            return;
         }
         _questID = param1;
      }
      
      public function get clip() : String
      {
         return _clip;
      }
      
      public function set clip(param1:String) : void
      {
         if(_clip == param1)
         {
            return;
         }
         _clip = param1;
      }
      
      public function get posX() : int
      {
         return _posX;
      }
      
      public function set posX(param1:int) : void
      {
         if(_posX == param1)
         {
            return;
         }
         _posX = param1;
      }
      
      public function get posY() : int
      {
         return _posY;
      }
      
      public function set posY(param1:int) : void
      {
         if(_posY == param1)
         {
            return;
         }
         _posY = param1;
      }
   }
}

