package com.oyunstudyosu.progress
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.local.LocalInstanceConfig;
   import com.oyunstudyosu.local.LocalTranslation;
   import com.oyunstudyosu.utils.NumberUtils;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.ProgressUI;
   
   public class ProgressView extends Sprite
   {
      
      private var view:ProgressUI;
      
      private var currentPercent:int;
      
      private var initProgress:int;
      
      private var progressText:Dictionary;
      
      public var stxtTitle:STextField;
      
      public function ProgressView()
      {
         super();
         progressText = new Dictionary();
         var _loc1_:int = Math.random() * 5;
         switch(_loc1_)
         {
            case 0:
               progressText["LOADING"] = "°j°m";
               break;
            case 1:
               progressText["LOADING"] = "><((((‘>";
               break;
            case 2:
               progressText["LOADING"] = "‘-‘_@_";
               break;
            case 3:
               progressText["LOADING"] = "(,,,)=(^.^)=(,,,)";
               break;
            case 4:
               progressText["LOADING"] = "—-{,_,”>";
               break;
            case 5:
               progressText["LOADING"] = "~~~~~~~~*o/~~~~~/*~~~~~~~";
         }
         view = new ProgressUI();
         addChild(view);
         Dispatcher.addEventListener("INIT_PROGRESS",onInitProgress);
         Dispatcher.addEventListener("LOADING_PROGRESS",onLoadingProgress);
         Dispatcher.addEventListener("INITCOMMAND",onInitCommand);
         changeAnimation();
      }
      
      private function onInitCommand(param1:GameEvent) : void
      {
         if(view.bar.loadingText is STextField)
         {
            return;
         }
         if(LocalInstanceConfig._SafeStr_2("LANGUAGE") == "ar")
         {
            view.bar.loadingText = TextFieldManager.convertAsArabicTextField(view.bar.loadingText,view.bar.loadingText.multiline,false);
         }
      }
      
      private function translateProcess(param1:String, ... rest) : String
      {
         var _loc4_:* = undefined;
         param1 = "PROGRESS_" + param1;
         if(LocalTranslation.exists(param1))
         {
            _loc4_ = [];
            _loc4_.push(param1);
            for each(var _loc3_ in rest)
            {
               _loc4_.push(_loc3_);
            }
            return LocalTranslation.translate.apply(this,_loc4_);
         }
         return param1;
      }
      
      private function changeAnimation() : void
      {
         TweenMax.killDelayedCallsTo(changeAnimation);
         var _loc1_:int = NumberUtils.randRange(1,view.bar.animation.totalFrames);
         view.bar.animation.gotoAndStop(_loc1_);
         TweenMax.delayedCall(20,changeAnimation);
      }
      
      private function onProgressCompleted() : void
      {
         initProgress = 0;
         currentPercent = 0;
         this.visible = false;
      }
      
      private function onLoadingProgress(param1:OSProgressEvent) : void
      {
         currentPercent = initProgress + (100 - initProgress) * param1.vo.percent / 100;
         this.visible = true;
         var _loc3_:Array = [];
         _loc3_.push(param1.vo.description);
         for each(var _loc2_ in param1.vo.args)
         {
            _loc3_.push(_loc2_);
         }
         view.bar.loadingText.text = translateProcess.apply(this,_loc3_);
         if(currentPercent >= 100)
         {
            onProgressCompleted();
         }
      }
      
      private function onInitProgress(param1:OSProgressEvent) : void
      {
         initProgress = param1.vo.percent;
         var _loc3_:Array = [];
         _loc3_.push(param1.vo.description);
         for each(var _loc2_ in param1.vo.args)
         {
            _loc3_.push(_loc2_);
         }
         view.bar.loadingText.text = translateProcess.apply(this,_loc3_);
         this.visible = true;
         if(initProgress >= 100)
         {
            onProgressCompleted();
         }
      }
      
      public function dispose() : void
      {
         TweenMax.killDelayedCallsTo(changeAnimation);
         Dispatcher.removeEventListener("INIT_PROGRESS",onInitProgress);
         Dispatcher.removeEventListener("LOADING_PROGRESS",onLoadingProgress);
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
