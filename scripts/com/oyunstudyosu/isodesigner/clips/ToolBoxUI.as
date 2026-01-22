package com.oyunstudyosu.isodesigner.clips
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol99")]
   public class ToolBoxUI extends CoreMovieClip
   {
      
      public var btnErase:SimpleButton;
      
      public var btnInventory:SimpleButton;
      
      public var btnQuit:SimpleButton;
      
      public var btnRotate:SimpleButton;
      
      public var btnSave:SimpleButton;
      
      public var btnEraseAll:SimpleButton;
      
      public var menuBg:MovieClip;
      
      public function ToolBoxUI()
      {
         super();
      }
   }
}

