package sanalika_ui_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1320")]
   public dynamic class Catch_Samandra_Anim_136 extends MovieClip
   {
      
      public function Catch_Samandra_Anim_136()
      {
         super();
         addFrameScript(129,this.frame130);
      }
      
      internal function frame130() : *
      {
         stop();
         this.dispatchEvent(new Event("catchAnimationCompleted",true));
      }
   }
}

