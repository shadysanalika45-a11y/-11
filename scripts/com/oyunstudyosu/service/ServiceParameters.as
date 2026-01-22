package com.oyunstudyosu.service
{
   import com.oyunstudyosu.timer.SyncTimer;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.data.SFSObject;
   
   internal class ServiceParameters
   {
      
      private static var rid:int = 0;
      
      private static var date:Date = new Date();
      
      private var _sn:String;
      
      private var _data:Object;
      
      public function ServiceParameters()
      {
         super();
      }
      
      public function get sn() : String
      {
         return _sn;
      }
      
      public function set sn(param1:String) : void
      {
         if(_sn == param1)
         {
            return;
         }
         _sn = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
      }
      
      public function getSFSObject() : ISFSObject
      {
         var _loc1_:ISFSObject = new SFSObject();
         _loc1_.putUtfString("sn",_sn);
         _loc1_.putSFSObject("data",SFSObject.newFromObject(_data));
         _loc1_.putLong("ts",SyncTimer.timestamp);
         _loc1_.putLong("rid",rid);
         rid = rid + 1;
         return _loc1_;
      }
   }
}

