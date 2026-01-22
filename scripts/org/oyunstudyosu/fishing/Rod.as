package org.oyunstudyosu.fishing
{
   import com.oyunstudyosu.engine.IntPoint;
   import flash.display.MovieClip;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1365")]
   public class Rod extends CoreMovieClip
   {
      
      public var anim:MovieClip;
      
      private var _isMine:Boolean;
      
      private var _owner:String;
      
      private var _gridPosition:IntPoint;
      
      private var _state:int;
      
      public function Rod()
      {
         addFrameScript(0,this.frame1);
         super();
      }
      
      public function get isMine() : Boolean
      {
         return this._isMine;
      }
      
      public function set isMine(param1:Boolean) : void
      {
         this._isMine = param1;
      }
      
      public function get owner() : String
      {
         return this._owner;
      }
      
      public function set owner(param1:String) : void
      {
         this._owner = param1;
      }
      
      public function get gridPosition() : IntPoint
      {
         return this._gridPosition;
      }
      
      public function set gridPosition(param1:IntPoint) : void
      {
         this._gridPosition = param1;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

