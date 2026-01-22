package as3reflect
{
   public class Parameter
   {
      
      private var _type:Type;
      
      private var _index:int;
      
      private var _isOptional:Boolean;
      
      public function Parameter(param1:int, param2:Type, param3:Boolean = false)
      {
         super();
         this._index = param1;
         this._type = param2;
         this._isOptional = param3;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get isOptional() : Boolean
      {
         return this._isOptional;
      }
      
      public function get type() : Type
      {
         return this._type;
      }
   }
}

