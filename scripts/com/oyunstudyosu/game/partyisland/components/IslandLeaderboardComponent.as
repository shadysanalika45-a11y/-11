package com.oyunstudyosu.game.partyisland.components
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.path.AStar;
   import com.oyunstudyosu.engine.scene.components.BaseSceneComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.game.partyisland.AvatarCircle;
   import org.oyunstudyosu.game.partyisland.ProgressBar;
   
   public class IslandLeaderboardComponent extends BaseSceneComponent implements IIslandLeaderboardComponent
   {
      
      public var progressBar:ProgressBar;
      
      public var poolValues:Array = [0,0,0,0];
      
      private var _orderedItems:Array = [];
      
      public function IslandLeaderboardComponent(param1:IScene)
      {
         super(param1);
         Dispatcher.addEventListener("SCENE_LOADED",sceneLoaded);
      }
      
      public function get orderedItems() : Array
      {
         return _orderedItems;
      }
      
      public function set orderedItems(param1:Array) : void
      {
         _orderedItems = param1;
      }
      
      public function sceneLoaded(param1:GameEvent) : void
      {
         var _loc2_:IslandSceneHudComponent = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
         progressBar = _loc2_.progressBar;
      }
      
      public function add(param1:PartyPlayerVo) : void
      {
         var _loc2_:AvatarCircle = new AvatarCircle();
         _loc2_.init(param1);
         _loc2_.name = "character_" + param1.character.id;
         progressBar.addChild(_loc2_);
      }
      
      public function remove(param1:PartyPlayerVo) : void
      {
         var _loc2_:AvatarCircle = progressBar.getChildByName("character_" + param1.character.id) as AvatarCircle;
         if(_loc2_ != null)
         {
            progressBar.removeChild(_loc2_);
         }
      }
      
      public function highlightTurn(param1:String) : void
      {
         var _loc5_:AvatarCircle = null;
         if(!scene.existsComponent(IslandPartyPlayerComponent))
         {
            return;
         }
         var _loc2_:IslandPartyPlayerComponent = scene.getComponent(IslandPartyPlayerComponent) as IslandPartyPlayerComponent;
         var _loc3_:Dictionary = _loc2_.items;
         for each(var _loc4_ in _loc3_)
         {
            _loc5_ = progressBar.getChildByName("character_" + _loc4_.character.id) as AvatarCircle;
            if(_loc5_ != null)
            {
               if(_loc4_.character.id == param1)
               {
                  _loc5_.filters = [new GlowFilter(16776960,1,10,10,1,1,false,false)];
                  progressBar.setChildIndex(_loc5_,progressBar.numChildren - 1);
               }
               else
               {
                  _loc5_.filters = [];
               }
            }
         }
      }
      
      public function update() : void
      {
         var islandServiceComponent:IslandServiceComponent;
         var star:AStar;
         var path:Vector.<IntPoint>;
         var islandPartyPlayerComponent:IslandPartyPlayerComponent;
         var items:Dictionary;
         var item:PartyPlayerVo;
         var finishedItems:Array;
         var finishedItem:PartyPlayerVo;
         var i:int;
         var currentX:int;
         var currentY:int;
         var pathArray:Array;
         var intPoint:IntPoint;
         var currentIntPoint:IntPoint;
         var currentIndex:int;
         var progress:Number;
         var avatarCircle:AvatarCircle;
         if(!scene.existsComponent(IslandPartyPlayerComponent) || !scene.existsComponent(IslandServiceComponent))
         {
            return;
         }
         islandServiceComponent = scene.getComponent(IslandServiceComponent) as IslandServiceComponent;
         if(islandServiceComponent.isGameEnded())
         {
            return;
         }
         star = new AStar(scene.grid,scene.columnsCount,scene.rowsCount,new IntPoint(islandServiceComponent.startPoint.x,islandServiceComponent.startPoint.y),new IntPoint(islandServiceComponent.finishPoint.x,islandServiceComponent.finishPoint.y),0);
         path = star.solve();
         if(path == null)
         {
            return;
         }
         path.reverse();
         islandPartyPlayerComponent = scene.getComponent(IslandPartyPlayerComponent) as IslandPartyPlayerComponent;
         items = islandPartyPlayerComponent.items;
         orderedItems = [];
         for each(item in items)
         {
            orderedItems.push(item);
         }
         finishedItems = orderedItems.filter(function(param1:PartyPlayerVo, param2:int, param3:Array):Boolean
         {
            return param1.finishedAt > 0;
         });
         finishedItems = finishedItems.sort(function(param1:PartyPlayerVo, param2:PartyPlayerVo):int
         {
            return Math.floor(param2.finishedAt - param1.finishedAt);
         });
         orderedItems = orderedItems.sort(function(param1:PartyPlayerVo, param2:PartyPlayerVo):int
         {
            return Math.floor(param1.progress - param2.progress);
         });
         orderedItems = orderedItems.sort(function(param1:PartyPlayerVo, param2:PartyPlayerVo):int
         {
            if(param1.progress == param2.progress)
            {
               if(param1.lastTurnAt > param2.lastTurnAt)
               {
                  return -1;
               }
               if(param1.lastTurnAt < param2.lastTurnAt)
               {
                  return 1;
               }
            }
            return 0;
         });
         for each(finishedItem in finishedItems)
         {
            orderedItems.remove(finishedItem);
            orderedItems.push(finishedItem);
         }
         orderedItems = orderedItems.reverse();
         i = 0;
         while(i < orderedItems.length)
         {
            item = orderedItems[i];
            item.poolBalance = poolValues[i];
            item.totalBalance = item.balance + item.poolBalance;
            if(item.character.cell != null)
            {
               currentX = item.character.cell.x;
               currentY = item.character.cell.y;
               pathArray = [];
               for each(intPoint in path)
               {
                  pathArray.push(intPoint);
               }
               currentIntPoint = pathArray.filter(function(param1:IntPoint, param2:int, param3:Array):Boolean
               {
                  return param1.x == currentX && param1.y == currentY;
               })[0];
               currentIndex = int(pathArray.indexOf(currentIntPoint));
               progress = currentIndex / pathArray.length * 720;
               if(progress != item.progress)
               {
                  item.progress = progress;
                  avatarCircle = progressBar.getChildByName("character_" + item.character.id) as AvatarCircle;
                  if(avatarCircle != null)
                  {
                     avatarCircle.visible = currentIndex != -1;
                     TweenLite.to(avatarCircle,0.3,{
                        "x":progress,
                        "ease":Quad.easeOut
                     });
                  }
               }
            }
            i = i + 1;
         }
      }
      
      override public function dispose() : void
      {
         Dispatcher.removeEventListener("SCENE_LOADED",sceneLoaded);
         isDisposed = true;
      }
   }
}

