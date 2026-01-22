package com.oyunstudyosu.ground
{
   import com.oyunstudyosu.engine.core.objects.EntryObject;
   
   public class GroundObject extends EntryObject
   {
      
      public var groundData:GroundObjectData;
      
      private var loadCommand:LoadGroundObjectCommand;
      
      public function GroundObject()
      {
         super();
      }
      
      public function init(param1:GroundObjectData) : void
      {
         this.groundData = param1;
         super.initEntry(param1.clip + "_" + param1.posX.toString() + "_" + param1.posY.toString(),Sanalika.instance.engine.scene);
         add2Scene();
         setObjectPosition(param1.posX,param1.posY);
         loadCommand = new LoadGroundObjectCommand(this);
         loadCommand.execute();
      }
      
      public function collect() : void
      {
         dispose();
         super.dispose();
      }
   }
}

