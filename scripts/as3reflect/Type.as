package as3reflect
{
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   
   public class Type extends MetaDataContainer
   {
      
      public static const UNTYPED:as3reflect.Type = new as3reflect.Type();
      
      public static const PRIVATE:as3reflect.Type = new as3reflect.Type();
      
      public static const VOID:as3reflect.Type = new as3reflect.Type();
      
      private static var _cache:Object = {};
      
      private var _class:Class;
      
      private var _accessors:Array;
      
      private var _isStatic:Boolean;
      
      private var _fullName:String;
      
      private var _isFinal:Boolean;
      
      private var _isDynamic:Boolean;
      
      private var _staticConstants:Array;
      
      private var _constants:Array;
      
      private var _fields:Array;
      
      private var _name:String;
      
      private var _methods:Array;
      
      private var _variables:Array;
      
      private var _staticVariables:Array;
      
      public function Type()
      {
         super();
         this._methods = new Array();
         this._accessors = new Array();
         this._staticConstants = new Array();
         this._constants = new Array();
         this._staticVariables = new Array();
         this._variables = new Array();
         this._fields = new Array();
      }
      
      public static function forName(param1:String) : as3reflect.Type
      {
         var name:String = param1;
         var result:as3reflect.Type = null;
         switch(name)
         {
            case "void":
               result = as3reflect.Type.VOID;
               break;
            case "*":
               result = as3reflect.Type.UNTYPED;
               break;
            default:
               try
               {
                  result = as3reflect.Type.forClass(Class(getDefinitionByName(name)));
               }
               catch(e:ReferenceError)
               {
                  trace("Type.forName error: " + e.message + " The class \'" + name + "\' is probably an internal class or it may not have been compiled.");
               }
         }
         return result;
      }
      
      public static function forInstance(param1:*) : as3reflect.Type
      {
         var _loc2_:as3reflect.Type = null;
         var _loc3_:Class = ClassUtils.forInstance(param1);
         if(_loc3_ != null)
         {
            _loc2_ = as3reflect.Type.forClass(_loc3_);
         }
         return _loc2_;
      }
      
      public static function forClass(param1:Class) : as3reflect.Type
      {
         var _loc2_:as3reflect.Type = null;
         var _loc3_:XML = null;
         var _loc4_:String = ClassUtils.getFullyQualifiedName(param1);
         if(_cache[_loc4_])
         {
            _loc2_ = _cache[_loc4_];
         }
         else
         {
            _loc3_ = describeType(param1);
            _loc2_ = new as3reflect.Type();
            _cache[_loc4_] = _loc2_;
            _loc2_.fullName = _loc4_;
            _loc2_.name = ClassUtils.getNameFromFullyQualifiedName(_loc4_);
            _loc2_.clazz = param1;
            _loc2_.isDynamic = _loc3_.@isDynamic;
            _loc2_.isFinal = _loc3_.@isFinal;
            _loc2_.isStatic = _loc3_.@isStatic;
            _loc2_.accessors = TypeXmlParser.parseAccessors(_loc2_,_loc3_);
            _loc2_.methods = TypeXmlParser.parseMethods(_loc2_,_loc3_);
            _loc2_.staticConstants = TypeXmlParser.parseMembers(Constant,_loc3_.constant,_loc2_,true);
            _loc2_.constants = TypeXmlParser.parseMembers(Constant,_loc3_.factory.constant,_loc2_,false);
            _loc2_.staticVariables = TypeXmlParser.parseMembers(Variable,_loc3_.variable,_loc2_,true);
            _loc2_.variables = TypeXmlParser.parseMembers(Variable,_loc3_.factory.variable,_loc2_,false);
            TypeXmlParser.parseMetaData(_loc3_.factory[0].metadata,_loc2_);
         }
         return _loc2_;
      }
      
      public function get staticConstants() : Array
      {
         return this._staticConstants;
      }
      
      public function set staticConstants(param1:Array) : void
      {
         this._staticConstants = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get accessors() : Array
      {
         return this._accessors;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function set accessors(param1:Array) : void
      {
         this._accessors = param1;
      }
      
      public function set constants(param1:Array) : void
      {
         this._constants = param1;
      }
      
      public function get staticVariables() : Array
      {
         return this._staticVariables;
      }
      
      public function get methods() : Array
      {
         return this._methods;
      }
      
      public function get isDynamic() : Boolean
      {
         return this._isDynamic;
      }
      
      public function set clazz(param1:Class) : void
      {
         this._class = param1;
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
      
      public function get fullName() : String
      {
         return this._fullName;
      }
      
      public function get fields() : Array
      {
         return this.accessors.concat(this.staticConstants).concat(this.constants).concat(this.staticVariables).concat(this.variables);
      }
      
      public function getField(param1:String) : Field
      {
         var _loc2_:Field = null;
         var _loc3_:Field = null;
         for each(_loc3_ in this.fields)
         {
            if(_loc3_.name == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get constants() : Array
      {
         return this._constants;
      }
      
      public function set staticVariables(param1:Array) : void
      {
         this._staticVariables = param1;
      }
      
      public function getMethod(param1:String) : Method
      {
         var _loc2_:Method = null;
         var _loc3_:Method = null;
         for each(_loc3_ in this.methods)
         {
            if(_loc3_.name == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get clazz() : Class
      {
         return this._class;
      }
      
      public function set methods(param1:Array) : void
      {
         this._methods = param1;
      }
      
      public function set isFinal(param1:Boolean) : void
      {
         this._isFinal = param1;
      }
      
      public function set isDynamic(param1:Boolean) : void
      {
         this._isDynamic = param1;
      }
      
      public function set variables(param1:Array) : void
      {
         this._variables = param1;
      }
      
      public function set isStatic(param1:Boolean) : void
      {
         this._isStatic = param1;
      }
      
      public function set fullName(param1:String) : void
      {
         this._fullName = param1;
      }
      
      public function get isFinal() : Boolean
      {
         return this._isFinal;
      }
      
      public function get variables() : Array
      {
         return this._variables;
      }
   }
}

class TypeXmlParser
{
   
   public function TypeXmlParser()
   {
      super();
   }
   
   public static function parseMetaData(param1:XMLList, param2:IMetaDataContainer) : void
   {
      var _loc3_:XML = null;
      var _loc4_:Array = null;
      var _loc5_:XML = null;
      for each(_loc3_ in param1)
      {
         _loc4_ = [];
         for each(_loc5_ in _loc3_.arg)
         {
            _loc4_.push(new MetaDataArgument(_loc5_.@key,_loc5_.@value));
         }
         param2.addMetaData(new MetaData(_loc3_.@name,_loc4_));
      }
   }
   
   public static function parseMembers(param1:Class, param2:XMLList, param3:Type, param4:Boolean) : Array
   {
      var _loc5_:XML = null;
      var _loc6_:IMember = null;
      var _loc7_:Array = [];
      for each(_loc5_ in param2)
      {
         _loc6_ = new param1(_loc5_.@name,Type.forName(_loc5_.@type),param3,param4);
         parseMetaData(_loc5_.metadata,_loc6_);
         _loc7_.push(_loc6_);
      }
      return _loc7_;
   }
   
   private static function parseAccessorsByModifier(param1:Type, param2:XMLList, param3:Boolean) : Array
   {
      var _loc4_:XML = null;
      var _loc5_:Accessor = null;
      var _loc6_:Array = [];
      for each(_loc4_ in param2)
      {
         _loc5_ = new Accessor(_loc4_.@name,AccessorAccess.fromString(_loc4_.@access),Type.forName(_loc4_.@type),param1,param3);
         parseMetaData(_loc4_.metadata,_loc5_);
         _loc6_.push(_loc5_);
      }
      return _loc6_;
   }
   
   public static function parseAccessors(param1:Type, param2:XML) : Array
   {
      var _loc3_:Array = parseAccessorsByModifier(param1,param2.accessor,true);
      var _loc4_:Array = parseAccessorsByModifier(param1,param2.factory.accessor,false);
      return _loc3_.concat(_loc4_);
   }
   
   private static function parseMethodsByModifier(param1:Type, param2:XMLList, param3:Boolean) : Array
   {
      var _loc4_:XML = null;
      var _loc5_:Array = null;
      var _loc6_:XML = null;
      var _loc7_:Method = null;
      var _loc8_:Type = null;
      var _loc9_:Parameter = null;
      var _loc10_:Array = [];
      for each(_loc4_ in param2)
      {
         _loc5_ = [];
         for each(_loc6_ in _loc4_.parameter)
         {
            _loc8_ = Type.forName(_loc6_.@type);
            _loc9_ = new Parameter(_loc6_.@index,_loc8_,_loc6_.@optional);
            _loc5_.push(_loc9_);
         }
         _loc7_ = new Method(param1,_loc4_.@name,param3,_loc5_,Type.forName(_loc4_.@returnType));
         parseMetaData(_loc4_.metadata,_loc7_);
         _loc10_.push(_loc7_);
      }
      return _loc10_;
   }
   
   public static function parseMethods(param1:Type, param2:XML) : Array
   {
      var _loc3_:Array = parseMethodsByModifier(param1,param2.method,true);
      var _loc4_:Array = parseMethodsByModifier(param1,param2.factory.method,false);
      return _loc3_.concat(_loc4_);
   }
}
