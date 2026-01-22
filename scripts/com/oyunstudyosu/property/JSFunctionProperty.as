package com.oyunstudyosu.property
{
   import flash.external.ExternalInterface;
   
   public class JSFunctionProperty extends Property
   {
      
      public function JSFunctionProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         trace("ExternalInterface:" + data.functionName + " : " + data.params);
         if(ExternalInterface.available)
         {
            ExternalInterface.call(data.functionName,data.params);
            if(Sanalika.instance.layerModel.stage.displayState == "fullScreen" || Sanalika.instance.layerModel.stage.displayState == "fullScreenInteractive")
            {
               Sanalika.instance.layerModel.stage.displayState = "normal";
            }
         }
      }
   }
}

