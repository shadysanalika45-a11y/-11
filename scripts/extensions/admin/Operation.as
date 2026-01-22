package extensions.admin
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.extension.IExtension;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Operation extends EventDispatcher implements IExtension
   {
      
      private var key:String;
      
      public function Operation(param1:String)
      {
         super();
         this.key = param1;
         Connectr.instance.keyboardModel.addKeyMapping(param1,execute);
         Dispatcher.addEventListener("Admin+" + param1,onEvent);
      }
      
      private function onEvent(param1:Event = null) : void
      {
         execute();
      }
      
      public function execute() : void
      {
         throw new Error("This is an abstract method. You need to override this.");
      }
      
      public function dispose() : void
      {
         Dispatcher.removeEventListener("Admin+" + key,onEvent);
         Connectr.instance.keyboardModel.clearKeyMapping(key);
      }
      
      public function init(param1:Object = null) : void
      {
      }
      
      public function reload() : void
      {
      }
      
      public function get type() : Class
      {
         return null;
      }
      
      public function get name() : String
      {
         return null;
      }
      
      public function set name(param1:String) : void
      {
      }
   }
}

