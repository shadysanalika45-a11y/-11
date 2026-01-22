package feathers.layout
{
   public interface ISnapLayout extends ILayout
   {
      
      function getSnapPositionsY(param1:Array, param2:Number, param3:Number, param4:Array = undefined) : Array;
      
      function getSnapPositionsX(param1:Array, param2:Number, param3:Number, param4:Array = undefined) : Array;
   }
}

