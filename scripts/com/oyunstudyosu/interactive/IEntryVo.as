package com.oyunstudyosu.interactive
{
   import com.oyunstudyosu.door.IProperty;
   import flash.display.MovieClip;
   
   public interface IEntryVo
   {
      
      function get id() : int;
      
      function set id(param1:int) : void;
      
      function get definition() : String;
      
      function set definition(param1:String) : void;
      
      function get x() : int;
      
      function set x(param1:int) : void;
      
      function get y() : int;
      
      function set y(param1:int) : void;
      
      function get z() : int;
      
      function set z(param1:int) : void;
      
      function get clip() : MovieClip;
      
      function set clip(param1:MovieClip) : void;
      
      function get height() : int;
      
      function set height(param1:int) : void;
      
      function get depth() : int;
      
      function set depth(param1:int) : void;
      
      function get f() : int;
      
      function set f(param1:int) : void;
      
      function get s() : int;
      
      function set s(param1:int) : void;
      
      function get fx() : int;
      
      function set fx(param1:int) : void;
      
      function get lc() : int;
      
      function set lc(param1:int) : void;
      
      function get st() : int;
      
      function set st(param1:int) : void;
      
      function get sv() : int;
      
      function set sv(param1:int) : void;
      
      function get width() : int;
      
      function set width(param1:int) : void;
      
      function get isBusy() : Boolean;
      
      function set isBusy(param1:Boolean) : void;
      
      function gotoFrame(param1:int) : void;
      
      function gotoFrameLabel(param1:String) : void;
      
      function lockState() : void;
      
      function setIndicator() : void;
      
      function over() : void;
      
      function out() : void;
      
      function get property() : IProperty;
      
      function setProperty(param1:Object) : void;
      
      function dispose() : void;
   }
}

