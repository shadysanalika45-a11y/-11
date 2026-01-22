package lime.system
{
   import flash.Boot;
   import lime.app._Event_Dynamic_Void;
   
   public class ThreadPool
   {
      
      public var onRun:_Event_Dynamic_Void;
      
      public var onProgress:_Event_Dynamic_Void;
      
      public var onError:_Event_Dynamic_Void;
      
      public var onComplete:_Event_Dynamic_Void;
      
      public var minThreads:int;
      
      public var maxThreads:int;
      
      public var doWork:_Event_Dynamic_Void;
      
      public var currentThreads:int;
      
      public function ThreadPool(param1:int = 0, param2:int = 1)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onRun = new _Event_Dynamic_Void();
         onProgress = new _Event_Dynamic_Void();
         onError = new _Event_Dynamic_Void();
         onComplete = new _Event_Dynamic_Void();
         doWork = new _Event_Dynamic_Void();
         minThreads = param1;
         maxThreads = param2;
         currentThreads = 0;
      }
      
      public function sendProgress(param1:* = undefined) : void
      {
         onProgress.dispatch(param1);
      }
      
      public function sendError(param1:* = undefined) : void
      {
         onError.dispatch(param1);
      }
      
      public function sendComplete(param1:* = undefined) : void
      {
         onComplete.dispatch(param1);
      }
      
      public function runWork(param1:* = undefined) : void
      {
         onRun.dispatch(param1);
         doWork.dispatch(param1);
      }
      
      public function queue(param1:* = undefined) : void
      {
         runWork(param1);
      }
   }
}

