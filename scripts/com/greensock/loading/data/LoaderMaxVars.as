package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   
   public class LoaderMaxVars
   {
      
      public static const version:Number = 1.1;
      
      protected var _vars:Object;
      
      public function LoaderMaxVars(param1:Object = null)
      {
         var _loc2_:String = null;
         super();
         this._vars = {};
         if(param1 != null)
         {
            for(_loc2_ in param1)
            {
               this._vars[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      protected function _set(param1:String, param2:*) : LoaderMaxVars
      {
         if(param2 == null)
         {
            delete this._vars[param1];
         }
         else
         {
            this._vars[param1] = param2;
         }
         return this;
      }
      
      public function prop(param1:String, param2:*) : LoaderMaxVars
      {
         return this._set(param1,param2);
      }
      
      public function autoDispose(param1:Boolean) : LoaderMaxVars
      {
         return this._set("autoDispose",param1);
      }
      
      public function autoLoad(param1:Boolean) : LoaderMaxVars
      {
         return this._set("autoLoad",param1);
      }
      
      public function name(param1:String) : LoaderMaxVars
      {
         return this._set("name",param1);
      }
      
      public function onCancel(param1:Function) : LoaderMaxVars
      {
         return this._set("onCancel",param1);
      }
      
      public function onComplete(param1:Function) : LoaderMaxVars
      {
         return this._set("onComplete",param1);
      }
      
      public function onError(param1:Function) : LoaderMaxVars
      {
         return this._set("onError",param1);
      }
      
      public function onFail(param1:Function) : LoaderMaxVars
      {
         return this._set("onFail",param1);
      }
      
      public function onHTTPStatus(param1:Function) : LoaderMaxVars
      {
         return this._set("onHTTPStatus",param1);
      }
      
      public function onIOError(param1:Function) : LoaderMaxVars
      {
         return this._set("onIOError",param1);
      }
      
      public function onOpen(param1:Function) : LoaderMaxVars
      {
         return this._set("onOpen",param1);
      }
      
      public function onProgress(param1:Function) : LoaderMaxVars
      {
         return this._set("onProgress",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : LoaderMaxVars
      {
         return this._set("requireWithRoot",param1);
      }
      
      public function auditSize(param1:Boolean) : LoaderMaxVars
      {
         return this._set("auditSize",param1);
      }
      
      public function maxConnections(param1:uint) : LoaderMaxVars
      {
         return this._set("maxConnections",param1);
      }
      
      public function skipFailed(param1:Boolean) : LoaderMaxVars
      {
         return this._set("skipFailed",param1);
      }
      
      public function skipPaused(param1:Boolean) : LoaderMaxVars
      {
         return this._set("skipPaused",param1);
      }
      
      public function loaders(param1:Array) : LoaderMaxVars
      {
         return this._set("loaders",param1);
      }
      
      public function onChildOpen(param1:Function) : LoaderMaxVars
      {
         return this._set("onChildOpen",param1);
      }
      
      public function onChildProgress(param1:Function) : LoaderMaxVars
      {
         return this._set("onChildProgress",param1);
      }
      
      public function onChildComplete(param1:Function) : LoaderMaxVars
      {
         return this._set("onChildComplete",param1);
      }
      
      public function onChildCancel(param1:Function) : LoaderMaxVars
      {
         return this._set("onChildCancel",param1);
      }
      
      public function onChildFail(param1:Function) : LoaderMaxVars
      {
         return this._set("onChildFail",param1);
      }
      
      public function onScriptAccessDenied(param1:Function) : LoaderMaxVars
      {
         return this._set("onScriptAccessDenied",param1);
      }
      
      public function get vars() : Object
      {
         return this._vars;
      }
      
      public function get isGSVars() : Boolean
      {
         return true;
      }
   }
}

