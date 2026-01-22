package sanalika_ui_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1315")]
   public dynamic class CatchAndMiss_Anim_134 extends MovieClip
   {
      
      public function CatchAndMiss_Anim_134()
      {
         super();
         addFrameScript(179,this.frame180);
      }
      
      internal function frame180() : *
      {
         stop();
         this.dispatchEvent(new Event("catchAndMissAnimationCompleted",true));
      }
   }
}

