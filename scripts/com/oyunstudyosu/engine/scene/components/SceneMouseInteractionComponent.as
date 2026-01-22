package com.oyunstudyosu.engine.scene.components
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.bot.IBotVO;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.CellType;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.engine.pool.model.GamePoolModel;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.ProfileEvent;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.utils.CollideUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.System;
   import flash.ui.Mouse;
   import mx.logging.LogEvent;
   
   public class SceneMouseInteractionComponent extends BaseSceneComponent
   {
      
      public function SceneMouseInteractionComponent(param1:IScene)
      {
         super(param1);
      }
      
      override public function enable() : void
      {
         disable();
         stage.addEventListener("mouseMove",onMouseMove,false,2,true);
         scene.container.addEventListener("rollOut",onMouseOut);
         scene.container.addEventListener("click",mouseClicked);
      }
      
      override public function disable() : void
      {
         stage.removeEventListener("mouseMove",onMouseMove);
         scene.container.removeEventListener("rollOut",onMouseOut);
         scene.container.removeEventListener("click",mouseClicked);
      }
      
      public function mouseClicked(param1:MouseEvent) : void
      {
         var _loc6_:IBotVO = null;
         var _loc2_:MovieClip = null;
         var _loc11_:ProfileEvent = null;
         var _loc4_:Cell = null;
         var _loc8_:String = null;
         var _loc5_:AlertVo = null;
         var _loc13_:AlertVo = null;
         var _loc3_:SceneCharacterComponent = scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc12_:ISceneCameraComponent = scene.getComponent(ISceneCameraComponent) as ISceneCameraComponent;
         if(_loc12_ != null && _loc12_.dragVo.isActive)
         {
            return;
         }
         if(!scene.mouseEnabled || _loc3_ == null || _loc3_.myChar == null)
         {
            return;
         }
         var _loc14_:SceneBotComponent = scene.getComponent(SceneBotComponent) as SceneBotComponent;
         if(_loc14_ != null)
         {
            for each(var _loc9_ in _loc14_.botList)
            {
               _loc6_ = Sanalika.instance.roomModel.botModel.getBotByKey(_loc9_.definition);
               if(_loc9_.clip.hitTestPoint(param1.stageX,param1.stageY,true))
               {
                  _loc2_ = _loc9_.clip.getChildAt(0) as MovieClip;
                  if(CollideUtils.isColliding(_loc2_,param1.stageX,param1.stageY))
                  {
                     if(param1.ctrlKey)
                     {
                        Dispatcher.dispatchEvent(new LogEvent("bot.name: " + _loc9_.definition + " bot.id: " + _loc9_.id));
                     }
                     else
                     {
                        trace(["bot: " + _loc6_.nick]);
                        Sanalika.instance.roomModel.botModel.runBotByKey(_loc6_.metaKey);
                     }
                     return;
                  }
               }
            }
         }
         for each(var _loc10_ in Sanalika.instance.entryModel.entryItems)
         {
            if(_loc10_.clip.hitTestPoint(param1.stageX,param1.stageY,true))
            {
               if(CollideUtils.isColliding(_loc10_.clip,param1.stageX,param1.stageY))
               {
                  trace("entryModel.executeItem",_loc10_.id);
                  Sanalika.instance.entryModel.executeItem(_loc10_.id);
                  return;
               }
            }
         }
         if(_loc3_ != null)
         {
            for each(var _loc7_ in _loc3_.characterList)
            {
               if(!_loc7_.hide)
               {
                  if(_loc7_.container.hitTestPoint(param1.stageX,param1.stageY,true))
                  {
                     if(CollideUtils.isColliding(_loc7_.container,param1.stageX,param1.stageY))
                     {
                        if(_loc7_.status != "gm" && !_loc7_.isNPC)
                        {
                           if(_loc12_ != null && _loc12_.dragVo.timeoutEnabled)
                           {
                              trace("Swipping, character click disabled!");
                              return;
                           }
                           if(param1.ctrlKey)
                           {
                              System.setClipboard(_loc7_.id);
                              Sanalika.instance.localConnectionModel.send("avatar",{"id":_loc7_.id});
                           }
                           else
                           {
                              _loc11_ = new ProfileEvent("AvatarProfileEvent.SHOW_PROFILE");
                              _loc11_.avatarID = _loc7_.id;
                              Dispatcher.dispatchEvent(_loc11_);
                           }
                        }
                        return;
                     }
                  }
               }
            }
            scene.activeGrid = scene.translateToGrid(scene.mouseX,scene.mouseY);
            _loc4_ = scene.getCellAt(scene.activeGrid.x,0,scene.activeGrid.y);
            if(_loc12_ != null && _loc12_.dragVo.timeoutEnabled)
            {
               trace("Swipping, walk disabled!");
               return;
            }
            if(_loc4_ != null)
            {
               trace("getCell:" + _loc4_.isWalkable(_loc3_.myChar));
               trace("isReachable: " + _loc3_.myChar.reachable(scene.activeGrid.x,scene.activeGrid.y));
            }
            if(param1.ctrlKey)
            {
               Dispatcher.dispatchEvent(new LogEvent(scene.activeGrid.x + " " + scene.activeGrid.y));
               System.setClipboard(scene.activeGrid.x + " " + scene.activeGrid.y);
            }
            else
            {
               if(_loc4_ != null && _loc4_.parentMapEntry != null && _loc4_.parentMapEntry.gameZoneId != "")
               {
                  _loc8_ = _loc4_.parentMapEntry.gameZoneId;
                  if(_loc8_ == "iceRink")
                  {
                     if(!GamePoolModel.canskateByCloth())
                     {
                        _loc5_ = new AlertVo();
                        _loc5_.alertType = "Info";
                        _loc5_.description = Sanalika.instance.localizationModel.translate("requiredIceScateCloth");
                        Dispatcher.dispatchEvent(new AlertEvent(_loc5_));
                        return;
                     }
                  }
                  else if(_loc8_ == "swimPool")
                  {
                     if(!GamePoolModel.canSwimByCloth())
                     {
                        _loc13_ = new AlertVo();
                        _loc13_.alertType = "Info";
                        _loc13_.description = Sanalika.instance.localizationModel.translate("requiredSwimCloth");
                        Dispatcher.dispatchEvent(new AlertEvent(_loc13_));
                        return;
                     }
                  }
               }
               _loc3_.myChar.walkRequest(scene.activeGrid.x,scene.activeGrid.y);
            }
         }
      }
      
      public function onMouseMove(param1:MouseEvent) : void
      {
         var _loc10_:IBotVO = null;
         var _loc9_:SceneBotComponent = null;
         var _loc3_:MovieClip = null;
         var _loc4_:SceneCharacterComponent = scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(!scene.mouseEnabled || _loc4_ == null || _loc4_.myChar == null)
         {
            return;
         }
         var _loc8_:SceneDoorComponent = scene.getComponent(SceneDoorComponent) as SceneDoorComponent;
         if(_loc8_ != null && !_loc8_.isOnDoor)
         {
            for each(var _loc7_ in Sanalika.instance.entryModel.entryItems)
            {
               if(_loc7_.clip.hitTestPoint(param1.stageX,param1.stageY,true))
               {
                  if(CollideUtils.isColliding(_loc7_.clip,param1.stageX,param1.stageY))
                  {
                     if(!_loc7_.isBusy)
                     {
                        _loc7_.over();
                        return;
                     }
                  }
               }
               else if(_loc7_.isBusy)
               {
                  _loc7_.out();
               }
            }
            _loc9_ = scene.getComponent(SceneBotComponent) as SceneBotComponent;
            if(_loc9_ != null)
            {
               for each(var _loc5_ in _loc9_.botList)
               {
                  _loc10_ = Sanalika.instance.roomModel.botModel.getBotByKey(_loc5_.definition);
                  if(_loc10_ && !_loc10_.isStatic && _loc5_.clip.visible == true && _loc5_.clip.hitTestPoint(param1.stageX,param1.stageY,true) && !Sanalika.instance.layerModel.panelLayer.hitTestPoint(param1.stageX,param1.stageY,true))
                  {
                     _loc3_ = _loc5_.clip.getChildAt(0) as MovieClip;
                     if(CollideUtils.isColliding(_loc3_,param1.stageX,param1.stageY) && _loc10_.property)
                     {
                        try
                        {
                           Mouse.cursor = "interaction";
                        }
                        catch(e:Error)
                        {
                           trace(e.message);
                        }
                        return;
                     }
                  }
                  else
                  {
                     Mouse.cursor = "auto";
                  }
               }
            }
         }
         scene.activeGrid = scene.translateToGrid(scene.mouseX,scene.mouseY);
         if(scene.activeGrid.x < 0 || scene.activeGrid.x >= scene.columnsCount || scene.activeGrid.y < 0 || scene.activeGrid.y >= scene.rowsCount)
         {
            scene.arrow.visible = false;
            scene.cursor.visible = false;
            scene.activeGrid = new IntPoint(0,0);
            return;
         }
         var _loc2_:Point = scene.getPosFromGrid(scene.activeGrid.x,scene.activeGrid.y);
         var _loc6_:Cell = scene.getCellAt(scene.activeGrid.x,0,scene.activeGrid.y);
         Dispatcher.dispatchEvent(new GameEvent("ACTIVE_GRID_CHANGED"));
         if(_loc6_ != null && !_loc6_.isWalkable(_loc4_.myChar))
         {
            if(_loc6_ != null && _loc6_.objectType != 0 && _loc6_.objectType != 6 && !_loc6_.isObjectInUse)
            {
               scene.arrow.x = _loc2_.x;
               scene.arrow.y = _loc2_.y - _loc6_.parentMapEntry.heighInPx - 10;
               scene.arrow.visible = true;
               scene.cursor.visible = false;
            }
            else
            {
               scene.arrow.visible = false;
               scene.cursor.visible = false;
            }
         }
         else if(_loc6_.isSelectable(_loc4_.myChar))
         {
            scene.arrow.visible = false;
            scene.cursor.visible = true;
            TweenMax.to(scene.cursor,0,{
               "glowFilter":{
                  "color":9561600,
                  "alpha":0,
                  "blurX":0,
                  "blurY":0
               },
               "scaleX":1,
               "scaleY":1
            });
            if(_loc6_.cellType == CellType.TYPE_SANALIKAX)
            {
               TweenMax.to(scene.cursor,0.3,{
                  "glowFilter":{
                     "color":2201331,
                     "alpha":1,
                     "blurX":15,
                     "blurY":15,
                     "strength":3
                  },
                  "repeat":2,
                  "yoyo":true
               });
            }
            if(_loc6_.cellType == CellType.TYPE_ADMIN)
            {
               TweenMax.to(scene.cursor,0.3,{
                  "glowFilter":{
                     "color":16711680,
                     "alpha":1,
                     "blurX":15,
                     "blurY":15,
                     "strength":3
                  },
                  "repeat":2,
                  "yoyo":true
               });
            }
            if(_loc6_.cellType == CellType.TYPE_DIAMOND)
            {
               TweenMax.to(scene.cursor,0.3,{
                  "glowFilter":{
                     "color":9159498,
                     "alpha":1,
                     "blurX":15,
                     "blurY":15,
                     "strength":3
                  },
                  "repeat":2,
                  "yoyo":true
               });
            }
         }
         else
         {
            scene.arrow.visible = false;
            scene.cursor.visible = false;
         }
         scene.cursor.x = _loc2_.x;
         scene.cursor.y = _loc2_.y;
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      override public function dispose() : void
      {
         disable();
         isDisposed = true;
      }
   }
}

