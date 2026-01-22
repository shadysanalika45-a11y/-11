package com.oyunstudyosu.model
{
   import com.oyunstudyosu.commands.CheckSessionCommand;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import flash.net.SharedObject;
   
   public class CookieModel implements ICookieModel
   {
      
      private var so:SharedObject;
      
      public var data:Object;
      
      public var name:String;
      
      private var sessionCommand:CheckSessionCommand;
      
      public function CookieModel()
      {
         super();
      }
      
      public function startCheck() : void
      {
         Sanalika.instance.updateModel.getGroup(10000).addFunction(checkSession);
      }
      
      public function stopCheck() : void
      {
         Sanalika.instance.updateModel.getGroup(10000).removeFunction(checkSession);
      }
      
      public function open(param1:String) : Boolean
      {
         this.name = param1;
         try
         {
            so = SharedObject.getLocal(name);
            this.data = so.data;
         }
         catch(error:Error)
         {
            name = null;
            so = null;
         }
         return true;
      }
      
      private function ddf(param1:uint) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1 + "";
      }
      
      public function stampDate(param1:String) : void
      {
         var _loc2_:Date = new Date();
         trace("stampDate");
         this.write(param1,Number(_loc2_.fullYear + ddf(_loc2_.month + 1) + ddf(_loc2_.date)));
      }
      
      public function checkDate(param1:String) : Boolean
      {
         var _loc2_:Date = new Date();
         if(this.read(param1) as int < Number(_loc2_.fullYear + ddf(_loc2_.month + 1) + ddf(_loc2_.date)))
         {
            return true;
         }
         return false;
      }
      
      private function checkSession(param1:Number, param2:Number) : void
      {
         sessionCommand = new CheckSessionCommand();
         sessionCommand.execute();
      }
      
      public function write(param1:String, param2:Object) : Boolean
      {
         if(so == null)
         {
            return false;
         }
         this.data[param1] = param2;
         return save();
      }
      
      public function read(param1:String) : Object
      {
         if(so == null)
         {
            return null;
         }
         return this.data[param1];
      }
      
      public function clear(param1:String) : Boolean
      {
         if(so == null)
         {
            return false;
         }
         this.data[param1] = null;
         return save();
      }
      
      private function save() : Boolean
      {
         var _loc1_:Object = null;
         if(so == null)
         {
            return false;
         }
         try
         {
            _loc1_ = so.flush();
         }
         catch(error:Error)
         {
         }
         return _loc1_ == "flushed";
      }
   }
}

