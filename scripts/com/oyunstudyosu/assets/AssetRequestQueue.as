package com.oyunstudyosu.assets
{
   public class AssetRequestQueue
   {
      
      private var _isCompleted:Boolean = false;
      
      private var __queue:Array;
      
      private var _successCount:int = 0;
      
      private var _errorCount:int = 0;
      
      public var callback:Function;
      
      public var progress:Function;
      
      public function AssetRequestQueue(param1:Array = null)
      {
         super();
         this.__queue = [];
         if(param1 != null)
         {
            this.addAll(param1);
         }
      }
      
      public function get isCompleted() : Boolean
      {
         return this._isCompleted;
      }
      
      public function get queue() : Array
      {
         return this.__queue;
      }
      
      public function get percent() : int
      {
         return int(this.loadedResourceCount / this.total * 100);
      }
      
      public function get total() : int
      {
         return this.__queue.length;
      }
      
      public function get loadedResourceCount() : int
      {
         return this._successCount + this._errorCount;
      }
      
      public function get successCount() : int
      {
         return this._successCount;
      }
      
      public function get errorCount() : int
      {
         return this._errorCount;
      }
      
      private function __checkCallbackState() : void
      {
         var _loc1_:IAssetRequest = null;
         if(this.progress != null)
         {
            this.progress(this);
         }
         if(this.loadedResourceCount == this.total)
         {
            if(this.callback != null)
            {
               this.callback(this);
            }
            this._isCompleted = true;
            for each(_loc1_ in this.queue)
            {
               _loc1_.dispose();
            }
         }
      }
      
      private function __errorFunction(param1:AssetRequest) : void
      {
         param1.error = true;
         ++this._errorCount;
         this.__checkCallbackState();
      }
      
      private function __loadedFunction(param1:AssetRequest) : void
      {
         param1.error = false;
         ++this._successCount;
         this.__checkCallbackState();
      }
      
      public function addAll(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AssetRequest = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            this.add(_loc3_);
            _loc2_++;
         }
      }
      
      public function add(param1:AssetRequest) : void
      {
         if(param1.loadedFunction != null || param1.errorFunction != null || param1.progressFunction != null)
         {
            throw "Requestqueue does not support AssetRequest callbacks.";
         }
         if(this.callback != null)
         {
            throw "Callback required";
         }
         param1.isQueueRequest = true;
         param1.loadedFunction = this.__loadedFunction;
         param1.errorFunction = this.__errorFunction;
         this.__queue.push(param1);
      }
      
      public function dispose() : *
      {
         var _loc2_:AssetRequest = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.__queue.length)
         {
            _loc2_ = this.__queue[_loc1_];
            _loc2_.dispose();
            _loc1_++;
         }
         this.__queue = [];
         this.progress = null;
         this.callback = null;
      }
   }
}

