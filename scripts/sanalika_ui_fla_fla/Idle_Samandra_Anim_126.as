package sanalika_ui_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1237")]
   public dynamic class Idle_Samandra_Anim_126 extends MovieClip
   {
      
      public function Idle_Samandra_Anim_126()
      {
         super();
         addFrameScript(179,this.frame180);
      }
      
      internal function frame180() : *
      {
         this.dispatchEvent(new Event("idleAnimationCompleted",true));
      }
   }
}

