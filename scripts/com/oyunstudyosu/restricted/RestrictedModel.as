package com.oyunstudyosu.restricted
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.RestrictedEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.IRestrictedModel;
   
   public class RestrictedModel implements IRestrictedModel
   {
      
      private var _restricted:Vector.<RestrictedVo> = new Vector.<RestrictedVo>();
      
      private var _resLen:int;
      
      private var vo:RestrictedVo;
      
      private var _isActive:Boolean;
      
      public function RestrictedModel()
      {
         super();
      }
      
      public function get restricted() : Vector.<RestrictedVo>
      {
         return _restricted;
      }
      
      public function get restrictedLen() : int
      {
         return _resLen;
      }
      
      public function removeAll() : void
      {
         _restricted = new Vector.<RestrictedVo>();
      }
      
      public function add(param1:Object) : void
      {
         vo = new RestrictedVo();
         vo.avatarID = param1.avatarID;
         vo.name = param1.name;
         if(param1.duration == 0)
         {
            vo.duration = $("immortal");
         }
         else
         {
            vo.duration = param1.duration / 60000 * 60 + " hour";
         }
         restricted.push(vo);
         _resLen = restricted.length;
      }
      
      public function addNewRestriction(param1:Object) : void
      {
         if(getRestrictedVoById(param1.avatarID) == null)
         {
            add(param1);
            Dispatcher.dispatchEvent(new RestrictedEvent("MyRestrictedEvent.RESTRICTED_LIST_UPDATED"));
         }
      }
      
      public function removeFromRestricted(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(restricted && _resLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _resLen)
            {
               if(param1.avatarID == restricted[_loc2_].avatarID)
               {
                  restricted.splice(_loc2_,1);
                  _resLen = restricted.length;
                  Dispatcher.dispatchEvent(new RestrictedEvent("MyRestrictedEvent.RESTRICTED_LIST_UPDATED"));
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      public function getRestrictedVoById(param1:String) : RestrictedVo
      {
         var _loc2_:int = 0;
         if(restricted && _resLen > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _resLen)
            {
               if(param1 == restricted[_loc2_].avatarID)
               {
                  return restricted[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
      }
   }
}

