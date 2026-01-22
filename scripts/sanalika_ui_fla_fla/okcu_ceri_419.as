package sanalika_ui_fla_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol903")]
   public dynamic class okcu_ceri_419 extends MovieClip
   {
      
      public function okcu_ceri_419()
      {
         super();
         addFrameScript(0,this.frame1,124,this.frame125);
      }
      
      internal function frame1() : *
      {
         gotoAndPlay(Math.round(Math.random() * 5));
      }
      
      internal function frame125() : *
      {
         gotoAndPlay(2);
      }
   }
}

