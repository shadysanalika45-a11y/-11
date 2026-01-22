package com.oyunstudyosu.inventory
{
   import com.oyunstudyosu.enums.ProductSubType;
   import com.oyunstudyosu.enums.UpdateGroups;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.StringUtil;
   import com.printfas3.printf;
   
   public class Item
   {
      
      public const EXPIRATIONTYPE_NONE:uint = 0;
      
      public const EXPIRATIONTYPE_EXPIRE:uint = 1;
      
      private var _subType:String;
      
      private var _productID:String;
      
      private var _id:int;
      
      private var _quantity:int;
      
      public var roles:Array;
      
      private var _clip:String;
      
      private var _createdAt:String;
      
      private var _lifeTime:Number;
      
      private var _timeLeft:int;
      
      private var _isTransferable:Boolean;
      
      public function Item(param1:Boolean, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:int, param9:int, param10:Array)
      {
         super();
         this.createdAt = param7;
         this.productID = param2;
         this.subType = param6;
         this.clip = param3;
         this.isTransferable = param1;
         this.id = param8;
         this.quantity = param9;
         this.roles = param10;
         this.lifeTime = param4 == null || int(param4) <= 0 ? 0 : uint(param4);
         if(param5 == null || param5 == "")
         {
            this.timeLeft = 0;
         }
         else
         {
            this.timeLeft = uint(param5);
            if(param5 != param4)
            {
               Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_1S).addFunction(this.updateTime);
            }
         }
      }
      
      private function updateTime(param1:uint, param2:uint) : void
      {
         if(this.timeLeft > 0)
         {
            --this.timeLeft;
         }
         else
         {
            Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_1S).removeFunction(this.updateTime);
         }
      }
      
      public function get subType() : String
      {
         return this._subType;
      }
      
      public function set subType(param1:String) : void
      {
         if(this._subType == param1)
         {
            return;
         }
         this._subType = param1;
      }
      
      public function get productID() : String
      {
         return this._productID;
      }
      
      public function set productID(param1:String) : void
      {
         if(this._productID == param1)
         {
            return;
         }
         this._productID = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         if(this._id == param1)
         {
            return;
         }
         this._id = param1;
      }
      
      public function get quantity() : int
      {
         return this._quantity;
      }
      
      public function set quantity(param1:int) : void
      {
         if(this._quantity == param1)
         {
            return;
         }
         this._quantity = param1;
      }
      
      public function get clip() : String
      {
         return this._clip;
      }
      
      public function set clip(param1:String) : void
      {
         if(this._clip == param1)
         {
            return;
         }
         this._clip = param1;
      }
      
      public function get createdAt() : String
      {
         return this._createdAt;
      }
      
      public function set createdAt(param1:String) : void
      {
         this._createdAt = param1;
      }
      
      public function get lifeTime() : Number
      {
         return this._lifeTime;
      }
      
      public function set lifeTime(param1:Number) : void
      {
         this._lifeTime = param1;
      }
      
      public function get timeLeft() : int
      {
         return this._timeLeft;
      }
      
      public function get isTransferable() : Boolean
      {
         return this._isTransferable;
      }
      
      public function set isTransferable(param1:Boolean) : void
      {
         if(this._isTransferable == param1)
         {
            return;
         }
         this._isTransferable = param1;
      }
      
      public function set timeLeft(param1:int) : void
      {
         this._timeLeft = param1;
      }
      
      public function getType(param1:String = null) : uint
      {
         if(!Connectr.instance.itemModel.isInfoFileDownloaded())
         {
            return 0;
         }
         if(param1 == null)
         {
            param1 = Connectr.instance.avatarModel.gender;
            return Connectr.instance.itemModel.getItemType(param1 + "_" + this.clip);
         }
         return 0;
      }
      
      public function checkPermission() : Boolean
      {
         return Connectr.instance.avatarModel.permission.checkAny(this.roles);
      }
      
      public function getInfo() : String
      {
         var _loc1_:String = "" + this.quantity.toString() + " " + $("pro_" + this.clip);
         if(this.lifeTime == 0 && this.timeLeft == 0)
         {
            _loc1_ = _loc1_ + " | " + $("unlimitedItem");
         }
         else if(this.timeLeft == 0)
         {
            _loc1_ += " | " + $("limitedItem") + " | " + printf($("leftTime"),StringUtil.secondToString(this.lifeTime));
         }
         else
         {
            _loc1_ += " | " + printf($("leftTime"),StringUtil.secondToString(this.timeLeft));
         }
         _loc1_ += " | " + $("createdAt") + ": " + this.createdAt;
         if(this.subType == ProductSubType.PACKAGE)
         {
            _loc1_ += " | " + $("dragToOpen");
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         Connectr.instance.updateModel.getGroup(UpdateGroups.TIMER_1S).removeFunction(this.updateTime);
      }
   }
}

