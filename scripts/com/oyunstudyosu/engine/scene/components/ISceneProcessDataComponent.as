package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.engine.core.MapEntry;
   import flash.display.MovieClip;
   
   public interface ISceneProcessDataComponent extends ISceneComponent
   {
      
      function load() : void;
      
      function processSceneData() : void;
      
      function processEntry(param1:MapEntry) : Boolean;
      
      function getMovieClip(param1:String) : MovieClip;
   }
}

