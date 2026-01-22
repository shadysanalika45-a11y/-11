package com.oyunstudyosu.commands.security
{
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.panel.PanelVO;
   
   public class OpenSecurityCaptchaCommand extends Command
   {
      
      private var data:Object;
      
      public function OpenSecurityCaptchaCommand(param1:Object)
      {
         super();
         this.data = param1;
      }
      
      override public function execute() : void
      {
         var _loc1_:PanelVO = new PanelVO("CaptchaPanel");
         _loc1_.type = "static";
         _loc1_.params = data;
         Sanalika.instance.panelModel.openPanel(_loc1_);
         complete();
      }
   }
}

