package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.system.LoaderContext;
   
   public class ImageLoaderVars
   {
      
      public static const version:Number = 1.22;
      
      protected var _vars:Object;
      
      public function ImageLoaderVars(param1:Object = null)
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
      
      protected function _set(param1:String, param2:*) : ImageLoaderVars
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
      
      public function prop(param1:String, param2:*) : ImageLoaderVars
      {
         return this._set(param1,param2);
      }
      
      public function autoDispose(param1:Boolean) : ImageLoaderVars
      {
         return this._set("autoDispose",param1);
      }
      
      public function name(param1:String) : ImageLoaderVars
      {
         return this._set("name",param1);
      }
      
      public function onCancel(param1:Function) : ImageLoaderVars
      {
         return this._set("onCancel",param1);
      }
      
      public function onComplete(param1:Function) : ImageLoaderVars
      {
         return this._set("onComplete",param1);
      }
      
      public function onError(param1:Function) : ImageLoaderVars
      {
         return this._set("onError",param1);
      }
      
      public function onFail(param1:Function) : ImageLoaderVars
      {
         return this._set("onFail",param1);
      }
      
      public function onHTTPStatus(param1:Function) : ImageLoaderVars
      {
         return this._set("onHTTPStatus",param1);
      }
      
      public function onIOError(param1:Function) : ImageLoaderVars
      {
         return this._set("onIOError",param1);
      }
      
      public function onOpen(param1:Function) : ImageLoaderVars
      {
         return this._set("onOpen",param1);
      }
      
      public function onProgress(param1:Function) : ImageLoaderVars
      {
         return this._set("onProgress",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : ImageLoaderVars
      {
         return this._set("requireWithRoot",param1);
      }
      
      public function alternateURL(param1:String) : ImageLoaderVars
      {
         return this._set("alternateURL",param1);
      }
      
      public function estimatedBytes(param1:uint) : ImageLoaderVars
      {
         return this._set("estimatedBytes",param1);
      }
      
      public function noCache(param1:Boolean) : ImageLoaderVars
      {
         return this._set("noCache",param1);
      }
      
      public function allowMalformedURL(param1:Boolean) : ImageLoaderVars
      {
         return this._set("allowMalformedURL",param1);
      }
      
      public function alpha(param1:Number) : ImageLoaderVars
      {
         return this._set("alpha",param1);
      }
      
      public function bgAlpha(param1:Number) : ImageLoaderVars
      {
         return this._set("bgAlpha",param1);
      }
      
      public function bgColor(param1:uint) : ImageLoaderVars
      {
         return this._set("bgColor",param1);
      }
      
      public function blendMode(param1:String) : ImageLoaderVars
      {
         return this._set("blendMode",param1);
      }
      
      public function centerRegistration(param1:Boolean) : ImageLoaderVars
      {
         return this._set("centerRegistration",param1);
      }
      
      public function container(param1:DisplayObjectContainer) : ImageLoaderVars
      {
         return this._set("container",param1);
      }
      
      public function context(param1:LoaderContext) : ImageLoaderVars
      {
         return this._set("context",param1);
      }
      
      public function crop(param1:Boolean) : ImageLoaderVars
      {
         return this._set("crop",param1);
      }
      
      public function hAlign(param1:String) : ImageLoaderVars
      {
         return this._set("hAlign",param1);
      }
      
      public function height(param1:Number) : ImageLoaderVars
      {
         return this._set("height",param1);
      }
      
      public function onSecurityError(param1:Function) : ImageLoaderVars
      {
         return this._set("onSecurityError",param1);
      }
      
      public function rotation(param1:Number) : ImageLoaderVars
      {
         return this._set("rotation",param1);
      }
      
      public function rotationX(param1:Number) : ImageLoaderVars
      {
         return this._set("rotationX",param1);
      }
      
      public function rotationY(param1:Number) : ImageLoaderVars
      {
         return this._set("rotationY",param1);
      }
      
      public function rotationZ(param1:Number) : ImageLoaderVars
      {
         return this._set("rotationZ",param1);
      }
      
      public function scaleMode(param1:String) : ImageLoaderVars
      {
         return this._set("scaleMode",param1);
      }
      
      public function scaleX(param1:Number) : ImageLoaderVars
      {
         return this._set("scaleX",param1);
      }
      
      public function scaleY(param1:Number) : ImageLoaderVars
      {
         return this._set("scaleY",param1);
      }
      
      public function vAlign(param1:String) : ImageLoaderVars
      {
         return this._set("vAlign",param1);
      }
      
      public function visible(param1:Boolean) : ImageLoaderVars
      {
         return this._set("visible",param1);
      }
      
      public function width(param1:Number) : ImageLoaderVars
      {
         return this._set("width",param1);
      }
      
      public function x(param1:Number) : ImageLoaderVars
      {
         return this._set("x",param1);
      }
      
      public function y(param1:Number) : ImageLoaderVars
      {
         return this._set("y",param1);
      }
      
      public function z(param1:Number) : ImageLoaderVars
      {
         return this._set("z",param1);
      }
      
      public function smoothing(param1:Boolean) : ImageLoaderVars
      {
         return this._set("smoothing",param1);
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

