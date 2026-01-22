package com.smartfoxserver.v2.entities.managers
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.User;
   
   public class SFSGlobalUserManager extends SFSUserManager
   {
      
      private var _roomRefCount:Array;
      
      public function SFSGlobalUserManager(param1:SmartFox)
      {
         super(param1);
         this._roomRefCount = [];
      }
      
      override public function addUser(param1:User) : void
      {
         if(this._roomRefCount[param1] == null)
         {
            super._addUser(param1);
            this._roomRefCount[param1] = 1;
         }
         else
         {
            super._addUser(param1);
            ++this._roomRefCount[param1];
         }
      }
      
      override public function removeUser(param1:User) : void
      {
         this.removeUserReference(param1,false);
      }
      
      public function removeUserReference(param1:User, param2:Boolean = false) : void
      {
         if(this._roomRefCount != null)
         {
            if(this._roomRefCount[param1] < 1)
            {
               _smartFox.logger.warn("GlobalUserManager RefCount is already at zero. User: " + param1);
               return;
            }
            --this._roomRefCount[param1];
            if(this._roomRefCount[param1] == 0 || param2)
            {
               super.removeUser(param1);
               delete this._roomRefCount[param1];
            }
         }
         else
         {
            _smartFox.logger.warn("Can\'t remove User from GlobalUserManager. RefCount missing. User: " + param1);
         }
      }
      
      private function dumpRefCount() : void
      {
      }
   }
}

