package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.engine.scene.vo.DragVo;
   
   public interface ISceneCameraComponent extends ISceneComponent
   {
      
      function get dragVo() : DragVo;
      
      function screenShiftTo(param1:Number, param2:Number, param3:Number = 0.8) : void;
   }
}

