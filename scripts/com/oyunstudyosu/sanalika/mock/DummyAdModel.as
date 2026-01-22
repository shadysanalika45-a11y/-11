package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.displayAd.IAdModel;
   import com.oyunstudyosu.engine.ICharacter;
   
   public class DummyAdModel implements IAdModel
   {
      
      public function DummyAdModel()
      {
         super();
      }
      
      public function displayBot(param1:Object) : ICharacter
      {
         return new DummyCharacter();
      }
   }
}

