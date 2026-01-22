package com.oyunstudyosu.property
{
   import com.oyunstudyosu.bot.IBotVO;
   
   public class EmptyProperty extends Property
   {
      
      public function EmptyProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:IBotVO = null;
         super.data = param1;
         if(data.type == "bot")
         {
            _loc2_ = Sanalika.instance.roomModel.botModel.getBotByKey(data.metaKey);
            if(_loc2_)
            {
               _loc2_.isStatic = true;
            }
         }
      }
   }
}

