package com.oyunstudyosu.ban
{
   public class BanData
   {
      
      private var _banType:String;
      
      private var _banEndTime:int;
      
      private var _startDate:String;
      
      private var _endDate:String;
      
      private var _isLimited:Boolean = true;
      
      public function BanData()
      {
         super();
      }
      
      public function get banType() : String
      {
         return this._banType;
      }
      
      public function set banType(param1:String) : void
      {
         if(this._banType == param1)
         {
            return;
         }
         this._banType = param1;
      }
      
      public function get banEndTime() : int
      {
         return this._banEndTime;
      }
      
      public function set banEndTime(param1:int) : void
      {
         if(this._banEndTime == param1)
         {
            return;
         }
         this._banEndTime = param1;
      }
      
      public function get startDate() : String
      {
         return this._startDate;
      }
      
      public function set startDate(param1:String) : void
      {
         if(this._startDate == param1)
         {
            return;
         }
         this._startDate = param1;
      }
      
      public function get endDate() : String
      {
         return this._endDate;
      }
      
      public function set endDate(param1:String) : void
      {
         if(this._endDate == param1)
         {
            return;
         }
         this._endDate = param1;
      }
      
      public function get isLimited() : Boolean
      {
         return this._isLimited;
      }
      
      public function set isLimited(param1:Boolean) : void
      {
         if(this._isLimited == param1)
         {
            return;
         }
         this._isLimited = param1;
      }
   }
}

