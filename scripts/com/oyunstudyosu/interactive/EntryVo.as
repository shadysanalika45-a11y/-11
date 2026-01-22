package com.oyunstudyosu.interactive
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.door.IProperty;
   import com.oyunstudyosu.property.FarmProperty;
   import com.oyunstudyosu.property.FrameProperty;
   import com.oyunstudyosu.property.GatheringProperty;
   import com.oyunstudyosu.property.GridSealingProperty;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import org.oyunstudyosu.assets.clips.GatheringIndicator;
   import org.oyunstudyosu.assets.clips.LockIcon;
   
   public class EntryVo implements IEntryVo
   {
      
      private var _id:int;
      
      private var _definition:String;
      
      private var _y:int;
      
      private var _x:int;
      
      private var _z:int;
      
      private var _clip:MovieClip;
      
      private var _height:int;
      
      private var _width:int;
      
      private var _depth:int;
      
      private var _f:int;
      
      private var _s:int;
      
      private var _fx:int;
      
      private var _lc:int;
      
      private var _st:int;
      
      private var _sv:int;
      
      private var _isBusy:Boolean;
      
      private var _property:IProperty;
      
      public function EntryVo()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         if(_id == param1)
         {
            return;
         }
         _id = param1;
      }
      
      public function get definition() : String
      {
         return _definition;
      }
      
      public function set definition(param1:String) : void
      {
         if(_definition == param1)
         {
            return;
         }
         _definition = param1;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set y(param1:int) : void
      {
         if(_y == param1)
         {
            return;
         }
         _y = param1;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(param1:int) : void
      {
         if(_x == param1)
         {
            return;
         }
         _x = param1;
      }
      
      public function get z() : int
      {
         return _z;
      }
      
      public function set z(param1:int) : void
      {
         if(_z == param1)
         {
            return;
         }
         _z = param1;
      }
      
      public function get clip() : MovieClip
      {
         return _clip;
      }
      
      public function gotoFrame(param1:int) : void
      {
         clip.gotoAndStop(param1);
      }
      
      protected function hasLabel(param1:String) : Boolean
      {
         var _loc3_:* = 0;
         var _loc2_:int = int(clip.currentLabels.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(clip.currentLabels[_loc3_].name == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function gotoFrameLabel(param1:String) : void
      {
         if(hasLabel(param1))
         {
            clip.gotoAndStop(param1);
         }
         else
         {
            trace(param1 + " has no frame");
         }
      }
      
      public function lockState() : void
      {
         (clip.getChildByName("lock") as MovieClip).gotoAndStop(_lc);
      }
      
      public function setIndicator() : void
      {
         var _loc1_:int = _sv;
         if(_loc1_ > _st)
         {
            _loc1_ = _st;
         }
         (clip.getChildByName("indicator") as MovieClip).bar.width = _loc1_ / _st * 30;
         (clip.getChildByName("indicator") as MovieClip).txtIndicator.text = Math.round(_sv * 100 / _st) + "%";
      }
      
      public function set clip(param1:MovieClip) : void
      {
         if(_clip == param1)
         {
            return;
         }
         _clip = param1;
         clip.buttonMode = true;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function set height(param1:int) : void
      {
         if(_height == param1)
         {
            return;
         }
         _height = param1;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function set width(param1:int) : void
      {
         if(_width == param1)
         {
            return;
         }
         _width = param1;
      }
      
      public function get depth() : int
      {
         return _depth;
      }
      
      public function set depth(param1:int) : void
      {
         if(_depth == param1)
         {
            return;
         }
         _depth = param1;
      }
      
      public function get f() : int
      {
         return _f;
      }
      
      public function set f(param1:int) : void
      {
         if(_f == param1)
         {
            return;
         }
         _f = param1;
      }
      
      public function get s() : int
      {
         return _s;
      }
      
      public function set s(param1:int) : void
      {
         if(_s == param1)
         {
            return;
         }
         _s = param1;
      }
      
      public function get fx() : int
      {
         return _fx;
      }
      
      public function set fx(param1:int) : void
      {
         if(_fx == param1)
         {
            return;
         }
         _fx = param1;
      }
      
      public function get lc() : int
      {
         return _lc;
      }
      
      public function set lc(param1:int) : void
      {
         if(_lc == param1)
         {
            return;
         }
         _lc = param1;
      }
      
      public function get st() : int
      {
         return _st;
      }
      
      public function set st(param1:int) : void
      {
         if(_st == param1)
         {
            return;
         }
         _st = param1;
      }
      
      public function get sv() : int
      {
         return _sv;
      }
      
      public function set sv(param1:int) : void
      {
         if(_sv == param1)
         {
            return;
         }
         _sv = param1;
      }
      
      public function get isBusy() : Boolean
      {
         return _isBusy;
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         if(_isBusy == param1)
         {
            return;
         }
         _isBusy = param1;
      }
      
      public function get property() : IProperty
      {
         return _property;
      }
      
      public function setProperty(param1:Object) : void
      {
         var _loc2_:Class = null;
         if(param1 == null)
         {
            trace("No item property for " + id);
            return;
         }
         GridSealingProperty;
         GatheringProperty;
         FrameProperty;
         FarmProperty;
         try
         {
            _loc2_ = getDefinitionByName("com.oyunstudyosu.property." + param1.cn) as Class;
         }
         catch(error:Error)
         {
            trace("No entryVo class found named:" + param1.cn);
            return;
         }
         _property = new _loc2_();
         param1.type = "item";
         param1.metaKey = id;
         param1.clip = clip;
         _property.data = param1;
      }
      
      public function addIndicator() : void
      {
         var _loc1_:GatheringIndicator = new GatheringIndicator();
         _loc1_.y = -10;
         _loc1_.x = -6;
         _loc1_.name = "indicator";
         clip.addChild(_loc1_);
         setIndicator();
      }
      
      public function lockChange(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         Sanalika.instance.serviceModel.requestData("changeobjectlock",{"id":_id},onLockChange);
      }
      
      private function onLockChange(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("changeobjectlock",onLockChange);
      }
      
      public function addLock() : void
      {
         var _loc1_:LockIcon = new LockIcon();
         _loc1_.y = -12;
         _loc1_.x = 0;
         _loc1_.name = "lock";
         if(Sanalika.instance.avatarModel.permission.check(20) || Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            _loc1_.buttonMode = true;
            _loc1_.addEventListener("click",lockChange);
         }
         clip.addChild(_loc1_);
         lockState();
      }
      
      public function over() : void
      {
         if(!isBusy)
         {
            isBusy = true;
         }
         TweenMax.to(clip,0,{"glowFilter":{
            "color":16777215,
            "alpha":1,
            "blurX":2,
            "blurY":2,
            "strength":2
         }});
      }
      
      public function out() : void
      {
         if(isBusy)
         {
            isBusy = false;
         }
         TweenMax.to(clip,0,{"glowFilter":{
            "color":16777215,
            "alpha":0,
            "blurX":0,
            "blurY":0,
            "strength":0
         }});
      }
      
      public function dispose() : void
      {
         if(_property)
         {
            _property.dispose();
         }
      }
   }
}

