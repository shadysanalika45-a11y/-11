package com.oyunstudyosu.model
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import org.oyunstudyosu.avatar.AvatarMobileView;
   import org.oyunstudyosu.mobile.MobileView;
   
   public class MobileModel
   {
      
      public var mobileView:MobileView;
      
      public var index:int = 0;
      
      public var av:AvatarMobileView;
      
      public function MobileModel()
      {
         super();
         mobileView = new MobileView();
         mobileView.name = "mobileView";
         mobileView.x = -12;
         mobileView.y = 40;
         Sanalika.instance.layerModel.hudLayer.addChild(mobileView);
         Dispatcher.addEventListener("USER_ENTER_ROOM",add);
         Dispatcher.addEventListener("USER_LEAVE_ROOM",remove);
      }
      
      public function add(param1:GameEvent = null) : void
      {
      }
      
      public function addById(param1:String) : void
      {
         trace("addById",param1);
         TweenMax.delayedCall(1,addByIdDelayed,[param1]);
      }
      
      public function addByIdDelayed(param1:String) : void
      {
         if(!mobileView.getChildByName(param1))
         {
            av = new AvatarMobileView();
            av.name = param1;
            try
            {
               av.avatarName = Sanalika.instance.serviceModel.getVariableByUserId("avatarName",param1).getStringValue();
               mobileView.addChild(av);
            }
            catch(e:Error)
            {
               trace(e.message);
               trace(e.getStackTrace());
            }
            updateView();
         }
      }
      
      public function remove(param1:GameEvent = null) : void
      {
         if(mobileView.getChildByName(param1.id))
         {
            (mobileView.getChildByName(param1.id) as AvatarMobileView).dispose();
            updateView();
         }
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < mobileView.numChildren)
         {
            (mobileView.getChildAt(_loc1_) as AvatarMobileView).dispose();
            updateView();
            _loc1_++;
         }
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < mobileView.numChildren)
         {
            if(_loc1_ == 0)
            {
               mobileView.getChildAt(_loc1_).y = 0;
            }
            else
            {
               mobileView.getChildAt(_loc1_).y = mobileView.getChildAt(_loc1_ - 1).y + mobileView.getChildAt(_loc1_ - 1).height + 3;
            }
            _loc1_++;
         }
      }
   }
}

