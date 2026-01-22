package com.oyunstudyosu.engine.scene.vo
{
   import flash.utils.getTimer;
   
   public class DragVo
   {
      
      public static const minimumDragLength:Number = 150;
      
      public var isEnabled:Boolean = true;
      
      public var isActive:Boolean = false;
      
      public var mouseX:Number;
      
      public var mouseY:Number;
      
      public var containerX:Number;
      
      public var containerY:Number;
      
      public var lastMouseX:Object = null;
      
      public var lastMouseY:Object = null;
      
      public var timeout:int = 0;
      
      public function DragVo()
      {
         super();
      }
      
      public function get timeoutEnabled() : Boolean
      {
         if(Math.round(getTimer() * 1000) > this.timeout)
         {
            return false;
         }
         return true;
      }
      
      public function set timeoutEnabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.timeout = Math.round(getTimer() * 1000) + 100;
         }
         else
         {
            this.timeout = 0;
         }
      }
   }
}

