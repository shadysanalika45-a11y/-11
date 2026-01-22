package feathers.layout
{
   import flash.geom.Point;
   
   public interface IScrollLayout extends ILayout
   {
      
      function set_scrollY(param1:Number) : Number;
      
      function set scrollY(param1:Number) : void;
      
      function set_scrollX(param1:Number) : Number;
      
      function set scrollX(param1:Number) : void;
      
      function get_scrollY() : Number;
      
      function get scrollY() : Number;
      
      function get_scrollX() : Number;
      
      function get scrollX() : Number;
      
      function get_elasticTop() : Boolean;
      
      function get elasticTop() : Boolean;
      
      function get_elasticRight() : Boolean;
      
      function get elasticRight() : Boolean;
      
      function get_elasticLeft() : Boolean;
      
      function get elasticLeft() : Boolean;
      
      function get_elasticBottom() : Boolean;
      
      function get elasticBottom() : Boolean;
      
      function getNearestScrollPositionForIndex(param1:int, param2:int, param3:Number, param4:Number, param5:Point = undefined) : Point;
   }
}

