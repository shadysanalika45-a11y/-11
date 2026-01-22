package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.Stage;
   import flash.display.StageQuality;
   
   public class StageQualityPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected var _stage:Stage;
      
      protected var _during:String;
      
      protected var _after:String;
      
      protected var _tween:TweenLite;
      
      public function StageQualityPlugin()
      {
         super();
         this.propName = "stageQuality";
         this.overwriteProps = ["stageQuality"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param2.stage is Stage))
         {
            trace("You must define a \'stage\' property for the stageQuality object in your tween.");
            return false;
         }
         this._stage = param2.stage as Stage;
         this._tween = param3;
         this._during = "during" in param2 ? param2.during : StageQuality.MEDIUM;
         this._after = "after" in param2 ? param2.after : this._stage.quality;
         return true;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         if(this._tween.cachedDuration == this._tween.cachedTime || this._tween.cachedTime == 0)
         {
            this._stage.quality = this._after;
         }
         else if(this._stage.quality != this._during)
         {
            this._stage.quality = this._during;
         }
      }
   }
}

