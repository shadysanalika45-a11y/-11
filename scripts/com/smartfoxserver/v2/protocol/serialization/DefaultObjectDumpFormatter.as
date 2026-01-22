package com.smartfoxserver.v2.protocol.serialization
{
   import com.smartfoxserver.v2.exceptions.SFSError;
   import flash.utils.ByteArray;
   
   public class DefaultObjectDumpFormatter
   {
      
      public static const TOKEN_INDENT_OPEN:String = "{";
      
      public static const TOKEN_INDENT_CLOSE:String = "}";
      
      public static const TOKEN_DIVIDER:String = ";";
      
      public static const NEW_LINE:String = "\n";
      
      public static const TAB:String = "\t";
      
      public static const DOT:String = ".";
      
      public static const HEX_BYTES_PER_LINE:int = 16;
      
      public function DefaultObjectDumpFormatter()
      {
         super();
      }
      
      public static function prettyPrintByteArray(param1:ByteArray) : String
      {
         if(param1 == null)
         {
            return "Null";
         }
         return "Byte[" + param1.length + "]";
      }
      
      public static function prettyPrintDump(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc6_);
            if(_loc2_ == TOKEN_INDENT_OPEN)
            {
               _loc4_++;
               _loc3_ += NEW_LINE + getFormatTabs(_loc4_);
            }
            else if(_loc2_ == TOKEN_INDENT_CLOSE)
            {
               if(--_loc4_ < 0)
               {
                  throw new SFSError("DumpFormatter: the indentPos is negative. TOKENS ARE NOT BALANCED!");
               }
               _loc3_ += NEW_LINE + getFormatTabs(_loc4_);
            }
            else if(_loc2_ == TOKEN_DIVIDER)
            {
               _loc3_ += NEW_LINE + getFormatTabs(_loc4_);
            }
            else
            {
               _loc3_ += _loc2_;
            }
            _loc6_++;
         }
         if(_loc4_ != 0)
         {
            throw new SFSError("DumpFormatter: the indentPos is not == 0. TOKENS ARE NOT BALANCED!");
         }
         return _loc3_;
      }
      
      private static function getFormatTabs(param1:int) : String
      {
         return strFill(TAB,param1);
      }
      
      private static function strFill(param1:String, param2:int) : String
      {
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc3_ += param1;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function hexDump(param1:ByteArray, param2:int = -1) : String
      {
         var _loc3_:String = null;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = int(param1.position);
         param1.position = 0;
         if(param2 == -1)
         {
            param2 = HEX_BYTES_PER_LINE;
         }
         var _loc8_:String = "Binary Size: " + param1.length + NEW_LINE;
         var _loc9_:String = "";
         var _loc10_:String = "";
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         do
         {
            _loc4_ = param1.readByte() & 0xFF;
            _loc5_ = _loc4_.toString(16).toUpperCase();
            if(_loc5_.length == 1)
            {
               _loc5_ = "0" + _loc5_;
            }
            _loc9_ += _loc5_ + " ";
            if(_loc4_ >= 33 && _loc4_ <= 126)
            {
               _loc3_ = String.fromCharCode(_loc4_);
            }
            else
            {
               _loc3_ = DOT;
            }
            _loc10_ += _loc3_;
            if(++_loc12_ == param2)
            {
               _loc12_ = 0;
               _loc8_ += _loc9_ + TAB + _loc10_ + NEW_LINE;
               _loc9_ = "";
               _loc10_ = "";
            }
         }
         while(++_loc11_ < param1.length);
         
         if(_loc12_ != 0)
         {
            _loc6_ = param2 - _loc12_;
            while(_loc6_ > 0)
            {
               _loc9_ += "   ";
               _loc10_ += " ";
               _loc6_--;
            }
            _loc8_ += _loc9_ + TAB + _loc10_ + NEW_LINE;
         }
         param1.position = _loc7_;
         return _loc8_;
      }
   }
}

