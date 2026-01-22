package com.oyunstudyosu.property
{
   public class SimpleBotMessageProperty extends Property
   {
      
      public function SimpleBotMessageProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         trace("SimpleBotMessageProperty : " + JSON.stringify(data));
      }
   }
}

