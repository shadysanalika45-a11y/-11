package com.oyunstudyosu.commands.notification
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import de.polygonal.core.fmt.Sprintf;
   
   public class UserFlatEnteredCommand extends Command
   {
      
      private var vo:AlertVo;
      
      private var data:Object;
      
      public function UserFlatEnteredCommand(param1:Object)
      {
         super();
         this.data = param1;
      }
      
      override public function execute() : void
      {
         if(!Sanalika.instance.avatarModel.settings.flatNotifications)
         {
            return;
         }
         vo = new AlertVo();
         vo.alertType = "tooltip";
         vo.description = Sprintf.format($("userFlatEntered"),[data.avatarName,data.flatName]);
         Dispatcher.dispatchEvent(new AlertEvent(vo));
         complete();
      }
   }
}

