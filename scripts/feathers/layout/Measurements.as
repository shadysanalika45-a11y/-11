package feathers.layout
{
   import feathers.core.IMeasureObject;
   import flash.Boot;
   import flash.display.DisplayObject;
   
   public class Measurements
   {
      
      public var width:Object;
      
      public var minWidth:Object;
      
      public var minHeight:Object;
      
      public var maxWidth:Object;
      
      public var maxHeight:Object;
      
      public var height:Object;
      
      public function Measurements(param1:DisplayObject = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         maxHeight = null;
         maxWidth = null;
         minHeight = null;
         minWidth = null;
         height = null;
         width = null;
         save(param1);
      }
      
      public function save(param1:DisplayObject = undefined) : void
      {
         var _loc2_:* = null as IMeasureObject;
         if(param1 == null)
         {
            width = null;
            height = null;
            minWidth = null;
            minHeight = null;
            maxWidth = null;
            maxHeight = null;
            return;
         }
         if(param1 is IMeasureObject)
         {
            _loc2_ = param1;
            width = _loc2_.get_explicitWidth();
            height = _loc2_.get_explicitHeight();
            minWidth = _loc2_.get_explicitMinWidth();
            minHeight = _loc2_.get_explicitMinHeight();
            maxWidth = _loc2_.get_explicitMaxWidth();
            maxHeight = _loc2_.get_explicitMaxHeight();
            return;
         }
         width = param1.width;
         height = param1.height;
         minWidth = width;
         minHeight = height;
         maxWidth = width;
         maxHeight = height;
      }
      
      public function restore(param1:DisplayObject) : void
      {
         var _loc2_:* = null as IMeasureObject;
         if(param1 is IMeasureObject)
         {
            _loc2_ = param1;
            if(width == null)
            {
               _loc2_.resetWidth();
            }
            else
            {
               _loc2_.width = width;
            }
            if(height == null)
            {
               _loc2_.resetHeight();
            }
            else
            {
               _loc2_.height = height;
            }
            if(minWidth == null)
            {
               _loc2_.resetMinWidth();
            }
            else
            {
               _loc2_.set_minWidth(minWidth);
            }
            if(minHeight == null)
            {
               _loc2_.resetMinHeight();
            }
            else
            {
               _loc2_.set_minHeight(minHeight);
            }
            if(maxWidth == null)
            {
               _loc2_.resetMaxWidth();
            }
            else
            {
               _loc2_.set_maxWidth(maxWidth);
            }
            if(maxHeight == null)
            {
               _loc2_.resetMaxHeight();
            }
            else
            {
               _loc2_.set_maxHeight(maxHeight);
            }
            return;
         }
         if(width != null)
         {
            param1.width = width;
         }
         if(height != null)
         {
            param1.height = height;
         }
      }
   }
}

