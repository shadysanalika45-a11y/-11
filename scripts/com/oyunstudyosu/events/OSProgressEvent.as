package com.oyunstudyosu.events
{
   import com.oyunstudyosu.progress.ProgressVo;
   import flash.events.Event;
   
   public class OSProgressEvent extends Event
   {
      
      public static const INIT_PROGRESS:String = "INIT_PROGRESS";
      
      public static const LOADING_PROGRESS:String = "LOADING_PROGRESS";
      
      public var vo:ProgressVo;
      
      public function OSProgressEvent(param1:String, param2:ProgressVo)
      {
         super(param1,true,false);
         this.vo = param2;
      }
      
      override public function clone() : Event
      {
         return new OSProgressEvent(this.type,this.vo);
      }
   }
}

