package org.oyunstudyosu.assets.snowball
{
   import com.oyunstudyosu.timer.SyncTimer;
   import com.oyunstudyosu.utils.TimeConverter;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import org.oyunstudyosu.alert.buttons.YellowButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol990")]
   public class Hud extends MovieClip
   {
      
      public var teamCount:TeamCount;
      
      public var txtRemaining:TextField;
      
      public var txtAmmo:TextField;
      
      public var finishTimestamp:int = 0;
      
      public var mcState:MovieClip;
      
      public var btnJoin:YellowButton;
      
      public var scoreBoard:Board;
      
      public var txtBlueScore:TextField;
      
      private var _blueScore:int = 0;
      
      public var txtGreenScore:TextField;
      
      private var _greenScore:int = 0;
      
      public function Hud()
      {
         super();
         this.addEventListener(Event.ENTER_FRAME,this.update);
         this.scoreBoard.visible = false;
      }
      
      public function get blueScore() : int
      {
         return this._blueScore;
      }
      
      public function set blueScore(param1:int) : void
      {
         this._blueScore = param1;
         trace("txtBlueScore: " + this.txtBlueScore);
         this.txtBlueScore.text = param1.toString();
      }
      
      public function get greenScore() : int
      {
         return this._greenScore;
      }
      
      public function set greenScore(param1:int) : void
      {
         this._greenScore = param1;
         trace("txtGreenScore: " + this.txtGreenScore);
         this.txtGreenScore.text = param1.toString();
      }
      
      private function update(param1:Event = null) : void
      {
         var _loc2_:int = this.finishTimestamp - SyncTimer.timestamp;
         if(_loc2_ >= 0)
         {
            this.txtRemaining.text = TimeConverter.toTime(_loc2_ * 1000);
         }
         else
         {
            this.txtRemaining.text = "";
         }
      }
   }
}

