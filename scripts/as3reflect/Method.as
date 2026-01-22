package as3reflect
{
   import flash.utils.Proxy;
   
   public class Method extends MetaDataContainer
   {
      
      private var _declaringType:as3reflect.Type;
      
      private var _parameters:Array;
      
      private var _name:String;
      
      private var _returnType:as3reflect.Type;
      
      private var _isStatic:Boolean;
      
      public function Method(param1:as3reflect.Type, param2:String, param3:Boolean, param4:Array, param5:*, param6:Array = null)
      {
         super(param6);
         this._declaringType = param1;
         this._name = param2;
         this._isStatic = param3;
         this._parameters = param4;
         this._returnType = param5;
      }
      
      public function get declaringType() : as3reflect.Type
      {
         return this._declaringType;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function toString() : String
      {
         return "[Method(name:\'" + this.name + "\', isStatic:" + this.isStatic + ")]";
      }
      
      public function get returnType() : as3reflect.Type
      {
         return this._returnType;
      }
      
      public function invoke(param1:*, param2:Array) : *
      {
         var _loc3_:* = undefined;
         if(!(param1 is Proxy))
         {
            _loc3_ = param1[this.name].apply(param1,param2);
         }
         return _loc3_;
      }
      
      public function get parameters() : Array
      {
         return this._parameters;
      }
      
      public function get fullName() : String
      {
         var _loc1_:Parameter = null;
         var _loc2_:String = "public ";
         if(this.isStatic)
         {
            _loc2_ += "static ";
         }
         _loc2_ += this.name + "(";
         var _loc3_:int = 0;
         while(_loc3_ < this.parameters.length)
         {
            _loc1_ = this.parameters[_loc3_] as Parameter;
            _loc2_ += _loc1_.type.name;
            _loc2_ += _loc3_ < this.parameters.length - 1 ? ", " : "";
            _loc3_++;
         }
         return _loc2_ + ("):" + this.returnType.name);
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
   }
}

