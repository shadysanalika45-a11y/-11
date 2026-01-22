package de.polygonal.ds
{
   public interface Itr
   {
      
      function reset() : Itr;
      
      function remove() : void;
      
      function next() : Object;
      
      function hasNext() : Boolean;
   }
}

