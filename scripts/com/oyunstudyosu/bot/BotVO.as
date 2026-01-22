package com.oyunstudyosu.bot
{
   import com.oyunstudyosu.door.IProperty;
   import flash.utils.getDefinitionByName;
   
   public class BotVO implements IBotVO
   {
      
      private var _onClick:Function;
      
      private var _metaKey:String;
      
      private var _nick:String;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _length:int;
      
      private var _version:int;
      
      private var _definition:String;
      
      private var _property:IProperty;
      
      private var _speechProperty:IProperty;
      
      private var _isStatic:Boolean = false;
      
      public function BotVO()
      {
         super();
      }
      
      public function get onClick() : Function
      {
         return this._onClick;
      }
      
      public function set onClick(param1:Function) : void
      {
         if(this._onClick == param1)
         {
            return;
         }
         this._onClick = param1;
      }
      
      public function get metaKey() : String
      {
         return this._metaKey;
      }
      
      public function set metaKey(param1:String) : void
      {
         if(this._metaKey == param1)
         {
            return;
         }
         this._metaKey = param1;
      }
      
      public function get nick() : String
      {
         return this._nick;
      }
      
      public function set nick(param1:String) : void
      {
         if(this._nick == param1)
         {
            return;
         }
         this._nick = param1;
      }
      
      public function get x() : int
      {
         return this._x;
      }
      
      public function set x(param1:int) : void
      {
         if(this._x == param1)
         {
            return;
         }
         this._x = param1;
      }
      
      public function get y() : int
      {
         return this._y;
      }
      
      public function set y(param1:int) : void
      {
         if(this._y == param1)
         {
            return;
         }
         this._y = param1;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function set width(param1:int) : void
      {
         if(this._width == param1)
         {
            return;
         }
         this._width = param1;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function set height(param1:int) : void
      {
         if(this._height == param1)
         {
            return;
         }
         this._height = param1;
      }
      
      public function get length() : int
      {
         return this._length;
      }
      
      public function set length(param1:int) : void
      {
         if(this._length == param1)
         {
            return;
         }
         this._length = param1;
      }
      
      public function get version() : int
      {
         return this._version;
      }
      
      public function set version(param1:int) : void
      {
         if(this._version == param1)
         {
            return;
         }
         this._version = param1;
      }
      
      public function get definition() : String
      {
         return this._definition;
      }
      
      public function set definition(param1:String) : void
      {
         if(this._definition == param1)
         {
            return;
         }
         this._definition = param1;
      }
      
      public function get property() : IProperty
      {
         return this._property;
      }
      
      public function setProperty(param1:Object) : void
      {
         var type:Class = null;
         var value:Object = param1;
         if(value == null)
         {
            trace("No bot property for " + this.metaKey);
            return;
         }
         try
         {
            type = getDefinitionByName("com.oyunstudyosu.property." + value.cn) as Class;
         }
         catch(error:Error)
         {
            trace("No class found named" + value.cn);
            return;
         }
         this._property = new type();
         value.type = "bot";
         value.metaKey = this.metaKey;
         this._property.data = value;
      }
      
      public function get speechProperty() : IProperty
      {
         return this._speechProperty;
      }
      
      public function setSpeechProperty(param1:Object) : void
      {
         var type:Class = null;
         var value:Object = param1;
         if(value == null)
         {
            trace("No bot speech for " + this.metaKey);
            return;
         }
         try
         {
            type = getDefinitionByName("com.oyunstudyosu.property." + value.cn) as Class;
         }
         catch(error:Error)
         {
            trace("No class found named" + value.cn);
            return;
         }
         this._speechProperty = new type();
         value.type = "bot";
         value.metaKey = this.metaKey;
         this._speechProperty.data = value;
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
      
      public function set isStatic(param1:Boolean) : void
      {
         if(this._isStatic == param1)
         {
            return;
         }
         this._isStatic = param1;
      }
      
      public function dispose() : void
      {
         if(this._property)
         {
            this._property.dispose();
         }
         if(this._speechProperty)
         {
            this._speechProperty.dispose();
         }
      }
   }
}

