package org.oyunstudyosu.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class CoreMovieClip extends MovieClip
   {
      
      public function CoreMovieClip()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      }
      
      protected function addedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeFromStage);
         this.added();
      }
      
      public function added() : void
      {
      }
      
      public function removed() : void
      {
      }
      
      protected function removeFromStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removeFromStage);
         this.removed();
      }
   }
}

