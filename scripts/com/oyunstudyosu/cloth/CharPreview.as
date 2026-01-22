package com.oyunstudyosu.cloth
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.enums.ItemType;
   import com.oyunstudyosu.events.PackItemEvent;
   import flash.display.MovieClip;
   
   public class CharPreview implements ICharPreview
   {
      
      private var container:MovieClip;
      
      private var hold:String = "";
      
      private var status:String = "i";
      
      private var direction:int = 3;
      
      private var activeClothes:Array = [];
      
      public var sex:String;
      
      private var activePlacement:int;
      
      private var activeClothPlacement:Array = [];
      
      private var loadingAnimation:MovieClip;
      
      private var char:ICharacter;
      
      private var defaultClothes:Array;
      
      private var allClothes:Array;
      
      public var isTerminated:Boolean = false;
      
      public var hideEffects:Boolean = false;
      
      private var _scale:Number;
      
      public function CharPreview(param1:MovieClip, param2:Object = null, param3:Array = null, param4:Boolean = false)
      {
         super();
         if(param3)
         {
            allClothes = param3;
         }
         this.container = param1;
         this.hideEffects = param4;
         Sanalika.instance.itemModel.addItemListener(packEventFunction);
         if(param2 == null)
         {
            sex = Sanalika.instance.avatarModel.gender;
            loadFromArray(Sanalika.instance.clothModel.getVisibleClothArray());
         }
         else if(param2 is Array)
         {
            sex = ((param2 as Array)[0] as Cloth).key.substr(0,1);
            loadFromArray(param2 as Array);
         }
         else if(param2 is Character)
         {
            sex = (param2 as Character).sex;
            loadFromChar(param2 as Character);
         }
         CharPreviewManager.register(this);
      }
      
      private function showLoadingAnimation() : void
      {
         if(loadingAnimation != null)
         {
            return;
         }
         loadingAnimation = Sanalika.instance.itemModel.getBigLoadingAnimation();
         loadingAnimation.x = 0;
         loadingAnimation.y = -27;
         container.addChild(loadingAnimation);
      }
      
      private function hideLoadingAnimation() : void
      {
         if(loadingAnimation == null)
         {
            return;
         }
         try
         {
            container.removeChild(loadingAnimation);
            loadingAnimation = null;
         }
         catch(error:Error)
         {
         }
      }
      
      private function packEventFunction(param1:PackItemEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:Cloth4Preview = null;
         _loc4_ = 0;
         while(_loc4_ < activeClothes.length)
         {
            _loc3_ = activeClothes[_loc4_];
            if(_loc3_.getKey() == param1.key)
            {
               _loc3_.initMovieClip();
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         if(_loc2_)
         {
            clearAndDraw();
         }
      }
      
      public function getChar() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Cloth4Preview = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < activeClothes.length)
         {
            _loc2_ = activeClothes[_loc3_];
            _loc1_.push(_loc2_.cloth.key.replace("f_","").replace("m_",""));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getClothes() : Array
      {
         return activeClothes;
      }
      
      public function loadFromChar(param1:ICharacter) : void
      {
         var _loc4_:ClothData = null;
         var _loc2_:Cloth = null;
         if(param1 == null)
         {
            return;
         }
         activeClothes = [];
         defaultClothes = [];
         this.char = param1;
         for each(var _loc3_ in param1.bodyParts)
         {
            _loc4_ = Sanalika.instance.itemModel.getCloth(sex + "_" + _loc3_);
            if(_loc4_ != null)
            {
               _loc2_ = new Cloth(0,1,false,false,sex + "_" + _loc3_,-1,-1);
               defaultClothes.push(_loc2_);
               activeClothes.push(new Cloth4Preview(_loc2_));
            }
         }
         calcActiveBitStats();
         clearAndDraw();
      }
      
      public function loadFromArray(param1:Array) : void
      {
         var _loc3_:int = 0;
         activeClothes = [];
         defaultClothes = [];
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc2_.indexOf(param1[_loc3_].placeBit) == -1)
            {
               _loc2_.push(param1[_loc3_].placeBit);
               activeClothes.push(new Cloth4Preview(param1[_loc3_]));
               defaultClothes.push(param1[_loc3_]);
            }
            _loc3_++;
         }
         calcActiveBitStats();
         clearAndDraw();
      }
      
      public function reset() : void
      {
         hold = "";
         if(char != null)
         {
            loadFromChar(char);
         }
         else
         {
            loadFromArray(Sanalika.instance.clothModel.getVisibleClothArray());
         }
      }
      
      private function calcActiveBitStats() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Cloth4Preview = null;
         activePlacement = 0;
         activeClothPlacement = [];
         _loc2_ = 0;
         while(_loc2_ < activeClothes.length)
         {
            _loc1_ = activeClothes[_loc2_];
            activePlacement |= _loc1_.cloth.placeBit;
            setBitArray(_loc1_);
            _loc2_++;
         }
      }
      
      private function setBitArray(param1:Cloth4Preview) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 32)
         {
            if((param1.cloth.placeBit & 1 << _loc2_) != 0)
            {
               if(activeClothPlacement[_loc2_] != null)
               {
                  trace("ERR1 : BITLER ÇAKIŞTI : DEVAM");
               }
               activeClothPlacement[_loc2_] = param1;
            }
            _loc2_++;
         }
      }
      
      public function addHandItem(param1:String) : void
      {
         var _loc3_:InventoryItemData = Sanalika.instance.itemModel.getItem(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Cloth = new Cloth(0,1,false,false,param1,-1,-1,false);
         addCloth(_loc2_);
      }
      
      public function removeHandItemByName(param1:String) : void
      {
         var _loc2_:Cloth4Preview = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         trace("removeHandItemByName");
         var _loc6_:InventoryItemData = Sanalika.instance.itemModel.getItem(param1);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:int = int(activeClothes.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = Cloth4Preview(activeClothes[_loc5_]);
            _loc4_ = _loc2_.cloth.placeBit;
            if(_loc2_.cloth.key == param1 && (_loc4_ & ClothType.BIT22_HANDITEM) != 0)
            {
               activeClothes.splice(_loc5_,1);
               container.removeChild(_loc2_.mc);
               hold = "";
               updateCharStatus();
               break;
            }
            _loc5_++;
         }
      }
      
      public function removeHandItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Cloth4Preview = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < activeClothes.length)
         {
            _loc1_ = Cloth4Preview(activeClothes[_loc3_]);
            _loc2_ = _loc1_.cloth.placeBit;
            if((_loc2_ & ClothType.BIT22_HANDITEM) != 0)
            {
               activeClothes.splice(_loc3_,1);
               container.removeChild(_loc1_.mc);
               hold = "";
               updateCharStatus();
               break;
            }
            _loc3_++;
         }
      }
      
      public function getActiveHair() : ICloth
      {
         var _loc1_:ICloth = null;
         var _loc4_:ICloth = null;
         var _loc5_:int = 0;
         var _loc2_:Cloth = null;
         var _loc3_:Array = Sanalika.instance.clothModel.allClothes;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_ = Cloth(_loc3_[_loc5_]);
            if(_loc2_.placeBit == ClothType.BIT17_HAIR)
            {
               if(_loc2_.base)
               {
                  _loc1_ = _loc2_;
               }
               else
               {
                  _loc4_ = _loc2_;
               }
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            return _loc4_;
         }
         return _loc1_;
      }
      
      public function getHairName() : String
      {
         return getActiveHair().key;
      }
      
      public function addClothByName(param1:String) : void
      {
         var _loc3_:ClothData = Sanalika.instance.itemModel.getCloth(sex + "_" + param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Cloth = new Cloth(0,1,false,false,sex + "_" + param1,-1,-1);
         addCloth(_loc2_);
      }
      
      public function removeClothByName(param1:String) : void
      {
         var _loc3_:Cloth4Preview = null;
         var _loc5_:int = 0;
         var _loc6_:ClothData = Sanalika.instance.itemModel.getCloth(sex + "_" + param1);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc2_:String = sex + "_" + param1;
         var _loc4_:int = int(activeClothes.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = Cloth4Preview(activeClothes[_loc5_]);
            if(_loc3_.cloth.key == _loc2_)
            {
               activeClothes.splice(_loc5_,1);
               check4MinCloths();
               calcActiveBitStats();
               clearAndDraw();
               break;
            }
            _loc5_++;
         }
      }
      
      public function addCloth(param1:ICloth) : void
      {
         if(param1.placeBit == ClothType.BIT22_HANDITEM)
         {
            if((activePlacement & ClothType.BIT22_HANDITEM) > 0)
            {
               if(activeClothPlacement[param1.placeBit] == null)
               {
                  removeCloths4Bit(param1.placeBit);
                  activeClothes.push(new Cloth4Preview(param1));
                  check4MinCloths();
               }
               else
               {
                  removeCloths4Bit(param1.placeBit);
                  activeClothes.push(new Cloth4Preview(param1));
               }
            }
            else
            {
               activeClothes.push(new Cloth4Preview(param1));
            }
            if(ItemType.isHandVisibleIdle(param1.infoInventoryItem.itemType))
            {
               hold = "k";
            }
         }
         else
         {
            removeCloths4Bit(param1.placeBit);
            activeClothes.push(new Cloth4Preview(param1));
            check4MinCloths();
         }
         calcActiveBitStats();
         clearAndDraw();
      }
      
      public function removeCloth(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Cloth4Preview = null;
         _loc3_ = 0;
         while(_loc3_ < activeClothes.length)
         {
            _loc2_ = Cloth4Preview(activeClothes[_loc3_]);
            if(_loc2_.cloth.getPreviewID() == param1)
            {
               activeClothes.splice(_loc3_,1);
               _loc2_.dispose();
               break;
            }
            _loc3_++;
         }
         check4MinCloths();
         calcActiveBitStats();
         clearAndDraw();
      }
      
      private function removeCloths4Bit(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Cloth4Preview = null;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < activeClothes.length)
         {
            _loc2_ = Cloth4Preview(activeClothes[_loc4_]);
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.cloth.placeBit;
               if((_loc3_ & param1) != 0)
               {
                  if(_loc3_ == ClothType.BIT22_HANDITEM)
                  {
                     hold = "";
                  }
                  _loc2_.dispose();
                  activeClothes.splice(_loc4_,1);
                  _loc4_--;
               }
            }
            _loc4_++;
         }
      }
      
      private function check4MinCloths() : void
      {
         var _loc3_:Cloth4Preview = null;
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         calcActiveBitStats();
         if(allClothes)
         {
            _loc1_ = allClothes;
         }
         else
         {
            _loc1_ = defaultClothes;
         }
         var _loc2_:Array = [ClothType.BIT00_BODY_BOTTOM,ClothType.BIT01_BODY_MIDDLE,ClothType.BIT02_BODY_TOP,ClothType.BIT04_FOOT,ClothType.BIT06_LEG_TOP,ClothType.BIT09_SHIRT];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if((activePlacement & _loc2_[_loc4_]) == 0)
            {
               _loc3_ = getCloth4Bit(_loc1_,_loc2_[_loc4_]);
               if(_loc3_ != null)
               {
                  activeClothes.push(_loc3_);
               }
            }
            _loc4_++;
         }
         if((activePlacement & ClothType.BIT17_HAIR) == 0)
         {
            _loc3_ = getCloth4Bit(_loc1_,ClothType.BIT17_HAIR,false);
            if(_loc3_ != null)
            {
               activeClothes.push(_loc3_);
            }
            else
            {
               _loc3_ = getCloth4Bit(_loc1_,ClothType.BIT17_HAIR,true);
               if(_loc3_ != null)
               {
                  activeClothes.push(_loc3_);
               }
            }
         }
      }
      
      private function getCloth4Bit(param1:Array, param2:int, param3:Boolean = true) : Cloth4Preview
      {
         var _loc6_:int = 0;
         var _loc5_:Cloth = null;
         var _loc4_:Cloth4Preview = null;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = param1[_loc6_];
            if(_loc5_.placeBit == param2)
            {
               _loc4_ = new Cloth4Preview(_loc5_);
               break;
            }
            _loc6_++;
         }
         if(_loc4_ == null)
         {
            trace("Fatal Err : getCloth4Bit(" + param2 + ")");
         }
         return _loc4_;
      }
      
      public function isActiveOnThePreview(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:Cloth4Preview = null;
         var _loc2_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < activeClothes.length)
         {
            _loc3_ = activeClothes[_loc4_];
            if(_loc3_.cloth.getPreviewID() == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function rotate(param1:int) : void
      {
         setStatus(hold,status,param1);
      }
      
      public function rotateLeft() : void
      {
         var _loc1_:int = this.direction;
         if(++_loc1_ > 8)
         {
            _loc1_ = 1;
         }
         setStatus(hold,status,_loc1_);
      }
      
      public function rotateRight() : void
      {
         var _loc1_:int = this.direction;
         if(--_loc1_ < 1)
         {
            _loc1_ = 8;
         }
         setStatus(hold,status,_loc1_);
      }
      
      public function setStatus(param1:String, param2:String, param3:int) : void
      {
         if(param1 == null || param2 == null || param3 < 1 || param3 > 8)
         {
            return;
         }
         if(param1 == "k")
         {
            if(!(param2 == "w" || param2 == "i"))
            {
               if(param2 != "s")
               {
                  return;
               }
               if(param3 == 2 || param3 == 4 || param3 == 6)
               {
                  return;
               }
            }
         }
         else
         {
            if(param1 != "")
            {
               return;
            }
            if(!(param2 == "w" || param2 == "i"))
            {
               if(param2 == "s")
               {
                  if(param3 == 2 || param3 == 4 || param3 == 6)
                  {
                     return;
                  }
               }
               else
               {
                  if(!(param2 == "d" || param2 == "x" || param2 == "a1"))
                  {
                     return;
                  }
                  if(param3 != 3 && param3 != 5)
                  {
                     return;
                  }
               }
            }
         }
         this.hold = param1;
         this.status = param2;
         this.direction = param3;
         updateCharStatus();
      }
      
      private function updateCharStatus() : void
      {
         var _loc1_:int = 0;
         if(loadingAnimation != null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < container.numChildren)
         {
            updateMcStatus(MovieClip(container.getChildAt(_loc1_)));
            _loc1_++;
         }
         if(char)
         {
            if(char.height == -120)
            {
               container.y = 100;
            }
         }
      }
      
      private function updateMcStatus(param1:MovieClip) : void
      {
         var _loc5_:Boolean = false;
         var _loc4_:String = hold;
         var _loc3_:String = status;
         var _loc2_:Cloth = param1.cloth4Preview.cloth;
         while(!_loc5_)
         {
            if(_loc4_ == "k")
            {
               if(_loc3_ == "w")
               {
                  if((_loc2_.states & 8) == 0)
                  {
                     _loc4_ = "";
                  }
                  else
                  {
                     _loc5_ = true;
                  }
               }
               else if(_loc3_ == "i")
               {
                  if((_loc2_.states & 0x10) == 0)
                  {
                     _loc4_ = "";
                  }
                  else
                  {
                     _loc5_ = true;
                  }
               }
               else if((_loc2_.states & 0x20) == 0)
               {
                  _loc4_ = "";
               }
               else
               {
                  _loc5_ = true;
               }
            }
            else if(_loc3_ == "w")
            {
               if((_loc2_.states & 1) == 0)
               {
                  _loc3_ = "i";
               }
               else
               {
                  _loc5_ = true;
               }
            }
            else if(_loc3_ == "s")
            {
               if((_loc2_.states & 4) == 0)
               {
                  _loc3_ = "i";
               }
               else
               {
                  _loc5_ = true;
               }
            }
            else if(_loc3_ == "d")
            {
               if((_loc2_.states & 0x40) == 0)
               {
                  _loc3_ = "i";
               }
               else
               {
                  _loc5_ = true;
               }
            }
            else if(_loc3_ == "a1")
            {
               if((_loc2_.states & 0x0100) == 0)
               {
                  _loc3_ = "i";
               }
               else
               {
                  _loc5_ = true;
               }
            }
            else if(_loc3_ == "x")
            {
               if((_loc2_.states & 0x80) == 0)
               {
                  _loc3_ = "i";
               }
               else
               {
                  _loc5_ = true;
               }
            }
            else
            {
               _loc5_ = true;
            }
         }
         try
         {
            param1.gotoAndStop(_loc4_ + _loc3_ + direction);
         }
         catch(e:Error)
         {
            try
            {
               param1.gotoAndStop(_loc4_ + "gi" + direction);
            }
            catch(e:Error)
            {
               trace("clothFrameError");
            }
         }
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function set scale(param1:Number) : void
      {
         if(_scale == param1)
         {
            return;
         }
         _scale = param1;
         container.scaleX = container.scaleY = param1;
      }
      
      private function removeAllChilds() : void
      {
         while(container.numChildren > 0)
         {
            container.removeChildAt(0);
         }
      }
      
      private function clearAndDraw() : void
      {
         var _loc7_:int = 0;
         var _loc3_:Cloth4Preview = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:Boolean = true;
         _loc7_ = 0;
         while(_loc7_ < activeClothes.length)
         {
            _loc3_ = activeClothes[_loc7_];
            if(_loc3_.cloth.placeBit == ClothType.BIT17_HAIR)
            {
               _loc2_ = _loc3_;
            }
            if(_loc3_.cloth.placeBit == ClothType.BIT20_HAT)
            {
               _loc4_ = _loc3_;
            }
            if(!_loc3_.isInited)
            {
               _loc6_ = false;
            }
            _loc7_++;
         }
         if(_loc4_ && _loc2_)
         {
            _loc2_.setTempKey(sex + "_84_" + _loc2_.cloth.color);
            if(!_loc2_.isInited)
            {
               _loc6_ = false;
            }
         }
         else if(_loc4_ == null && _loc2_)
         {
            if(_loc2_.tempKey != null)
            {
               _loc2_.setTempKey(null);
               if(!_loc2_.isInited)
               {
                  _loc6_ = false;
               }
            }
         }
         if(_loc6_)
         {
            hideLoadingAnimation();
            removeAllChilds();
            _loc7_ = 0;
            while(_loc7_ < activeClothes.length)
            {
               (activeClothes[_loc7_] as Cloth4Preview).resetPlaceBitIndex();
               _loc7_++;
            }
            while(true)
            {
               _loc1_ = 100;
               _loc5_ = -1;
               _loc7_ = 0;
               while(_loc7_ < activeClothes.length)
               {
                  if(Cloth4Preview(activeClothes[_loc7_]).placeBitIndex < _loc1_)
                  {
                     _loc1_ = int(Cloth4Preview(activeClothes[_loc7_]).placeBitIndex);
                     _loc5_ = _loc7_;
                  }
                  _loc7_++;
               }
               if(_loc1_ == 100)
               {
                  break;
               }
               _loc3_ = Cloth4Preview(activeClothes[_loc5_]);
               _loc3_.mc.cloth4Preview = _loc3_;
               try
               {
                  _loc3_.mc.gotoAndStop("i" + direction);
               }
               catch(e:Error)
               {
               }
               if(!(hideEffects && Sanalika.instance.clothModel.isMemberOfEffectCategory(_loc3_.cloth.placeBit)))
               {
                  container.addChild(_loc3_.mc);
               }
               _loc3_.placeBitIndex = 100;
            }
            updateCharStatus();
            return;
         }
         showLoadingAnimation();
      }
      
      public function getDiff() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Cloth4Preview = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < activeClothes.length)
         {
            _loc2_ = Cloth4Preview(activeClothes[_loc3_]);
            if(_loc2_.cloth.getPreviewID() == 0)
            {
               _loc1_.push(_loc2_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function terminate() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Cloth4Preview = null;
         Sanalika.instance.itemModel.removeItemListener(packEventFunction);
         if(container)
         {
            removeAllChilds();
         }
         container = null;
         _loc2_ = 0;
         while(_loc2_ < activeClothes.length)
         {
            _loc1_ = Cloth4Preview(activeClothes[_loc2_]);
            _loc1_.dispose();
            _loc2_++;
         }
         defaultClothes = null;
         allClothes = null;
         char = null;
         isTerminated = true;
         CharPreviewManager.remove(this);
      }
   }
}

