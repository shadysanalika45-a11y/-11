package com.greensock
{
   import flash.display.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.utils.*;
   
   use namespace flash_proxy;
   
   public dynamic class TweenProxy3D extends Proxy
   {
      
      public static const VERSION:Number = 0.94;
      
      private static const _DEG2RAD:Number = Math.PI / 180;
      
      private static const _RAD2DEG:Number = 180 / Math.PI;
      
      private static var _dict:Dictionary = new Dictionary(false);
      
      private static var _addedProps:String = " tint tintPercent scale skewX skewY skewX2 skewY2 target registration registrationX registrationY localRegistration localRegistrationX localRegistrationY ";
      
      private var _target:DisplayObject;
      
      private var _root:DisplayObject;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _scaleZ:Number;
      
      private var _rotationX:Number;
      
      private var _rotationY:Number;
      
      private var _rotationZ:Number;
      
      private var _skewX:Number;
      
      private var _skewY:Number;
      
      private var _skewX2Mode:Boolean;
      
      private var _skewY2Mode:Boolean;
      
      private var _proxies:Array;
      
      private var _localRegistration:Vector3D;
      
      private var _registration:Vector3D;
      
      private var _regAt0:Boolean;
      
      public var ignoreSiblingUpdates:Boolean = false;
      
      public function TweenProxy3D(param1:DisplayObject, param2:Boolean = false)
      {
         super();
         this._target = param1;
         if(_dict[this._target] == undefined)
         {
            _dict[this._target] = [];
         }
         if(this._target.root != null)
         {
            this._root = this._target.root;
         }
         else
         {
            this._target.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         }
         this._proxies = _dict[this._target];
         this._proxies[this._proxies.length] = this;
         this._localRegistration = new Vector3D();
         this._registration = new Vector3D();
         if(this._target.transform.matrix3D == null)
         {
            this._target.z = 0;
         }
         this.ignoreSiblingUpdates = param2;
         this.calibrate();
      }
      
      public static function create(param1:DisplayObject, param2:Boolean = true) : TweenProxy3D
      {
         if(_dict[param1] != null && param2)
         {
            return _dict[param1][0];
         }
         return new TweenProxy3D(param1);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         this._root = this._target.root;
         this._target.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      public function calibrate() : void
      {
         this._rotationX = this._target.rotationX;
         this._rotationY = this._target.rotationY;
         this._rotationZ = this._target.rotationZ;
         this._target.rotationX = this._rotationX;
         this._skewX = this._skewY = 0;
         this._scaleX = this._target.scaleX;
         this._scaleY = this._target.scaleY;
         this._scaleZ = this._target.scaleZ;
         this.calibrateRegistration();
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function destroy() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = _dict[this._target];
         _loc2_ = _loc1_.length - 1;
         while(_loc2_ > -1)
         {
            if(_loc1_[_loc2_] == this)
            {
               _loc1_.splice(_loc2_,1);
            }
            _loc2_--;
         }
         if(_loc1_.length == 0)
         {
            delete _dict[this._target];
         }
         this._target = null;
         this._localRegistration = null;
         this._registration = null;
         this._proxies = null;
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         return this._target[param1].apply(null,rest);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this._target[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         this._target[param1] = param2;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         if(this._target.hasOwnProperty(param1))
         {
            return true;
         }
         if(_addedProps.indexOf(" " + param1 + " ") != -1)
         {
            return true;
         }
         return false;
      }
      
      public function moveRegX(param1:Number) : void
      {
         this._registration.x += param1;
      }
      
      public function moveRegY(param1:Number) : void
      {
         this._registration.y += param1;
      }
      
      public function moveRegZ(param1:Number) : void
      {
         this._registration.z += param1;
      }
      
      private function reposition() : void
      {
         var _loc1_:Vector3D = null;
         if(this._root != null)
         {
            _loc1_ = this._target.transform.getRelativeMatrix3D(this._root).deltaTransformVector(this._localRegistration);
            this._target.x = this._registration.x - _loc1_.x;
            this._target.y = this._registration.y - _loc1_.y;
            this._target.z = this._registration.z - _loc1_.z;
         }
      }
      
      private function updateSiblingProxies() : void
      {
         var _loc1_:int = this._proxies.length - 1;
         while(_loc1_ > -1)
         {
            if(this._proxies[_loc1_] != this)
            {
               this._proxies[_loc1_].onSiblingUpdate(this._scaleX,this._scaleY,this._scaleZ,this._rotationX,this._rotationY,this._rotationZ,this._skewX,this._skewY);
            }
            _loc1_--;
         }
      }
      
      private function calibrateLocal() : void
      {
         var _loc1_:Matrix3D = null;
         var _loc2_:Vector3D = null;
         if(this._target.parent != null)
         {
            _loc1_ = this._target.transform.getRelativeMatrix3D(this._target.parent);
            _loc1_.invert();
            _loc2_ = _loc1_.deltaTransformVector(new Vector3D(this._registration.x - this._target.x,this._registration.y - this._target.y,this._registration.z - this._target.z));
            this._localRegistration.x = _loc2_.x;
            this._localRegistration.y = _loc2_.y;
            this._localRegistration.z = _loc2_.z;
            this._regAt0 = this._localRegistration.x == 0 && this._localRegistration.y == 0 && this._localRegistration.z == 0;
         }
      }
      
      private function calibrateRegistration() : void
      {
         var _loc1_:Vector3D = null;
         if(this._root != null)
         {
            _loc1_ = this._target.transform.getRelativeMatrix3D(this._root).deltaTransformVector(this._localRegistration);
            this._registration.x = this._target.x + _loc1_.x;
            this._registration.y = this._target.y + _loc1_.y;
            this._registration.z = this._target.z + _loc1_.z;
         }
      }
      
      public function onSiblingUpdate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         this._scaleX = param1;
         this._scaleY = param2;
         this._scaleZ = param3;
         this._rotationX = param4;
         this._rotationY = param5;
         this._rotationZ = param6;
         this._skewX = param7;
         this._skewY = param8;
         if(this.ignoreSiblingUpdates)
         {
            this.calibrateLocal();
         }
         else
         {
            this.calibrateRegistration();
         }
      }
      
      public function get localRegistration() : Vector3D
      {
         return this._localRegistration;
      }
      
      public function set localRegistration(param1:Vector3D) : void
      {
         this._localRegistration = param1;
         this.calibrateRegistration();
      }
      
      public function get localRegistrationX() : Number
      {
         return this._localRegistration.x;
      }
      
      public function set localRegistrationX(param1:Number) : void
      {
         this._localRegistration.x = param1;
         this.calibrateRegistration();
      }
      
      public function get localRegistrationY() : Number
      {
         return this._localRegistration.y;
      }
      
      public function set localRegistrationY(param1:Number) : void
      {
         this._localRegistration.y = param1;
         this.calibrateRegistration();
      }
      
      public function get localRegistrationZ() : Number
      {
         return this._localRegistration.z;
      }
      
      public function set localRegistrationZ(param1:Number) : void
      {
         this._localRegistration.z = param1;
         this.calibrateRegistration();
      }
      
      public function get registration() : Vector3D
      {
         return this._registration;
      }
      
      public function set registration(param1:Vector3D) : void
      {
         this._registration = param1;
         this.calibrateLocal();
      }
      
      public function get registrationX() : Number
      {
         return this._registration.x;
      }
      
      public function set registrationX(param1:Number) : void
      {
         this._registration.x = param1;
         this.calibrateLocal();
      }
      
      public function get registrationY() : Number
      {
         return this._registration.y;
      }
      
      public function set registrationY(param1:Number) : void
      {
         this._registration.y = param1;
         this.calibrateLocal();
      }
      
      public function get registrationZ() : Number
      {
         return this._registration.z;
      }
      
      public function set registrationZ(param1:Number) : void
      {
         this._registration.z = param1;
         this.calibrateLocal();
      }
      
      public function get x() : Number
      {
         return this._registration.x;
      }
      
      public function set x(param1:Number) : void
      {
         var _loc2_:Number = param1 - this._registration.x;
         this._target.x += _loc2_;
         var _loc3_:int = this._proxies.length - 1;
         while(_loc3_ > -1)
         {
            if(this._proxies[_loc3_] == this || !this._proxies[_loc3_].ignoreSiblingUpdates)
            {
               this._proxies[_loc3_].moveRegX(_loc2_);
            }
            _loc3_--;
         }
      }
      
      public function get y() : Number
      {
         return this._registration.y;
      }
      
      public function set y(param1:Number) : void
      {
         var _loc2_:Number = param1 - this._registration.y;
         this._target.y += _loc2_;
         var _loc3_:int = this._proxies.length - 1;
         while(_loc3_ > -1)
         {
            if(this._proxies[_loc3_] == this || !this._proxies[_loc3_].ignoreSiblingUpdates)
            {
               this._proxies[_loc3_].moveRegY(_loc2_);
            }
            _loc3_--;
         }
      }
      
      public function get z() : Number
      {
         return this._registration.z;
      }
      
      public function set z(param1:Number) : void
      {
         var _loc2_:Number = param1 - this._registration.z;
         this._target.z += _loc2_;
         var _loc3_:int = this._proxies.length - 1;
         while(_loc3_ > -1)
         {
            if(this._proxies[_loc3_] == this || !this._proxies[_loc3_].ignoreSiblingUpdates)
            {
               this._proxies[_loc3_].moveRegZ(_loc2_);
            }
            _loc3_--;
         }
      }
      
      public function get rotationX() : Number
      {
         return this._rotationX;
      }
      
      public function set rotationX(param1:Number) : void
      {
         this._rotationX = param1;
         if(this._skewX != 0 || this._skewY != 0)
         {
            this.updateWithSkew();
         }
         else
         {
            this._target.rotationX = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get rotationY() : Number
      {
         return this._rotationY;
      }
      
      public function set rotationY(param1:Number) : void
      {
         this._rotationY = param1;
         if(this._skewX != 0 || this._skewY != 0)
         {
            this.updateWithSkew();
         }
         else
         {
            this._target.rotationY = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get rotationZ() : Number
      {
         return this._rotationZ;
      }
      
      public function set rotationZ(param1:Number) : void
      {
         this._rotationZ = param1;
         if(this._skewX != 0 || this._skewY != 0)
         {
            this.updateWithSkew();
         }
         else
         {
            this._target.rotationZ = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get rotation() : Number
      {
         return this._rotationZ;
      }
      
      public function set rotation(param1:Number) : void
      {
         this.rotationZ = param1;
      }
      
      private function updateWithSkew() : void
      {
         var _loc1_:Matrix3D = null;
         var _loc2_:Vector.<Number> = null;
         var _loc3_:Matrix3D = new Matrix3D();
         var _loc4_:Number = this._scaleX;
         var _loc5_:Number = this._scaleY;
         var _loc6_:Number = this._rotationZ * _DEG2RAD;
         if(this._scaleX < 0)
         {
            _loc4_ = -_loc4_;
            _loc3_.appendRotation(180,Vector3D.Z_AXIS);
            _loc5_ = -_loc5_;
         }
         if(_loc4_ != 1 || _loc5_ != 1 || this._scaleZ != 1)
         {
            _loc3_.appendScale(_loc4_,_loc5_,this._scaleZ);
         }
         if(this._skewX != 0)
         {
            _loc1_ = new Matrix3D();
            _loc2_ = _loc1_.rawData;
            if(this._skewX2Mode)
            {
               _loc2_[4] = Math.tan(-this._skewX + _loc6_);
            }
            else
            {
               _loc2_[4] = -Math.sin(this._skewX + _loc6_);
               _loc2_[5] = Math.cos(this._skewX + _loc6_);
            }
            _loc1_.rawData = _loc2_;
            _loc3_.prepend(_loc1_);
         }
         if(this._skewY != 0)
         {
            _loc1_ = new Matrix3D();
            _loc2_ = _loc1_.rawData;
            if(this._skewY2Mode)
            {
               _loc2_[1] = Math.tan(this._skewY + _loc6_);
            }
            else
            {
               _loc2_[0] = Math.cos(this._skewY + _loc6_);
               _loc2_[1] = Math.sin(this._skewY + _loc6_);
            }
            _loc1_.rawData = _loc2_;
            _loc3_.prepend(_loc1_);
         }
         if(this._rotationX != 0)
         {
            _loc3_.appendRotation(this._rotationX,Vector3D.X_AXIS);
         }
         if(this._rotationY != 0)
         {
            _loc3_.appendRotation(this._rotationY,Vector3D.Y_AXIS);
         }
         if(this._rotationZ != 0)
         {
            _loc3_.appendRotation(this._rotationZ,Vector3D.Z_AXIS);
         }
         this._target.transform.matrix3D = _loc3_;
         this.reposition();
         if(this._proxies.length > 1)
         {
            this.updateSiblingProxies();
         }
      }
      
      public function get skewX() : Number
      {
         return this._skewX * _RAD2DEG;
      }
      
      public function set skewX(param1:Number) : void
      {
         this._skewX2Mode = false;
         this._skewX = param1 * _DEG2RAD;
         this.updateWithSkew();
      }
      
      public function get skewY() : Number
      {
         return this._skewY * _RAD2DEG;
      }
      
      public function set skewY(param1:Number) : void
      {
         this._skewY2Mode = false;
         this._skewY = param1 * _DEG2RAD;
         this.updateWithSkew();
      }
      
      public function get skewX2() : Number
      {
         return this._skewX * _RAD2DEG;
      }
      
      public function set skewX2(param1:Number) : void
      {
         this._skewX2Mode = true;
         this._skewX = param1 * _DEG2RAD;
         this.updateWithSkew();
      }
      
      public function get skewY2() : Number
      {
         return this._skewY * _RAD2DEG;
      }
      
      public function set skewY2(param1:Number) : void
      {
         this._skewY2Mode = true;
         this._skewY = param1 * _DEG2RAD;
         this.updateWithSkew();
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         if(this._skewX != 0 || this._skewY != 0 || param1 < 0 || this._scaleX < 0)
         {
            this._scaleX = param1;
            this.updateWithSkew();
         }
         else
         {
            this._scaleX = this._target.scaleX = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         if(this._skewX != 0 || this._skewY != 0 || param1 < 0 || this._scaleY < 0)
         {
            this._scaleY = param1;
            this.updateWithSkew();
         }
         else
         {
            this._scaleY = this._target.scaleY = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get scaleZ() : Number
      {
         return this._scaleZ;
      }
      
      public function set scaleZ(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         if(this._skewX != 0 || this._skewY != 0 || param1 < 0 || this._scaleZ < 0)
         {
            this._scaleZ = param1;
            this.updateWithSkew();
         }
         else
         {
            this._scaleZ = this._target.scaleZ = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get scale() : Number
      {
         return (this._scaleX + this._scaleY + this._scaleZ) / 3;
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         if(this._skewX != 0 || this._skewY != 0 || param1 < 0 || this._scaleX < 0 || this._scaleY < 0 || this._scaleZ < 0)
         {
            this._scaleX = this._scaleY = this._scaleZ = param1;
            this.updateWithSkew();
         }
         else
         {
            this._scaleX = this._scaleY = this._scaleZ = this._target.scaleX = this._target.scaleY = this._target.scaleZ = param1;
            if(!this._regAt0)
            {
               this.reposition();
            }
            if(this._proxies.length > 1)
            {
               this.updateSiblingProxies();
            }
         }
      }
      
      public function get alpha() : Number
      {
         return this._target.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._target.alpha = param1;
      }
      
      public function get width() : Number
      {
         return this._target.width;
      }
      
      public function set width(param1:Number) : void
      {
         this._target.width = param1;
         if(!this._regAt0)
         {
            this.reposition();
         }
         if(this._proxies.length > 1)
         {
            this.updateSiblingProxies();
         }
      }
      
      public function get height() : Number
      {
         return this._target.height;
      }
      
      public function set height(param1:Number) : void
      {
         this._target.height = param1;
         if(!this._regAt0)
         {
            this.reposition();
         }
         if(this._proxies.length > 1)
         {
            this.updateSiblingProxies();
         }
      }
   }
}

