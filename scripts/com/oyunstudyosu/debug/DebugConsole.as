package com.oyunstudyosu.debug
{
   import com.junkbyte.console.Cc;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class DebugConsole
   {
      
      private static var _root:DisplayObjectContainer;
      
      private static var _copyBtn:Sprite;
      
      private static var _inited:Boolean = false;
      
      private static var _buffer:Array = [];
      
      private static var _maxBufferLines:int = 20000;
      
      public function DebugConsole()
      {
         super();
      }
      
      public static function init(root:DisplayObjectContainer) : void
      {
         if(_inited || root == null)
         {
            return;
         }
         _inited = true;
         _root = root;
         try
         {
            Cc.startOnStage(root.stage,"~");
         }
         catch(e:Error)
         {
         }
         try
         {
            Cc.visible = true;
            Cc.config.alwaysOnTop = true;
            Cc.config.commandLineAllowed = true;
            Cc.config.maxLines = 8000;
            Cc.config.maxRepeats = 2000;
            Cc.config.showTimestamp = true;
            Cc.addChannel("NET_OUT");
            Cc.addChannel("NET_IN");
            Cc.addChannel("ROOM");
            Cc.addChannel("MAP");
            Cc.addChannel("ASSETS");
            Cc.addChannel("RENDER");
            Cc.addChannel("STATE");
            Cc.addChannel("ERR");
         }
         catch(e2:Error)
         {
         }
         buildCopyButton();
         if(_root.stage)
         {
            _root.stage.addEventListener(Event.ENTER_FRAME,keepOnTop);
            _root.stage.addEventListener(Event.RESIZE,onResize);
            onResize(null);
         }
         info("STATE","DebugConsole initialized");
      }
      
      private static function buildCopyButton() : void
      {
         var tf:TextField;
         _copyBtn = new Sprite();
         _copyBtn.buttonMode = true;
         _copyBtn.mouseChildren = false;
         _copyBtn.graphics.beginFill(0,0.75);
         _copyBtn.graphics.drawRoundRect(0,0,110,26,10,10);
         _copyBtn.graphics.endFill();
         tf = new TextField();
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.defaultTextFormat = new TextFormat("_sans",12,16777215,true);
         tf.text = "COPY ALL";
         tf.width = 110;
         tf.height = 26;
         tf.x = 0;
         tf.y = 4;
         tf.multiline = false;
         tf.wordWrap = false;
         tf.autoSize = "center";
         _copyBtn.addChild(tf);
         _copyBtn.addEventListener(MouseEvent.CLICK,onCopyAll);
         try
         {
            _root.stage.addChild(_copyBtn);
         }
         catch(e:Error)
         {
         }
      }
      
      private static function onResize(e:Event) : void
      {
         if(_root == null || _root.stage == null || _copyBtn == null)
         {
            return;
         }
         _copyBtn.x = Math.max(0,_root.stage.stageWidth - _copyBtn.width - 10);
         _copyBtn.y = 10;
      }
      
      private static function keepOnTop(e:Event) : void
      {
         if(_root == null || _root.stage == null)
         {
            return;
         }
         try
         {
            if(_copyBtn && _copyBtn.parent)
            {
               _copyBtn.parent.setChildIndex(_copyBtn,_copyBtn.parent.numChildren - 1);
            }
         }
         catch(e2:Error)
         {
         }
      }
      
      private static function onCopyAll(e:MouseEvent) : void
      {
         var txt:String = _buffer.join("\n");
         System.setClipboard(txt);
         info("STATE","Copied console buffer to clipboard","lines=",_buffer.length);
      }
      
      private static function pushLine(level:String, channel:String, msg:String) : void
      {
         var line:String = "[" + getTimer() + "]" + "[" + level + "]" + "[" + channel + "] " + msg;
         _buffer.push(line);
         if(_buffer.length > _maxBufferLines)
         {
            _buffer.shift();
         }
      }
      
      private static function joinArgs(args:Array) : String
      {
         var a:*;
         var out:Array = [];
         for each(a in args)
         {
            try
            {
               out.push(String(a));
            }
            catch(e:Error)
            {
               out.push("[unstringifiable]");
            }
         }
         return out.join(" ");
      }
      
      public static function info(channel:String, ... args) : void
      {
         var msg:String = joinArgs(args);
         pushLine("INFO",channel,msg);
         try
         {
            Cc.infoch(channel,msg);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function warn(channel:String, ... args) : void
      {
         var msg:String = joinArgs(args);
         pushLine("WARN",channel,msg);
         try
         {
            Cc.warnch(channel,msg);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function error(channel:String, ... args) : void
      {
         var msg:String = joinArgs(args);
         pushLine("ERROR",channel,msg);
         try
         {
            Cc.errorch(channel,msg);
         }
         catch(e:Error)
         {
         }
      }
   }
}

