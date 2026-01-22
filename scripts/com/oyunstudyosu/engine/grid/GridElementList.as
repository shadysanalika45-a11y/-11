package com.oyunstudyosu.engine.grid
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   
   public class GridElementList
   {
      
      private var blockNo:int;
      
      public var sortUpdate:Boolean;
      
      private var members:Array;
      
      private var memberCount:int;
      
      private var i:int;
      
      private var mEntry:MapEntry;
      
      private var indexStart:int;
      
      private var index:int;
      
      private var isChanged:Boolean;
      
      private var scene:IScene;
      
      public function GridElementList(param1:int, param2:IScene)
      {
         super();
         members = [];
         this.scene = param2;
         this.blockNo = param1;
      }
      
      public function dispose() : void
      {
         scene = null;
         mEntry = null;
         members = null;
      }
      
      public function addChar(param1:IsoElement) : void
      {
         members.push(param1);
         memberCount = members.length;
         members.sort(membersSort);
         fixPosition();
         sortUpdate = true;
      }
      
      public function removeChar(param1:IsoElement) : void
      {
         index = members.indexOf(param1);
         if(index == -1)
         {
            trace("ERROR : GridElementList : removeChar(" + param1.id + ")");
            return;
         }
         members.splice(index,1);
         memberCount = members.length;
         members.sort(membersSort);
         fixPosition();
         isChanged = true;
      }
      
      public function sortAndUpdate() : void
      {
         if(!sortUpdate)
         {
            return;
         }
         members.sort(membersSort);
         fixPosition();
      }
      
      private function membersSort(param1:IsoElement, param2:IsoElement) : *
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.depth < param2.depth)
         {
            return -1;
         }
         if(param1.depth > param2.depth)
         {
            return 1;
         }
         if(param1.depth == param2.depth)
         {
            if(param1.id == Connectr.instance.avatarModel.avatarId)
            {
               return 1;
            }
            if(param2.id == Connectr.instance.avatarModel.avatarId)
            {
               return -1;
            }
            _loc3_ = parseInt(param1.id);
            _loc4_ = parseInt(param2.id);
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            if(_loc3_ > _loc4_)
            {
               return 1;
            }
         }
         return 0;
      }
      
      private function fixPosition() : void
      {
         if(blockNo == 0)
         {
            indexStart = 0;
         }
         else
         {
            mEntry = scene.gridManager.sortedMapEntries[blockNo - 1];
            if(mEntry == null)
            {
               return;
            }
            indexStart = scene.elementsContainer.getChildIndex(mEntry.element.container) + 1;
         }
         i = 0;
         while(i < memberCount)
         {
            if(members[i].movedFromBackAreas)
            {
               indexStart = indexStart - 1;
               members[i].movedFromBackAreas = false;
            }
            try
            {
               scene.elementsContainer.setChildIndex(members[i].container,indexStart + i);
            }
            catch(error:Error)
            {
            }
            i = i + 1;
         }
         sortUpdate = false;
      }
   }
}

