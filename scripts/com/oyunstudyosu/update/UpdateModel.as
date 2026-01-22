package com.oyunstudyosu.update
{
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdateGroup;
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdateModel;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   
   public class UpdateModel implements IUpdateModel
   {
      
      private var updateGroups:Dictionary;
      
      private var stage:Stage;
      
      public function UpdateModel()
      {
         super();
         updateGroups = new Dictionary();
         this.stage = Sanalika.instance.layerModel.stage;
      }
      
      public function createGroup(param1:int) : IUpdateGroup
      {
         var _loc2_:IUpdateGroup = null;
         if(this.updateGroups[param1] == null)
         {
            _loc2_ = new UpdateGroup(stage,param1);
            updateGroups[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function getGroup(param1:int) : IUpdateGroup
      {
         if(updateGroups[param1] != null)
         {
            return updateGroups[param1];
         }
         return createGroup(param1);
      }
   }
}

