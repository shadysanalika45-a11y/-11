package com.oyunstudyosu.model
{
   import com.oyunstudyosu.chat.ChatColorTemplate;
   import com.oyunstudyosu.events.ChatBalloonEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.interfaces.IChatBalloonModel;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import org.oyunstudyosu.speech.BirdWing;
   import org.oyunstudyosu.speech.GuitarBubble;
   import org.oyunstudyosu.speech.LoveSpeech;
   import org.oyunstudyosu.speech.WhisperBubble;
   import org.oyunstudyosu.speech.defaultBubbles.BlackBubble;
   import org.oyunstudyosu.speech.defaultBubbles.BlueBubble;
   import org.oyunstudyosu.speech.defaultBubbles.DefaultBubble;
   import org.oyunstudyosu.speech.defaultBubbles.DiamondClubBubble;
   import org.oyunstudyosu.speech.defaultBubbles.GreyBubble;
   import org.oyunstudyosu.speech.defaultBubbles.PinkBubble;
   import org.oyunstudyosu.speech.defaultBubbles.RedBubble;
   import org.oyunstudyosu.speech.defaultBubbles.SanalikaXBubble;
   import org.oyunstudyosu.speech.defaultBubbles.SilverBubble;
   import org.oyunstudyosu.speech.defaultBubbles.YellowBubble;
   
   public class ChatBalloonModel implements IChatBalloonModel
   {
      
      public var list:Array;
      
      private var _activeBalloons:Array;
      
      public function ChatBalloonModel()
      {
         super();
         list = [];
         add(ChatColorTemplate.DEFAULT,DefaultBubble);
         add(ChatColorTemplate.BLUE,BlueBubble);
         add(ChatColorTemplate.SILVER,SilverBubble);
         add(ChatColorTemplate.YELLOW,YellowBubble);
         add(ChatColorTemplate.GREY,GreyBubble);
         add(ChatColorTemplate.LOVE,LoveSpeech);
         add(ChatColorTemplate.BOT,BlueBubble);
         add(ChatColorTemplate.GREY,GreyBubble);
         add(ChatColorTemplate.PINK,PinkBubble);
         add(ChatColorTemplate.RED,RedBubble);
         add(ChatColorTemplate.WING,BirdWing);
         add(ChatColorTemplate.MUSIC,GuitarBubble);
         add(ChatColorTemplate.WHISPER,WhisperBubble);
         add(ChatColorTemplate.BLACK,BlackBubble);
         add(ChatColorTemplate.QUEST,BlueBubble);
         add(ChatColorTemplate.DIAMOND_CLUB,DiamondClubBubble);
         add(ChatColorTemplate.SANALIKAX,SanalikaXBubble);
         Sanalika.instance.serviceModel.listenExtension("chatBalloonsUpdated",chatBalloonsUpdated);
      }
      
      private function chatBalloonsUpdated(param1:Object) : void
      {
         if(param1.chatBaloons)
         {
            activeBalloons = param1.chatBaloons;
         }
      }
      
      public function get activeBalloons() : Array
      {
         return _activeBalloons;
      }
      
      public function set activeBalloons(param1:Array) : void
      {
         if(_activeBalloons == param1)
         {
            return;
         }
         _activeBalloons = param1;
         Dispatcher.dispatchEvent(new ChatBalloonEvent("ChatBalloonEvent.BALLOONS_CHANGED"));
      }
      
      public function add(param1:ChatColorTemplate, param2:Class) : void
      {
         list.push({
            "temp":param1,
            "bubble":param2
         });
      }
      
      public function getTemplateByID(param1:int) : ChatColorTemplate
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            if(param1 == list[_loc2_].temp.bgFrame)
            {
               return list[_loc2_].temp;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getBubbleByID(param1:int) : ISpeechBubble
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            if(param1 == list[_loc2_].temp.bgFrame)
            {
               return new list[_loc2_].bubble();
            }
            _loc2_++;
         }
         return null;
      }
   }
}

