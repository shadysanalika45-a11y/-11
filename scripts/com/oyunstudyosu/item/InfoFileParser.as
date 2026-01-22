package com.oyunstudyosu.item
{
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.cloth.ClothData;
   import com.oyunstudyosu.cloth.InventoryItemData;
   import com.oyunstudyosu.cloth.SmileyData;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class InfoFileParser
   {
      
      private var pack:ItemModel;
      
      private var filePath:String;
      
      private var firstLoad:Boolean;
      
      private var infoFileLoader:URLLoader;
      
      private var dataArray:Array;
      
      private var itemAccepted:int = 0;
      
      private var itemInserted:int = 0;
      
      private var itemUpdated:int = 0;
      
      private var clothAccepted:int = 0;
      
      private var clothInserted:int = 0;
      
      private var clothUpdated:int = 0;
      
      private var smileyUpdated:int = 0;
      
      private var smileyInserted:int = 0;
      
      private var rejectedCount:int = 0;
      
      public function InfoFileParser(param1:ItemModel, param2:String, param3:Boolean, param4:Boolean = true)
      {
         super();
         this.pack = param1;
         this.filePath = param2;
         this.firstLoad = param3;
         if(param4)
         {
            getInfoFile();
         }
      }
      
      private function getInfoFile() : void
      {
         var _loc1_:String = null;
         _loc1_ = Sanalika.instance.gameModel.fileServer + filePath;
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         _loc2_.method = "GET";
         infoFileLoader = new URLLoader();
         infoFileLoader.addEventListener("complete",infoCompleteEvent);
         infoFileLoader.addEventListener("ioError",infoIoError);
         infoFileLoader.addEventListener("securityError",infoSecurityError);
         infoFileLoader.load(_loc2_);
      }
      
      private function infoCompleteEvent(param1:Event) : void
      {
         if(param1.target.data == null)
         {
            infoFileError(107);
            return;
         }
         var _loc2_:String = param1.target.data;
         if(_loc2_.length == 0)
         {
            infoFileError(108);
            return;
         }
         terminate();
         var _loc3_:String = Base64.decode(_loc2_);
         if(_loc3_ == null)
         {
            infoFileError(109);
            return;
         }
         if(_loc3_.length == 0)
         {
            infoFileError(110);
            return;
         }
         dataArray = _loc3_.split("\n");
         _loc3_ = null;
         _loc2_ = null;
         process();
      }
      
      private function infoIoError(param1:Event) : void
      {
         infoFileError(105);
      }
      
      private function infoSecurityError(param1:Event) : void
      {
         infoFileError(106);
      }
      
      private function terminate() : void
      {
         if(infoFileLoader == null)
         {
            return;
         }
         infoFileLoader.removeEventListener("complete",infoCompleteEvent);
         infoFileLoader.removeEventListener("ioError",infoIoError);
         infoFileLoader.removeEventListener("securityError",infoSecurityError);
         infoFileLoader.close();
         infoFileLoader = null;
      }
      
      private function infoFileError(param1:int) : void
      {
         terminate();
         if(firstLoad)
         {
            trace("info file yüklenemedi");
         }
         else
         {
            pack.getInfoFile_FAILED();
         }
      }
      
      private function process() : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc1_:int = int(dataArray.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = dataArray[_loc3_];
            if(_loc2_.length != 0)
            {
               processLine(_loc2_);
            }
            _loc3_++;
         }
         dataArray = [];
         pack.getInfoFile_SUCCESS(firstLoad);
      }
      
      public function processLine(param1:String) : void
      {
         var _loc17_:String = null;
         var _loc10_:int = 0;
         var _loc16_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:String = null;
         var _loc12_:InventoryItemData = null;
         var _loc15_:Array = null;
         var _loc6_:int = 0;
         var _loc18_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:String = null;
         var _loc2_:ClothData = null;
         var _loc13_:SmileyData = null;
         var _loc5_:Array = ["m","f"];
         var _loc19_:Array = param1.split("|");
         if(_loc19_.length == 4)
         {
            _loc17_ = _loc19_[0];
            _loc3_ = parseInt(_loc19_[1]);
            _loc16_ = parseInt(_loc19_[2]);
            _loc10_ = parseInt(_loc19_[3]);
            for each(var _loc14_ in _loc5_)
            {
               itemAccepted = itemAccepted + 1;
               _loc11_ = _loc14_ + "_" + _loc17_;
               _loc12_ = pack.getItem(_loc11_);
               if(_loc12_ == null)
               {
                  itemInserted = itemInserted + 1;
                  pack.setItemFileData(_loc11_,new InventoryItemData(_loc11_,_loc3_,_loc16_,_loc10_));
               }
               else
               {
                  itemUpdated = itemUpdated + 1;
                  _loc12_.forceUpdate(_loc3_,_loc16_,_loc10_);
               }
            }
         }
         else if(_loc19_.length == 7)
         {
            clothAccepted = clothAccepted + 1;
            _loc17_ = _loc19_[0];
            _loc15_ = _loc19_[1].split(",");
            _loc6_ = parseInt(_loc19_[2]);
            _loc18_ = parseInt(_loc19_[3]);
            _loc9_ = parseInt(_loc19_[4]);
            _loc8_ = parseInt(_loc19_[5]);
            _loc10_ = parseInt(_loc19_[6]);
            for each(_loc14_ in _loc5_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc15_.length)
               {
                  _loc4_ = _loc14_ + "_" + _loc17_ + "_" + _loc15_[_loc7_];
                  _loc2_ = pack.getCloth(_loc4_);
                  if(_loc2_ == null)
                  {
                     clothInserted = clothInserted + 1;
                     pack.setItemFileData(_loc4_,new ClothData(_loc4_,_loc6_,_loc18_,_loc9_,_loc8_,_loc10_));
                  }
                  else
                  {
                     clothUpdated = clothUpdated + 1;
                     _loc2_.forceUpdate(_loc6_,_loc18_,_loc9_,_loc8_,_loc10_);
                  }
                  _loc7_++;
               }
            }
         }
         else if(_loc19_.length == 2)
         {
            _loc17_ = _loc19_[0];
            _loc10_ = parseInt(_loc19_[1]);
            _loc13_ = pack.getSmiley(_loc17_);
            if(_loc13_ == null)
            {
               smileyInserted = smileyInserted + 1;
               pack.setItemFileData(_loc17_,new SmileyData(_loc17_,_loc10_));
            }
            else
            {
               smileyUpdated = smileyUpdated + 1;
               _loc13_.forceUpdate(_loc10_);
            }
         }
         else
         {
            trace("parseInfoFile() : UNKNOWN DATA[" + param1 + "]");
            rejectedCount = rejectedCount + 1;
         }
      }
   }
}

