package sanalika_ui_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1242")]
   public dynamic class Shake_Samandra_Anim_130 extends MovieClip
   {
      
      public function Shake_Samandra_Anim_130()
      {
         super();
         addFrameScript(179,this.frame180);
      }
      
      internal function frame180() : *
      {
         stop();
         this.dispatchEvent(new Event("shakeAnimationCompleted",true));
      }
   }
}

