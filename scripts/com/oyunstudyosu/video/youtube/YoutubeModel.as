package com.oyunstudyosu.video.youtube
{
   public class YoutubeModel
   {
      
      public var player:YoutubePlayer;
      
      public function YoutubeModel()
      {
         super();
         player = new YoutubePlayer();
      }
      
      public function get isReady() : Boolean
      {
         return player.isReady;
      }
   }
}

