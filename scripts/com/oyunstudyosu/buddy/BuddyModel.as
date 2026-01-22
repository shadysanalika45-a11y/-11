package com.oyunstudyosu.buddy
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.BarterEvent;
   import com.oyunstudyosu.events.BuddyEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.interfaces.IBuddyModel;
   import de.polygonal.core.fmt.Sprintf;
   
   public class BuddyModel implements IBuddyModel
   {
      
      private var _buddies:Vector.<BuddyVo> = new Vector.<BuddyVo>();
      
      private var _requests:Vector.<RequestVo> = new Vector.<RequestVo>();
      
      private var vo:BuddyVo;
      
      private var _isActived:Boolean;
      
      private var _buddyLen:int;
      
      private var _reqLen:int;
      
      private var alertVo:AlertVo;
      
      private var _moods:Array;
      
      public function BuddyModel()
      {
         super();
      }
      
      public function get reqLen() : int
      {
         return _reqLen;
      }
      
      public function get buddyLen() : int
      {
         return _buddyLen;
      }
      
      public function get moods() : Array
      {
         return _moods;
      }
      
      public function set moods(param1:Array) : void
      {
         if(_moods == param1)
         {
            return;
         }
         _moods = param1;
      }
      
      public function get isActived() : Boolean
      {
         return _isActived;
      }
      
      public function set isActived(param1:Boolean) : void
      {
         _isActived = param1;
      }
      
      public function get buddies() : Vector.<BuddyVo>
      {
         return _buddies;
      }
      
      public function get requests() : Vector.<RequestVo>
      {
         return _requests;
      }
      
      public function add(param1:Object) : void
      {
         vo = new BuddyVo();
         vo.avatarID = param1.avatarID;
         vo.avatarName = param1.avatarName;
         vo.imgPath = param1.imgPath;
         if(param1.status)
         {
            vo.status = param1.status;
         }
         else
         {
            vo.status = "";
         }
         vo.isOnline = param1.isOnline;
         vo.mood = param1.mood;
         vo.buddyMood = param1.buddyRating;
         vo.myMood = param1.myRating;
         buddies.push(vo);
         _buddyLen = buddies.length;
      }
      
      public function changeOnlineStatus(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BarterEvent = null;
         var _loc3_:BuddyEvent = null;
         if(param1.avatarID == null)
         {
            return;
         }
         if(buddies && buddyLen > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < buddyLen)
            {
               if(param1.avatarID == buddies[_loc4_].avatarID)
               {
                  if(param1.isOnline && param1.isOnline == true)
                  {
                     if(buddies[_loc4_].isOnline == true && param1.isOnline == true)
                     {
                        return;
                     }
                     buddies[_loc4_].isOnline = true;
                     alertVo = new AlertVo();
                     alertVo.alertType = "tooltip";
                     alertVo.description = Sprintf.format($("buddyOn"),[buddies[_loc4_].avatarName]);
                     Dispatcher.dispatchEvent(new AlertEvent(alertVo));
                  }
                  else
                  {
                     if(buddies[_loc4_].isOnline == false && param1.isOnline == false)
                     {
                        return;
                     }
                     buddies[_loc4_].isOnline = false;
                     alertVo = new AlertVo();
                     alertVo.alertType = "tooltip";
                     alertVo.description = Sprintf.format($("buddyOff"),[buddies[_loc4_].avatarName]);
                     Dispatcher.dispatchEvent(new AlertEvent(alertVo));
                     _loc2_ = new BarterEvent("BarterEvent.BARTER_CANCEL");
                     _loc2_.avatarID = buddies[_loc4_].avatarID;
                     Dispatcher.dispatchEvent(_loc2_);
                  }
                  _loc3_ = new BuddyEvent("MyBuddyEvent.BUDDY_LIST_UPDATED");
                  _loc3_.avatarID = param1.avatarID;
                  Dispatcher.dispatchEvent(_loc3_);
                  return;
               }
               _loc4_++;
            }
         }
      }
      
      public function changeRelation(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(buddies && buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < buddyLen)
            {
               if(param1.avatarID == buddies[_loc2_].avatarID)
               {
                  if(param1.buddyRating)
                  {
                     buddies[_loc2_].buddyMood = param1.buddyRating;
                     alertVo = new AlertVo();
                     alertVo.alertType = "tooltip";
                     alertVo.description = Sprintf.format($("buddyRelationChanged"),[buddies[_loc2_].avatarName]);
                     Dispatcher.dispatchEvent(new AlertEvent(alertVo));
                  }
                  if(param1.myRating)
                  {
                     buddies[_loc2_].myMood = param1.myRating;
                  }
                  Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.BUDDY_LIST_UPDATED"));
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function changeMood(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1.avatarID == null)
         {
            return;
         }
         if(buddies && buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < buddyLen)
            {
               if(param1.avatarID == buddies[_loc2_].avatarID)
               {
                  buddies[_loc2_].mood = param1.mood;
                  Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.BUDDY_LIST_UPDATED"));
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function changeStatusMessage(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(buddies && buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < buddyLen)
            {
               if(param1.avatarID == buddies[_loc2_].avatarID)
               {
                  buddies[_loc2_].message = param1.message;
                  Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.BUDDY_LIST_UPDATED"));
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function addNewBuddy(param1:Object) : void
      {
         if(getBuddyVoById(param1.avatarID) == null)
         {
            add(param1);
            Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.BUDDY_LIST_UPDATED"));
            alertVo = new AlertVo();
            alertVo.alertType = "tooltip";
            alertVo.description = Sprintf.format($("newBuddyAdded"),[param1.avatarName]);
            Dispatcher.dispatchEvent(new AlertEvent(alertVo));
         }
      }
      
      public function isBuddy(param1:String) : Boolean
      {
         if(getBuddyVoById(param1))
         {
            return true;
         }
         return false;
      }
      
      public function removeFromFriend(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BarterEvent = null;
         if(buddies && buddyLen > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < buddyLen)
            {
               if(param1.avatarID == buddies[_loc3_].avatarID)
               {
                  buddies.splice(_loc3_,1);
                  _buddyLen = buddies.length;
                  _loc2_ = new BarterEvent("BarterEvent.BARTER_CANCEL");
                  _loc2_.avatarID = param1.avatarID;
                  Dispatcher.dispatchEvent(_loc2_);
                  Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.BUDDY_LIST_UPDATED"));
                  return;
               }
               _loc3_++;
            }
         }
      }
      
      public function getBuddyVoById(param1:String) : BuddyVo
      {
         var _loc2_:int = 0;
         if(buddies && buddyLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < buddyLen)
            {
               if(param1 == buddies[_loc2_].avatarID)
               {
                  return buddies[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function addNewRequest(param1:Object, param2:Boolean = true) : void
      {
         var _loc3_:RequestVo = null;
         if(getRequestVoById(param1.avatarID) == null)
         {
            _loc3_ = new RequestVo();
            _loc3_.avatarID = param1.avatarID;
            if(param1.avatarName)
            {
               _loc3_.avatarName = param1.avatarName;
            }
            else
            {
               _loc3_.avatarName = "";
            }
            requests.push(_loc3_);
            _reqLen = requests.length;
            Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.REQUEST_LIST_UPDATED"));
            if(param2)
            {
               alertVo = new AlertVo();
               alertVo.alertType = "tooltip";
               alertVo.description = Sprintf.format($("buddyreqReceived"),[_loc3_.avatarName]);
               alertVo.sound = true;
               alertVo.callBack = buddyReqTipClicked;
               Dispatcher.dispatchEvent(new AlertEvent(alertVo));
            }
         }
      }
      
      public function buddyReqTipClicked() : void
      {
         var _loc1_:PanelVO = new PanelVO();
         _loc1_.params = {};
         _loc1_.params.page = "request";
         _loc1_.name = "BuddyListPanel";
         Sanalika.instance.panelModel.openPanel(_loc1_);
      }
      
      public function removeRequest(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(requests && reqLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < reqLen)
            {
               if(param1.avatarID == requests[_loc2_].avatarID)
               {
                  requests.splice(_loc2_,1);
                  _reqLen = requests.length;
                  Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.REQUEST_LIST_UPDATED"));
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function isRequest(param1:String) : Boolean
      {
         if(getRequestVoById(param1))
         {
            return true;
         }
         return false;
      }
      
      public function getRequestVoById(param1:String) : RequestVo
      {
         var _loc2_:int = 0;
         if(requests && reqLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < reqLen)
            {
               if(param1 == requests[_loc2_].avatarID)
               {
                  return requests[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function clear() : void
      {
         _buddies = new Vector.<BuddyVo>();
         _requests = new Vector.<RequestVo>();
         _reqLen = 0;
      }
   }
}

