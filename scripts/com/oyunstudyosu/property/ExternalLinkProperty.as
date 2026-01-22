package com.oyunstudyosu.property
{
   import com.oyunstudyosu.utils.QueryString;
   import com.oyunstudyosu.utils.Tracker;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ExternalLinkProperty extends Property
   {
      
      public function ExternalLinkProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc3_:String = data.link;
         if(_loc3_.indexOf("https://") == -1 && _loc3_.indexOf("http://") == -1)
         {
            _loc3_ = "http://" + _loc3_;
         }
         var _loc2_:QueryString = new QueryString(_loc3_);
         if(_loc2_.parameters.utm_campaign)
         {
            Tracker.track("ad","clickUrl",_loc2_.parameters.utm_campaign);
            trace("clickUrl : " + _loc2_.parameters.utm_campaign);
         }
         else
         {
            Tracker.track("url","clickUrl",_loc3_);
         }
         navigateToURL(new URLRequest(_loc3_));
         trace("ExternalLinkProperty : " + JSON.stringify(data));
      }
   }
}

