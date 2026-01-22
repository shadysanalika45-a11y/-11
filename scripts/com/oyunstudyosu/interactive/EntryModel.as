package com.oyunstudyosu.interactive
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.utils.Logger;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.Coin;
   import org.oyunstudyosu.assets.clips.DiamondR;
   
   public class EntryModel implements IEntryModel
   {
      
      private var _entryItems:Dictionary;
      
      private var vo:IEntryVo;
      
      public function EntryModel()
      {
         super();
         Dispatcher.addEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.addEventListener("TERMINATE_SCENE",onTerminateGame);
      }
      
      public function get entryItems() : Dictionary
      {
         return _entryItems;
      }
      
      private function onTerminateGame(param1:GameEvent) : void
      {
         dispose();
      }
      
      public function getObjectById(param1:String) : IEntryVo
      {
         trace("getObjectById",param1);
         return entryItems[param1];
      }
      
      public function removeObjectById(param1:String) : void
      {
         delete entryItems[param1];
      }
      
      public function loadJSON(param1:String, param2:Object) : void
      {
         var _loc3_:Object = JSON.parse(param1);
         trace("Evalue",param1);
         trace("entryData",param2);
         load(_loc3_,param2);
      }
      
      private function load(param1:Object, param2:Object) : void
      {
         var _loc6_:Coin = null;
         var _loc7_:DiamondR = null;
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_entryItems == null)
         {
            _entryItems = new Dictionary();
         }
         vo = entryItems[param1.metaKey];
         if(vo == null)
         {
            vo = new EntryVo();
         }
         vo.clip = param2.clip;
         vo.definition = param2.definition;
         vo.x = param2.x;
         vo.y = param2.y;
         vo.z = param2.z;
         vo.f = param2.f;
         vo.s = param2.s;
         vo.fx = param2.fx;
         vo.lc = param2.lc;
         vo.st = param2.st;
         vo.sv = param2.sv;
         vo.width = param2.width;
         vo.height = param2.height;
         vo.depth = param2.depth;
         vo.id = param2.id;
         if(param1.property)
         {
            vo.setProperty(param1.property);
         }
         entryItems[vo.id] = vo;
         entryItems[vo.id].gotoFrame(vo.f);
         if(param2.lc > 0)
         {
            entryItems[vo.id].addLock();
         }
         if(param2.s == 1)
         {
            _loc6_ = new Coin();
            _loc6_.y = -80;
            _loc6_.x = 0;
            _loc6_.name = "coin";
            _loc6_.buttonMode = true;
            entryItems[vo.id].clip.addChild(_loc6_);
         }
         if(param2.s == 2)
         {
            _loc7_ = new DiamondR();
            ortala(vo.width,vo.depth,vo.height,_loc7_);
            _loc7_.name = "coin";
            _loc7_.buttonMode = true;
            entryItems[vo.id].clip.addChild(_loc7_);
         }
         if(param2.st > 0)
         {
            if(param1.property.type)
            {
               entryItems[vo.id].addIndicator();
            }
         }
         if(param1.property.cn == "FarmProperty")
         {
            if(param1.property.item)
            {
               entryItems[vo.id].gotoFrameLabel(param1.property.item.clip + "" + param1.property.status.state);
            }
         }
         if(param1.property.cn == "GridSealingProperty")
         {
            if(vo.f == 2)
            {
               _loc5_ = true;
            }
            else
            {
               _loc5_ = false;
            }
            _loc4_ = 0;
            while(_loc4_ < vo.height)
            {
               _loc3_ = 0;
               while(_loc3_ < vo.width)
               {
                  Sanalika.instance.engine.scene.setCellStatus(vo.x + _loc3_,vo.z + _loc4_,_loc5_);
                  _loc3_++;
               }
               _loc4_++;
            }
         }
      }
      
      public function ortala(param1:int, param2:int, param3:int, param4:MovieClip) : *
      {
         if(param1 > param2)
         {
            param4.x = (-param2 * 10 + param1 * 10) / 2;
            param4.y = -param1 * 10 + param3;
         }
         else
         {
            trace("w",param1);
            param4.x = (-param2 * 14 + param1 * 14) / 2;
            param4.y = -param2 * 10 + param3;
         }
      }
      
      public function executeItem(param1:int) : void
      {
         var _loc2_:IEntryVo = entryItems[param1];
         if(_loc2_ == null)
         {
            return;
         }
         try
         {
            _loc2_.property.execute(param1.toString());
         }
         catch(error:Error)
         {
            Logger.log("Item property execute error. " + error.getStackTrace(),true);
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _entryItems)
         {
            _loc1_.dispose();
            delete entryItems[_loc1_.id];
         }
         _entryItems = null;
      }
   }
}

