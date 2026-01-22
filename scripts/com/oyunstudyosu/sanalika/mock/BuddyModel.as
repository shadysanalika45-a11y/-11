package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.buddy.BuddyVo;
   import com.oyunstudyosu.buddy.RequestVo;
   import com.oyunstudyosu.events.BuddyEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.interfaces.IBuddyModel;
   
   public class BuddyModel implements IBuddyModel
   {
      
      private var _buddies:Vector.<BuddyVo> = new Vector.<BuddyVo>();
      
      private var _requests:Vector.<RequestVo> = new Vector.<RequestVo>();
      
      private var vo:BuddyVo;
      
      private var buddyEvent:BuddyEvent;
      
      private var _isActived:Boolean;
      
      private var _buddyLen:int;
      
      private var _reqLen:int;
      
      public function BuddyModel()
      {
         super();
      }
      
      public function buddyReqTipClicked() : void
      {
      }
      
      public function get reqLen() : int
      {
         return this._reqLen;
      }
      
      public function get buddyLen() : int
      {
         return this._buddyLen;
      }
      
      public function get isActived() : Boolean
      {
         return this._isActived;
      }
      
      public function set isActived(param1:Boolean) : void
      {
         this._isActived = param1;
      }
      
      public function get buddies() : Vector.<BuddyVo>
      {
         return this._buddies;
      }
      
      public function get requests() : Vector.<RequestVo>
      {
         return this._requests;
      }
      
      public function add(param1:Object) : void
      {
         this.vo = new BuddyVo();
         this.vo.avatarID = param1.avatarID;
         this.vo.nick = param1.nick;
         this.vo.status = param1.status;
         this.vo.isOnline = param1.isOnline;
         this.vo.mood = param1.mood;
         this.vo.buddyMood = param1.buddyMood;
         this.vo.myMood = param1.myMood;
         this.buddies.push(this.vo);
         this._buddyLen = this.buddies.length;
      }
      
      public function changeOnlineStatus(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.buddies) && this.buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.buddyLen)
            {
               if(param1.avatarID == this.buddies[_loc2_].avatarID)
               {
                  if(param1.isOnline)
                  {
                     this.buddies[_loc2_].isOnline = param1.isOnline;
                  }
                  this.buddyEvent = new BuddyEvent(BuddyEvent.BUDDY_LIST_UPDATED);
                  Dispatcher.dispatchEvent(this.buddyEvent);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function changeRelation(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.buddies) && this.buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.buddyLen)
            {
               if(param1.avatarID == this.buddies[_loc2_].avatarID)
               {
                  if(param1.relationId)
                  {
                     this.buddies[_loc2_].buddyMood = param1.buddyMood;
                  }
                  if(param1.myRelationToBuddy)
                  {
                     this.buddies[_loc2_].myMood = param1.myMood;
                  }
                  this.buddyEvent = new BuddyEvent(BuddyEvent.BUDDY_LIST_UPDATED);
                  Dispatcher.dispatchEvent(this.buddyEvent);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function changeMood(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.buddies) && this.buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.buddyLen)
            {
               if(param1.avatarID == this.buddies[_loc2_].avatarID)
               {
                  this.buddies[_loc2_].mood = param1.mood;
                  this.buddyEvent = new BuddyEvent(BuddyEvent.BUDDY_LIST_UPDATED);
                  Dispatcher.dispatchEvent(this.buddyEvent);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function changeStatusMessage(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.buddies) && this.buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.buddyLen)
            {
               if(param1.avatarID == this.buddies[_loc2_].avatarID)
               {
                  this.buddies[_loc2_].status = param1.status;
                  this.buddyEvent = new BuddyEvent(BuddyEvent.BUDDY_LIST_UPDATED);
                  Dispatcher.dispatchEvent(this.buddyEvent);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function addNewBuddy(param1:Object) : void
      {
         if(this.getBuddyVoById(param1.avatarID) == null)
         {
            this.add(param1);
            this.buddyEvent = new BuddyEvent(BuddyEvent.BUDDY_LIST_UPDATED);
            Dispatcher.dispatchEvent(this.buddyEvent);
         }
      }
      
      public function isBuddy(param1:String) : Boolean
      {
         if(this.getBuddyVoById(param1))
         {
            return true;
         }
         return false;
      }
      
      public function removeFromFriend(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.buddies) && this.buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.buddyLen)
            {
               if(param1.avatarID == this.buddies[_loc2_].avatarID)
               {
                  this.buddies.splice(_loc2_,1);
                  this._buddyLen = this.buddies.length;
                  this.buddyEvent = new BuddyEvent(BuddyEvent.BUDDY_LIST_UPDATED);
                  Dispatcher.dispatchEvent(this.buddyEvent);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function getBuddyVoById(param1:String) : BuddyVo
      {
         var _loc2_:int = 0;
         if(Boolean(this.buddies) && this.buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.buddyLen)
            {
               if(param1 == this.buddies[_loc2_].avatarID)
               {
                  return this.buddies[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function addNewRequest(param1:Object, param2:Boolean = true) : void
      {
         var _loc3_:RequestVo = null;
         if(this.getRequestVoById(param1.id) == null)
         {
            _loc3_ = new RequestVo();
            _loc3_.avatarID = param1.id;
            _loc3_.avatarName = param1.avatarName;
            this.requests.push(_loc3_);
            this.buddyEvent = new BuddyEvent(BuddyEvent.REQUEST_LIST_UPDATED);
            Dispatcher.dispatchEvent(this.buddyEvent);
         }
         this._reqLen = this.requests.length;
      }
      
      public function removeRequest(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.requests) && this.reqLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.reqLen)
            {
               if(param1.avatarID == this.requests[_loc2_].avatarID)
               {
                  this.requests.splice(_loc2_,1);
                  this._reqLen = this.requests.length;
                  this.buddyEvent = new BuddyEvent(BuddyEvent.REQUEST_LIST_UPDATED);
                  Dispatcher.dispatchEvent(this.buddyEvent);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function isRequest(param1:String) : Boolean
      {
         if(this.getRequestVoById(param1))
         {
            return true;
         }
         return false;
      }
      
      public function getRequestVoById(param1:String) : RequestVo
      {
         var _loc2_:int = 0;
         if(Boolean(this.requests) && this.reqLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.reqLen)
            {
               if(param1 == this.requests[_loc2_].avatarID)
               {
                  return this.requests[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function get moods() : Array
      {
         return null;
      }
      
      public function set moods(param1:Array) : void
      {
      }
   }
}

