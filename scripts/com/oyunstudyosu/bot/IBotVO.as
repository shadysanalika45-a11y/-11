package com.oyunstudyosu.bot
{
   import com.oyunstudyosu.door.IProperty;
   
   public interface IBotVO
   {
      
      function get isStatic() : Boolean;
      
      function set isStatic(param1:Boolean) : void;
      
      function get onClick() : Function;
      
      function set onClick(param1:Function) : void;
      
      function get metaKey() : String;
      
      function set metaKey(param1:String) : void;
      
      function get nick() : String;
      
      function set nick(param1:String) : void;
      
      function get x() : int;
      
      function set x(param1:int) : void;
      
      function get y() : int;
      
      function set y(param1:int) : void;
      
      function get width() : int;
      
      function set width(param1:int) : void;
      
      function get height() : int;
      
      function set height(param1:int) : void;
      
      function get length() : int;
      
      function set length(param1:int) : void;
      
      function get definition() : String;
      
      function set definition(param1:String) : void;
      
      function get version() : int;
      
      function set version(param1:int) : void;
      
      function get property() : IProperty;
      
      function setProperty(param1:Object) : void;
      
      function get speechProperty() : IProperty;
      
      function setSpeechProperty(param1:Object) : void;
      
      function dispose() : void;
   }
}

