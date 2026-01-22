package com.oyunstudyosu.commands
{
   import flash.events.Event;
   
   public class ParallelCommand extends Command
   {
      
      private var _commands:Array;
      
      private var _completedCommandCount:int;
      
      public function ParallelCommand(... rest)
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
         var _loc1_:Command = null;
         this._completedCommandCount = 0;
         for each(_loc1_ in this._commands)
         {
            _loc1_.addEventListener(Event.COMPLETE,this.onSubcommandComplete);
            _loc1_.execute();
         }
      }
      
      private function onSubcommandComplete(param1:Event) : void
      {
         Command(param1.target).removeEventListener(Event.COMPLETE,this.onSubcommandComplete);
         ++this._completedCommandCount;
         if(this._completedCommandCount == this._commands.length)
         {
            complete();
         }
      }
   }
}

