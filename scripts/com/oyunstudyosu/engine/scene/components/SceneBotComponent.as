package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.bot.IBotVO;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.core.BotEntry;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.CellType;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.Vector3d;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechable;
   import flash.display.MovieClip;
   
   public class SceneBotComponent extends BaseSceneComponent
   {
      
      public var botList:Array;
      
      public function SceneBotComponent(param1:IScene)
      {
         super(param1);
         botList = [];
      }
      
      public function processBotsForEntry() : void
      {
         var _loc3_:IBotVO = null;
         var _loc1_:Array = Sanalika.instance.roomModel.botModel.keyList;
         for each(var _loc2_ in _loc1_)
         {
            _loc3_ = Sanalika.instance.roomModel.botModel.getBotByKey(_loc2_);
            addBot(_loc3_);
         }
      }
      
      public function addBotSoon(param1:IBotVO) : ISpeechable
      {
         var _loc2_:ISpeechable = addBot(param1);
         sceneElementsMove();
         return _loc2_;
      }
      
      public function addBot(param1:IBotVO) : ISpeechable
      {
         if(param1 == null || param1.x > Sanalika.instance.roomModel.gridModel.width || param1.y > Sanalika.instance.roomModel.gridModel.height)
         {
            return null;
         }
         trace("addBot",param1);
         var _loc3_:BotEntry = new BotEntry();
         _loc3_.x = param1.x;
         _loc3_.z = param1.y;
         _loc3_.width = param1.width;
         _loc3_.depth = param1.height;
         _loc3_.height = param1.length;
         _loc3_.definition = param1.definition;
         _loc3_.id = param1.metaKey;
         _loc3_.name = param1.nick;
         _loc3_.version = param1.version;
         var _loc4_:MovieClip = new MovieClip();
         var _loc2_:IsoElement = new IsoElement();
         _loc2_.create(null,_loc4_,scene);
         _loc2_.id = _loc3_.definition;
         _loc2_.currentTile = new IntPoint(_loc3_.x,_loc3_.z);
         _loc3_.element = _loc2_;
         _loc3_.clip = _loc4_;
         scene.sceneElements.push(_loc2_);
         scene.mapEntries.push(_loc3_);
         botList.push(_loc3_);
         _loc3_.init(scene);
         scene.elementsContainer.addChild(_loc4_);
         return _loc3_;
      }
      
      public function clearBots() : void
      {
         var _loc2_:Cell = null;
         var _loc6_:IBotVO = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = Sanalika.instance.roomModel.botModel.keyList;
         for(var _loc1_ in _loc3_)
         {
            _loc6_ = Sanalika.instance.roomModel.botModel.getBotByKey(_loc1_);
            if(_loc6_ != null)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc6_.width)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.height)
                  {
                     _loc2_ = scene.getCellAt(_loc6_.x + _loc5_,0,_loc6_.y + _loc4_);
                     if(_loc2_ != null)
                     {
                        _loc2_.cellType = CellType.TYPE_EMPTY;
                     }
                     _loc4_++;
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      public function getBotByName(param1:String) : BotEntry
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < botList.length)
         {
            if(botList[_loc2_].id == param1)
            {
               return botList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function sceneElementsMove() : void
      {
         var _loc1_:Vector3d = null;
         var _loc4_:IsoElement = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(scene.sceneElements.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = scene.sceneElements[_loc3_];
            _loc1_ = scene.getScenePositionFromTile(_loc4_.currentTile.x,_loc4_.currentTile.y);
            _loc4_.moveTo(_loc1_.x,_loc1_.y,_loc1_.z);
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         isDisposed = true;
      }
   }
}

