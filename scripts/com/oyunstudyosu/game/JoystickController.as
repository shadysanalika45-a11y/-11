package com.oyunstudyosu.game
{
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.assets.clips.Joystick;
   
   public class JoystickController
   {
      
      private var _startX:Number = 0;
      
      private var _startY:Number = 0;
      
      private var _tension:Number = 0.5;
      
      private var _decay:Number = 0.7;
      
      private var _xSpeed:Number = 0;
      
      private var _isDragging:Boolean = false;
      
      private var _angle:int;
      
      private var _radius:int = 25;
      
      public var joystickM:MovieClip;
      
      public var joystick:MovieClip;
      
      public var mcPlayer:MovieClip;
      
      public function JoystickController()
      {
         super();
         Dispatcher.addEventListener("HudEvent.SHOW_JOYSTICK",init);
         Dispatcher.addEventListener("HudEvent.HIDE_JOYSTICK",dispose);
         Dispatcher.addEventListener("TERMINATE_GAME",disposeGame,true);
      }
      
      public function init(param1:HudEvent) : void
      {
         if(joystickM)
         {
            return;
         }
         trace("init Joystick");
         joystickM = new Joystick();
         Sanalika.instance.layerModel.hudLayer.addChild(joystickM);
         joystick = joystickM.joystick;
         mcPlayer = joystickM.mcPlayer;
         joystick.y = Sanalika.instance.gameModel.canvasHeight - 100;
         joystick.x = 100;
         _startX = joystick.x;
         _startY = joystick.y;
         joystick.addEventListener("mouseDown",on_mouseDown);
         joystick.addEventListener("mouseUp",on_mouseUp);
         joystick.addEventListener("mouseOut",on_mouseOut);
         Sanalika.instance.layerModel.stage.addEventListener("enterFrame",on_enterFrame);
         mcPlayer.x = Sanalika.instance.gameModel.canvasWidth / 2;
         mcPlayer.y = Sanalika.instance.gameModel.canvasHeight / 2;
      }
      
      protected function on_mouseDown(param1:MouseEvent) : void
      {
         _isDragging = true;
      }
      
      protected function on_mouseOut(param1:MouseEvent) : void
      {
         _isDragging = false;
      }
      
      protected function on_mouseUp(param1:MouseEvent) : void
      {
         _isDragging = false;
         trace("---------------");
         trace(mcPlayer.x,mcPlayer.y);
         for each(var _loc2_ in Connectr.instance.engine.scene.characterList)
         {
            if(mcPlayer.hitTestObject(_loc2_.container))
            {
               Connectr.instance.serviceModel.requestData("dropthrowaction",{
                  "type":"throw",
                  "xTarget":_loc2_.currentTile.x,
                  "yTarget":_loc2_.currentTile.y
               },onThrowResponse);
               break;
            }
         }
      }
      
      protected function onThrowResponse(param1:Object) : void
      {
         Connectr.instance.serviceModel.removeRequestData("dropthrowaction",onThrowResponse);
         trace("throwed");
      }
      
      protected function on_enterFrame(param1:Event) : void
      {
         Sanalika.instance.layerModel.backgroundLayer;
         if(_isDragging)
         {
            _angle = Math.atan2(joystickM.mouseY - _startY,joystickM.mouseX - _startX) / (3.141592653589793 / 180);
            joystick.rotation = _angle;
            joystick.knob.rotation = -_angle;
            joystick.knob.x = joystick.mouseX;
            if(joystick.knob.x > _radius)
            {
               joystick.knob.x = _radius;
            }
            if(mcPlayer.y < 0)
            {
               mcPlayer.y = 0;
            }
            if(mcPlayer.y > Connectr.instance.gameModel.canvasHeight)
            {
               mcPlayer.y = Connectr.instance.gameModel.canvasHeight;
            }
            if(mcPlayer.x < 0)
            {
               mcPlayer.x = 0;
            }
            if(mcPlayer.x > Connectr.instance.gameModel.canvasWidth)
            {
               mcPlayer.x = Connectr.instance.gameModel.canvasWidth;
            }
            mcPlayer.y += Math.sin(_angle * (3.141592653589793 / 180)) * (joystick.knob.x / 8);
            mcPlayer.x += Math.cos(_angle * (3.141592653589793 / 180)) * (joystick.knob.x / 8);
         }
         else
         {
            _xSpeed = -joystick.knob.x * _tension;
            joystick.knob.x += _xSpeed;
         }
      }
      
      private function disposeGame(param1:GameEvent = null) : void
      {
         dispose();
      }
      
      public function dispose(param1:HudEvent = null) : void
      {
         if(joystick)
         {
            joystick.removeEventListener("mouseOut",on_mouseOut);
            joystick.removeEventListener("mouseDown",on_mouseDown);
            joystick.removeEventListener("mouseUp",on_mouseUp);
         }
         Sanalika.instance.layerModel.stage.removeEventListener("enterFrame",on_enterFrame);
         if(joystickM)
         {
            Sanalika.instance.layerModel.hudLayer.removeChild(joystickM);
            joystickM = null;
         }
         trace("joystickDisposed");
      }
   }
}

