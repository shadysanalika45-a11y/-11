package com.oyunstudyosu.engine.grid
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.MapEntry;
   
   public class GridManager implements IGridManager
   {
      
      private var _maxAreaNo:int;
      
      private var _gridElementLists:Array;
      
      private var _sortedMapEntries:Array;
      
      private var grid:Array;
      
      private var gridDepth:int;
      
      private var gridWidth:int;
      
      private var scene:IScene;
      
      private var entryLen:uint;
      
      private var i:int;
      
      private var elementCount:int;
      
      private var j:int;
      
      private var w:int;
      
      private var d:int;
      
      private var lastx:int;
      
      private var lastz:int;
      
      private var lastGrid:GridVO;
      
      private var backArray:Array;
      
      private var childIndex:int;
      
      private var m:MapEntry;
      
      private var gridVO:GridVO;
      
      public function GridManager(param1:IScene)
      {
         super();
         this.scene = param1;
      }
      
      public function get maxAreaNo() : int
      {
         return _maxAreaNo;
      }
      
      public function set maxAreaNo(param1:int) : void
      {
         _maxAreaNo = param1;
      }
      
      public function get gridElementLists() : Array
      {
         return _gridElementLists;
      }
      
      public function set gridElementLists(param1:Array) : void
      {
         _gridElementLists = param1;
      }
      
      public function get sortedMapEntries() : Array
      {
         return _sortedMapEntries;
      }
      
      public function set sortedMapEntries(param1:Array) : void
      {
         _sortedMapEntries = param1;
      }
      
      public function addCharToNumberedCharArray(param1:int, param2:IsoElement) : void
      {
         if(param1 < 0 || param1 >= elementCount)
         {
            trace("FATAL ERROR : addCharToNumberedCharArray() : index[" + param1 + "]");
            return;
         }
         gridElementLists[param1].addChar(param2);
         setMustBeSortedToNumberedCharArray(param1);
      }
      
      public function doFixedObjectOperations() : void
      {
         var freeAreaNo:int;
         var sortedMapEntriesIndex:int;
         var me:MapEntry;
         var sortedMapEntriesLen:int;
         var backOperations4X:* = function():void
         {
            while(true)
            {
               if(backArray.length == 0)
               {
                  lastx = 0;
                  break;
               }
               me = backArray[backArray.length - 1];
               if(me.z + me.depth - 1 != lastz)
               {
                  lastx = me.x + me.width;
                  break;
               }
               backArray.pop();
            }
            lastz = lastz + 1;
         };
         trace("doFixedObjectOperations Game");
         entryLen = scene.mapEntries.length;
         initGrid();
         freeAreaNo = maxAreaNo;
         sortedMapEntries = [];
         sortedMapEntriesIndex = freeAreaNo - 1;
         i = 0;
         while(i < entryLen)
         {
            me = scene.mapEntries[i];
            w = 0;
            while(w < me.width)
            {
               d = 0;
               while(d < me.depth)
               {
                  if(me.entryType == 8)
                  {
                     setGridObj(me.x + w,me.z + d,new GridVO(false,null,-1));
                  }
                  else
                  {
                     setGridObj(me.x + w,me.z + d,new GridVO(true,me));
                  }
                  d = d + 1;
               }
               w = w + 1;
            }
            i = i + 1;
         }
         i = 0;
         while(i < gridDepth)
         {
            j = 0;
            while(j < gridWidth)
            {
               if(!getGridObj(j,i))
               {
                  setGridObj(j,i,new GridVO(false,null,-1));
               }
               j = j + 1;
            }
            i = i + 1;
         }
         lastx = 0;
         lastz = 0;
         backArray = [];
         do
         {
            lastGrid = getGridObj(lastx,lastz);
            if(!lastGrid)
            {
               return;
            }
            if(lastGrid.isFilled)
            {
               me = lastGrid.mapEntry;
               if(me.z + me.depth - 1 == lastz)
               {
                  freeAreaNo = freeAreaNo - 1;
                  lastGrid.freeAreaNo = sortedMapEntriesIndex;
                  sortedMapEntries[sortedMapEntriesIndex] = me;
                  sortedMapEntriesIndex = sortedMapEntriesIndex - 1;
                  backArray.push(me);
                  if(me.x + me.width >= gridWidth)
                  {
                     if(me.z + me.depth >= gridDepth)
                     {
                        break;
                     }
                  }
                  else
                  {
                     lastz = me.z;
                  }
                  lastx = me.x + me.width;
               }
               else
               {
                  backOperations4X();
               }
            }
            else
            {
               lastGrid.freeAreaNo = freeAreaNo;
               lastx = lastx + 1;
            }
            if(lastx == gridWidth)
            {
               backOperations4X();
            }
         }
         while(lastz != gridDepth);
         
         childIndex = 0;
         sortedMapEntriesLen = int(sortedMapEntries.length);
         i = 0;
         for(; i < sortedMapEntriesLen; i = i + 1)
         {
            m = sortedMapEntries[i] as MapEntry;
            if(m)
            {
               if(m.element != null)
               {
                  try
                  {
                     scene.elementsContainer.setChildIndex(m.element.container,childIndex);
                     childIndex = childIndex + 1;
                  }
                  catch(e:Error)
                  {
                     trace("error while setChildIndex()");
                  }
                  continue;
               }
            }
         }
      }
      
      public function enterFrameOperations() : void
      {
         elementCount = gridElementLists.length;
         i = 0;
         while(i < elementCount)
         {
            gridElementLists[i].sortAndUpdate();
            i = i + 1;
         }
      }
      
      public function getAreaNoFromGrid(param1:int, param2:int) : int
      {
         var _loc3_:GridVO = getGridObj(param1,param2);
         if(_loc3_)
         {
            return _loc3_.freeAreaNo;
         }
         return 0;
      }
      
      public function removeCharFromNumberedCharArray(param1:int, param2:IsoElement) : void
      {
         if(param1 < 0 || param1 >= elementCount)
         {
            return;
         }
         gridElementLists[param1].removeChar(param2);
      }
      
      public function setMustBeSortedToNumberedCharArray(param1:int) : void
      {
         if(param1 < 0 || param1 >= elementCount)
         {
            trace("FATAL ERROR : setMustBeSortedToNumberedCharArray() : index[" + param1 + "] elementCount:" + elementCount);
            return;
         }
         gridElementLists[param1].sortUpdate = true;
      }
      
      private function getGridObj(param1:int, param2:int) : GridVO
      {
         return grid[param1 + param2 * gridWidth];
      }
      
      private function initGrid() : void
      {
         var _loc2_:MapEntry = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         grid = [];
         gridWidth = scene.columnsCount;
         gridDepth = scene.rowsCount;
         var _loc1_:uint = 0;
         if(gridElementLists)
         {
            _loc4_ = 0;
            while(_loc4_ < gridElementLists.length)
            {
               gridElementLists[_loc4_].dispose();
               _loc4_++;
            }
         }
         gridElementLists = [];
         maxAreaNo = 0;
         _loc3_ = 0;
         while(_loc3_ < entryLen)
         {
            _loc2_ = scene.mapEntries[_loc3_];
            if(_loc2_.entryType != 8)
            {
               maxAreaNo = maxAreaNo + 1;
            }
            _loc3_++;
         }
         _loc5_ = 0;
         while(_loc5_ <= maxAreaNo)
         {
            gridElementLists.push(new GridElementList(_loc5_,scene));
            _loc5_++;
         }
         elementCount = gridElementLists.length;
      }
      
      private function setGridObj(param1:int, param2:int, param3:GridVO) : void
      {
         grid[param1 + param2 * gridWidth] = param3;
      }
   }
}

