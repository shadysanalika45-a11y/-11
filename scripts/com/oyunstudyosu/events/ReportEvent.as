package com.oyunstudyosu.events
{
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import flash.events.Event;
   
   public class ReportEvent extends Event
   {
      
      public static const REPORT_USER:String = "ReportEvent.REPORT_USER";
      
      public var params:ISFSObject;
      
      public function ReportEvent(param1:String)
      {
         super(param1);
      }
   }
}

