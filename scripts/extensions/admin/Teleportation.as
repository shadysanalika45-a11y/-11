package extensions.admin
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.StringUtils;
   
   public class Teleportation extends Operation
   {
      
      public function Teleportation(param1:String)
      {
         super(param1);
      }
      
      override public function execute() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "Prompt";
         _loc1_.title = "Teleport Panel";
         _loc1_.description = "Enter room key to teleport";
         _loc1_.callBack = onTeleport;
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
      
      private function onTeleport(param1:int, param2:String) : void
      {
         if(param1 == 2)
         {
            if(Sanalika.instance.avatarModel.permission.check(20))
            {
               Connectr.instance.serviceModel.requestData("teleport",{"roomKey":StringUtils.removeExtraWhitespace(param2)},null);
            }
         }
      }
   }
}

