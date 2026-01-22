package com.oyunstudyosu.property
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.engine.scene.components.SceneBotComponent;
   import com.oyunstudyosu.events.BotEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechable;
   import com.oyunstudyosu.utils.NumberUtils;
   import de.polygonal.core.fmt.Sprintf;
   
   public class SpeechProperty extends Property
   {
      
      private var currentSpeechIndex:int = 0;
      
      private var list:Array;
      
      private var lastMessage:String;
      
      public function SpeechProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         TweenMax.killDelayedCallsTo(dispatchCasual);
         Dispatcher.dispatchEvent(new BotEvent("speech","casual",data.metaKey));
         routineMessage();
      }
      
      private function talk(param1:String) : void
      {
         if(list == null)
         {
            return;
         }
         var _loc2_:ISpeechable = null;
         var _loc3_:SceneBotComponent = Sanalika.instance.engine.scene.getComponent(SceneBotComponent) as SceneBotComponent;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getBotByName(data.metaKey);
         }
         if(_loc2_ != null)
         {
            _loc2_.talk(Sprintf.format(param1,[Sanalika.instance.avatarModel.avatarName]));
            lastMessage = param1;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(param1.list == null)
         {
            return;
         }
         super.data = param1;
         list = [];
         _loc4_ = 0;
         while(_loc4_ < param1.list.length)
         {
            _loc3_ = param1.list[_loc4_].event;
            _loc2_ = param1.list[_loc4_].message;
            if(list[_loc3_])
            {
               list[_loc3_].push(_loc2_);
            }
            else
            {
               list[_loc3_] = [_loc2_];
            }
            _loc4_++;
         }
         routineMessage();
         Dispatcher.addEventListener("speech",listenSpeechEvents);
         Dispatcher.addEventListener("SCENE_LOADED",onSceneLoaded);
      }
      
      private function routineMessage() : void
      {
         var _loc1_:int = NumberUtils.randRange(10,40);
         TweenMax.delayedCall(_loc1_,dispatchCasual);
      }
      
      private function listenSpeechEvents(param1:BotEvent) : void
      {
         var _loc2_:int = 0;
         if(list == null || param1.botKey != data.metaKey)
         {
            return;
         }
         if(list[param1.speechType])
         {
            if(param1.botKey != null && param1.botKey == data.metaKey || param1.botKey == null)
            {
               _loc2_ = NumberUtils.randRange(0,list[param1.speechType].length - 1);
               talk(Sprintf.format(list[param1.speechType][_loc2_],[Sanalika.instance.avatarModel.avatarName]));
            }
         }
      }
      
      private function onSceneLoaded(param1:GameEvent) : void
      {
         Dispatcher.removeEventListener("SCENE_LOADED",onSceneLoaded);
         TweenMax.delayedCall(Math.random() * 5,dispatchWelcome);
      }
      
      private function dispatchWelcome() : void
      {
         TweenMax.killDelayedCallsTo(dispatchWelcome);
         if(data != null)
         {
            Dispatcher.dispatchEvent(new BotEvent("speech","welcome",data.metaKey));
         }
      }
      
      private function dispatchCasual() : void
      {
         TweenMax.killDelayedCallsTo(dispatchCasual);
         if(data != null)
         {
            Dispatcher.dispatchEvent(new BotEvent("speech","casual",data.metaKey));
            routineMessage();
         }
      }
      
      override public function dispose() : void
      {
         TweenMax.killDelayedCallsTo(dispatchWelcome);
         TweenMax.killDelayedCallsTo(dispatchCasual);
         Dispatcher.removeEventListener("speech",listenSpeechEvents);
         super.dispose();
      }
   }
}

