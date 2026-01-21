package com.oyunstudyosu.debug
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import flash.net.FileReference;
   import flash.utils.getTimer;
   
   public class ContractLogger
   {
      
      private static var _enabled:Boolean = true;
      
      private static var _events:Array = [];
      
      private static var _lines:Array = [];
      
      private static var _maxEvents:int = 20000;
      
      private static var _maxLines:int = 40000;
      
      private static var _maxString:int = 1200;
      
      public function ContractLogger()
      {
         super();
      }
      
      public static function enable() : void
      {
         _enabled = true;
      }
      
      public static function disable() : void
      {
         _enabled = false;
      }
      
      public static function log(param1:String, param2:Object = null, param3:String = "") : void
      {
         var _loc5_:String = null;
         var _loc4_:Object = null;
         if(!_enabled)
         {
            return;
         }
         _loc4_ = {};
         _loc4_.ts = getTimer();
         _loc4_.type = param1;
         if(param3 != null && param3.length > 0)
         {
            _loc4_.message = param3;
         }
         if(param2 != null)
         {
            _loc4_.data = sanitize(param2);
         }
         _events.push(_loc4_);
         if(_events.length > _maxEvents)
         {
            _events.shift();
         }
         _loc5_ = "[" + _loc4_.ts + "][" + param1 + "]";
         if(_loc4_.message)
         {
            _loc5_ += " " + _loc4_.message;
         }
         if(_loc4_.data)
         {
            _loc5_ += " " + safeStringify(_loc4_.data);
         }
         _lines.push(_loc5_);
         if(_lines.length > _maxLines)
         {
            _lines.shift();
         }
      }
      
      public static function summarizeObject(param1:Object) : Object
      {
         var _loc2_:*;
         var _loc3_:Array = [];
         var _loc4_:Object = {};
         for(_loc2_ in param1)
         {
            _loc3_.push(_loc2_);
            _loc4_[_loc2_] = valueType(param1[_loc2_]);
         }
         return {
            "keys":_loc3_,
            "types":_loc4_
         };
      }
      
      public static function saveLogs() : void
      {
         var _loc1_:FileReference = null;
         var _loc2_:FileReference = null;
         _loc1_ = new FileReference();
         _loc1_.save(_lines.join("\n"),"client_contracts.log");
         _loc2_ = new FileReference();
         _loc2_.save(JSON.stringify(_events,null,2),"client_contracts.json");
      }
      
      private static function valueType(param1:*) : String
      {
         if(param1 == null)
         {
            return "null";
         }
         if(param1 is Array)
         {
            return "Array";
         }
         if(param1 is String)
         {
            return "String";
         }
         if(param1 is Number)
         {
            return "Number";
         }
         if(param1 is Boolean)
         {
            return "Boolean";
         }
         if(param1 is ISFSObject)
         {
            return "SFSObject";
         }
         if(param1 is ISFSArray)
         {
            return "SFSArray";
         }
         return "Object";
      }
      
      private static function sanitize(param1:*) : *
      {
         var _loc2_:* = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:* = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1 is String)
         {
            if(param1.length > _maxString)
            {
               return param1.substr(0,_maxString) + "...";
            }
            return param1;
         }
         if(param1 is Number || param1 is Boolean)
         {
            return param1;
         }
         if(param1 is ISFSObject)
         {
            return sanitize(ISFSObject(param1).toObject());
         }
         if(param1 is ISFSArray)
         {
            _loc3_ = [];
            _loc2_ = 0;
            while(_loc2_ < ISFSArray(param1).size())
            {
               _loc3_.push(sanitize(ISFSArray(param1).getElementAt(_loc2_)));
               _loc2_++;
            }
            return _loc3_;
         }
         if(param1 is Array)
         {
            _loc3_ = [];
            _loc2_ = 0;
            while(_loc2_ < param1.length && _loc2_ < 200)
            {
               _loc3_.push(sanitize(param1[_loc2_]));
               _loc2_++;
            }
            if(param1.length > 200)
            {
               _loc3_.push("...truncated(" + param1.length + ")");
            }
            return _loc3_;
         }
         _loc4_ = {};
         for(_loc5_ in param1)
         {
            _loc4_[_loc5_] = sanitize(param1[_loc5_]);
         }
         return _loc4_;
      }
      
      private static function safeStringify(param1:Object) : String
      {
         try
         {
            return JSON.stringify(param1);
         }
         catch(e:Error)
         {
         }
         return "[unstringifiable]";
      }
   }
}
