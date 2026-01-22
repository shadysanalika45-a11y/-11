package org.oyunstudyosu.commands
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertType;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelType;
   
   public class OpenRoomChangePasswordCommand extends Command
   {
      
      public function OpenRoomChangePasswordCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:AlertVo = null;
         _loc1_ = new AlertVo();
         _loc1_.alertType = AlertType.ROOM_CHANGE_PASSWORD;
         _loc1_.panelType = PanelType.CORE;
         _loc1_.title = $("RoomChangePassword");
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
         complete();
      }
   }
}

