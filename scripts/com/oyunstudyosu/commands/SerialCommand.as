package com.oyunstudyosu.commands
{
   import flash.events.Event;
   
   public class SerialCommand extends Command
   {
      
      private var _commands:Array;
      
      private var _completedCommandCount:int;
      
      public function SerialCommand(... rest)
      {
         super();
         this._commands = rest;
      }
      
      public function addCommand(param1:Command) : void
      {
         if(this._commands == null)
         {
            this._commands = [];
         }
         this._commands.push(param1);
      }
      
      override public function execute() : void
      {
         this._completedCommandCount = 0;
         var _loc1_:Command = Command(this._commands[this._completedCommandCount]);
         _loc1_.addEventListener(Event.COMPLETE,this.onSubcommandComplete);
         _loc1_.execute();
      }
      
      private function onSubcommandComplete(param1:Event) : void
      {
         var _loc2_:Command = null;
         Command(param1.target).removeEventListener(Event.COMPLETE,this.onSubcommandComplete);
         ++this._completedCommandCount;
         if(this._completedCommandCount == this._commands.length)
         {
            complete();
         }
         else
         {
            _loc2_ = Command(this._commands[this._completedCommandCount]);
            _loc2_.addEventListener(Event.COMPLETE,this.onSubcommandComplete);
            _loc2_.execute();
         }
      }
   }
}

