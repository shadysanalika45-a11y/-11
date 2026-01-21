package com.oyunstudyosu.model
{
   import com.hurlant.util.Base64;
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.debug.ContractLogger;
   import flash.utils.ByteArray;
   
   public class GridModel implements IGridModel
   {
      
      private var directions:Array = ["1,0","1,-1","0,-1","-1,-1","-1,0","-1,1","0,1","1,1"];
      
      private var inited:Boolean;
      
      private var _data:Array;
      
      private var _width:int;
      
      private var _height:int;
      
      public function GridModel()
      {
         super();
      }
      
      public function create(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         this._data = [];
         this._width = param1;
         this._height = param2;
         var _loc4_:int = 0;
         while(_loc4_ < this._height)
         {
            _loc5_ = 0;
            while(_loc5_ < this._width)
            {
               this._data[_loc4_ * this._width + _loc5_] = param3;
               _loc5_++;
            }
            _loc4_++;
         }
         this.inited = true;
      }
      
      public function getCoordinatesByValue(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._height)
         {
            _loc4_ = 0;
            while(_loc4_ < this._width)
            {
               if(this._data[_loc3_ * this._width + _loc4_] == param1)
               {
                  _loc2_.push(_loc4_.toString() + "," + _loc3_.toString());
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getCellValue(param1:int, param2:int) : int
      {
         if(param1 < 0 || param2 < 0 || param1 >= this._width || param2 >= this._height || !this.inited)
         {
            trace("Model not initied or values are beyond borders! (GridModel.getCellValue(" + param1 + "," + param2 + "))");
            return -1;
         }
         return this._data[param2 * this._width + param1];
      }
      
      public function setCellValue(param1:int, param2:int, param3:int) : void
      {
         if(param1 < 0 || param2 < 0 || param1 >= this._width || param2 >= this._height || !this.inited)
         {
            trace("Model not initied or values are beyond borders! (GridModel.setCellValue(" + param1 + "," + param2 + "))");
            return;
         }
         this._data[param2 * this._width + param1] = param3;
      }
      
      public function get data() : String
      {
         var _loc3_:int = 0;
         if(!this.inited)
         {
            trace("Model not initied or values are beyond borders! (GridModel.data)");
            return null;
         }
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeInt(this._width);
         _loc1_.writeInt(this._height);
         var _loc2_:int = 0;
         while(_loc2_ < this._height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._width)
            {
               _loc1_.writeByte(this._data[_loc2_ * this._width + _loc3_]);
               _loc3_++;
            }
            _loc2_++;
         }
         return Base64.encodeByteArray(_loc1_);
      }
      
      public function load(param1:String) : void
      {
         var i:int = 0;
         var j:int = 0;
         var value:String = param1;
         var byteArray:ByteArray = Base64.decodeToByteArray(value);
         try
         {
            this._width = byteArray.readInt();
            this._height = byteArray.readInt();
            Cc.infoch("aa",this._width,this._height);
            this._data = [];
            i = 0;
            while(i < this._height)
            {
               j = 0;
               while(j < this._width)
               {
                  this._data[i * this._width + j] = byteArray.readByte();
                  j++;
               }
               i++;
            }
            this.inited = true;
            try
            {
               ContractLogger.log("grid_decoded",{
                  "width":this._width,
                  "height":this._height,
                  "sample":this._data.slice(0,Math.min(40,this._data.length))
               });
            }
            catch(e1:Error)
            {
            }
         }
         catch(error:Error)
         {
            trace("Parse error on load! (GridModel.load)");
            trace(error.getStackTrace());
         }
      }
      
      public function getCellsFromCellToDir(param1:int, param2:int, param3:int, param4:int = 0) : Array
      {
         if(param3 < 1 || param3 > 8)
         {
            return [];
         }
         var _loc5_:Array = this.directions[param3 - 1].split(",");
         var _loc6_:int = parseInt(_loc5_[0]);
         var _loc7_:int = parseInt(_loc5_[1]);
         var _loc8_:int = param1;
         var _loc9_:int = param2;
         var _loc10_:Array = [];
         while(this.getCellValue(_loc8_,_loc9_) == param4)
         {
            _loc10_.push(_loc8_ + "," + _loc9_);
            _loc8_ += _loc6_;
            _loc9_ += _loc7_;
         }
         return _loc10_;
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         while(_loc2_ < this._height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._width)
            {
               _loc1_ += this._data[_loc2_ * this._width + _loc3_] + ",";
               _loc3_++;
            }
            _loc1_ += "\n";
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get width() : int
      {
         if(!this.inited)
         {
            trace("Model not initied! (GridModel.data)");
            return 0;
         }
         return this._width;
      }
      
      public function get height() : int
      {
         if(!this.inited)
         {
            trace("Model not initied! (GridModel.data)");
            return 0;
         }
         return this._height;
      }
   }
}

