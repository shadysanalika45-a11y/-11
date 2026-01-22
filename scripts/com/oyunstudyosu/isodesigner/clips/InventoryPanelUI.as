package com.oyunstudyosu.isodesigner.clips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.oyunstudyosu.alert.buttons.CloseViewButton;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol44")]
   public class InventoryPanelUI extends CoreMovieClip
   {
      
      public var background:MovieClip;
      
      public var btnClose:CloseViewButton;
      
      public var maskContainer:MovieClip;
      
      public var txtSearch:TextField;
      
      public function InventoryPanelUI()
      {
         super();
      }
   }
}

