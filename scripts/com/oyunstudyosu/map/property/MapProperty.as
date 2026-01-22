package com.oyunstudyosu.map.property
{
   import com.oyunstudyosu.engine.core.MapEntry;
   
   public class MapProperty
   {
      
      public var disposed:Boolean = false;
      
      public var entry:MapEntry;
      
      public var data:Object;
      
      public function MapProperty()
      {
         super();
      }
      
      public function execute() : void
      {
         throw new Error("You have to implement MapProperty.execute()!!");
      }
      
      public function dispose() : void
      {
         disposed = true;
         data = null;
         entry = null;
      }
   }
}

