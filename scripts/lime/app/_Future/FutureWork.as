package lime.app._Future
{
   import haxe.Exception;
   import lime.system.ThreadPool;
   
   public class FutureWork
   {
      
      public static var threadPool:ThreadPool;
      
      public function FutureWork()
      {
      }
      
      public static function queue(param1:* = undefined) : void
      {
         if(FutureWork.threadPool == null)
         {
            FutureWork.threadPool = new ThreadPool();
            FutureWork.threadPool.doWork.add(FutureWork.threadPool_doWork);
            FutureWork.threadPool.onComplete.add(FutureWork.threadPool_onComplete);
            FutureWork.threadPool.onError.add(FutureWork.threadPool_onError);
         }
         FutureWork.threadPool.queue(param1);
      }
      
      public static function threadPool_doWork(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         try
         {
            _loc3_ = param1.work();
            FutureWork.threadPool.sendComplete({
               "promise":param1.promise,
               "result":_loc3_
            });
         }
         catch(_loc_e_:*)
         {
            return;
         }
      }
      
      public static function threadPool_onComplete(param1:*) : void
      {
         param1.promise.complete(param1.result);
      }
      
      public static function threadPool_onError(param1:*) : void
      {
         param1.promise.error(param1.error);
      }
   }
}

