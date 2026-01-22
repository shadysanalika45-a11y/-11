package com.oyunstudyosu.engine.pool.manager
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.pool.chars.IceSkateItem;
   import com.oyunstudyosu.engine.pool.chars.PoolItem;
   import com.oyunstudyosu.engine.pool.chars.SwimmingPoolItem;
   import com.smartfoxserver.v2.entities.variables.UserVariable;
   
   public class GamePoolManager
   {
      
      public function GamePoolManager()
      {
         super();
      }
      
      public function addItem(param1:GamePool, param2:ICharacter, param3:IScene) : void
      {
         var _loc7_:PoolItem = null;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:String = null;
         var _loc9_:UserVariable = null;
         var _loc4_:String = null;
         var _loc6_:Array = null;
         if(!containsItem(param1,param2.id))
         {
            _loc8_ = int(param2.direction == 3 || param2.direction == 7 ? param1.poolDepth : -1);
            _loc10_ = int(param2.direction == 1 || param2.direction == 5 ? param1.poolDepth : -1);
            switch(param1.gameType - 1)
            {
               case 0:
                  _loc7_ = new SwimmingPoolItem(param3,param2,-(param1.location.x - param2.last_x + _loc8_),-(param1.location.y - param2.last_y + _loc10_));
                  break;
               case 1:
                  _loc7_ = new IceSkateItem(param3,param2,-(param1.location.x - param2.last_x + _loc8_),-(param1.location.y - param2.last_y + _loc10_));
            }
            param1.gameusers.push(_loc7_);
            param1.addChild(_loc7_);
            if(param2.isMe)
            {
               _loc5_ = _loc7_.pool.name + "," + "init" + ",pool," + _loc7_.coordinates + "," + _loc7_.bodyclip;
               Sanalika.instance.serviceModel.setUserVariable(["poolVars"],[_loc5_]);
            }
         }
         else
         {
            _loc9_ = Sanalika.instance.serviceModel.getVariableByUserId("poolVars",param2.id);
            if(_loc9_ == null)
            {
               return;
            }
            _loc4_ = _loc9_.getStringValue();
            _loc6_ = _loc4_.split(",");
            if(_loc4_ != null)
            {
               _loc7_ = getItemByName(param1,param2.id);
               _loc7_.bodyclip = _loc6_[9];
               _loc7_.updateBody();
               _loc7_.initialize(_loc4_);
            }
         }
      }
      
      public function containsItem(param1:GamePool, param2:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if((param1.getChildAt(_loc4_) as PoolItem).character.id == param2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function getItemByName(param1:GamePool, param2:String) : PoolItem
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if((param1.getChildAt(_loc4_) as PoolItem).character.id == param2)
            {
               return param1.getChildAt(_loc4_) as PoolItem;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function removeItem(param1:GamePool, param2:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if((param1.getChildAt(_loc4_) as PoolItem).character.id == param2)
            {
               (param1.getChildAt(_loc4_) as PoolItem).kill();
               param1.gameusers.splice(_loc4_,1);
               return;
            }
            _loc4_++;
         }
      }
      
      public function killAll(param1:GamePool) : void
      {
         while(param1.numChildren > 0)
         {
            (param1.getChildAt(0) as PoolItem).kill();
         }
         param1.gameusers.length = 0;
      }
      
      public function updateItem(param1:GamePool, param2:String, param3:String) : void
      {
         var _loc4_:PoolItem = getItemByName(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.update(param3);
         }
         depthSort(param1);
      }
      
      public function depthSort(param1:GamePool) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.gameusers.length);
         param1.gameusers.sort(orderY);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            param1.setChildIndex(param1.gameusers[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      protected function orderY(param1:PoolItem, param2:PoolItem) : int
      {
         if(param1.y < param2.y)
         {
            return -1;
         }
         if(param1.y > param2.y)
         {
            return 1;
         }
         return 0;
      }
   }
}

