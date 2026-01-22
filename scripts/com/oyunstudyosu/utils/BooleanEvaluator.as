package com.oyunstudyosu.utils
{
   public class BooleanEvaluator
   {
      
      public function BooleanEvaluator()
      {
         super();
      }
      
      public static function evaluate(param1:String, param2:Object) : Boolean
      {
         var _loc3_:BooleanEvaluatorParser = new BooleanEvaluatorParser(param1,param2);
         return _loc3_.parse();
      }
   }
}

class BooleanEvaluatorParser
{
   
   private var expr:String;
   
   private var flags:Object;
   
   private var index:int;
   
   private var length:int;
   
   public function BooleanEvaluatorParser(param1:String, param2:Object)
   {
      super();
      this.expr = param1;
      this.flags = param2;
      this.index = 0;
      this.length = param1.length;
   }
   
   public function parse() : Boolean
   {
      return this.parseExpression();
   }
   
   private function skipWhitespace() : void
   {
      while(this.index < this.length && Boolean(/\s/.test(this.expr.charAt(this.index))))
      {
         ++this.index;
      }
   }
   
   private function parseIdentifier() : String
   {
      this.skipWhitespace();
      var _loc1_:int = int(this.index);
      while(this.index < this.length && Boolean(/\w/.test(this.expr.charAt(this.index))))
      {
         ++this.index;
      }
      return this.expr.substring(_loc1_,this.index);
   }
   
   private function parseFactor() : Boolean
   {
      var _loc1_:Boolean = false;
      var _loc2_:String = null;
      var _loc3_:String = null;
      this.skipWhitespace();
      if(this.index < this.length && this.expr.charAt(this.index) == "!")
      {
         ++this.index;
         return !this.parseFactor();
      }
      if(this.index < this.length && this.expr.charAt(this.index) == "(")
      {
         ++this.index;
         _loc1_ = Boolean(this.parseExpression());
         this.skipWhitespace();
         if(this.index >= this.length || this.expr.charAt(this.index) != ")")
         {
            throw new Error("Kapanan parantez eksik.");
         }
         ++this.index;
         return _loc1_;
      }
      _loc2_ = this.parseIdentifier();
      _loc3_ = _loc2_.toLowerCase();
      if(_loc3_ == "true")
      {
         return true;
      }
      if(_loc3_ == "false")
      {
         return false;
      }
      if(!(_loc2_ in this.flags))
      {
         trace("Uyarı: \'" + _loc2_ + "\' tanımlı değil, false varsayıldı.");
         return false;
      }
      return Boolean(this.flags[_loc2_]);
   }
   
   private function parseTerm() : Boolean
   {
      var _loc1_:Boolean = Boolean(this.parseFactor());
      this.skipWhitespace();
      while(this.index < this.length - 1 && this.expr.substr(this.index,2) == "&&")
      {
         this.index += 2;
         _loc1_ &&= Boolean(this.parseFactor());
         this.skipWhitespace();
      }
      return _loc1_;
   }
   
   private function parseExpression() : Boolean
   {
      var _loc1_:Boolean = Boolean(this.parseTerm());
      this.skipWhitespace();
      while(this.index < this.length - 1 && this.expr.substr(this.index,2) == "||")
      {
         this.index += 2;
         _loc1_ ||= Boolean(this.parseTerm());
         this.skipWhitespace();
      }
      return _loc1_;
   }
}
