package com.oyunstudyosu.utils
{
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextFieldManager
   {
      
      public function TextFieldManager()
      {
         super();
      }
      
      public static function convertAsArabicTextField(param1:TextField, param2:Boolean = true, param3:Boolean = true) : STextField
      {
         var _loc7_:STextField = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:int = param1.parent.getChildIndex(param1);
         var _loc5_:TextFormat = param1.defaultTextFormat;
         var _loc6_:Array = param1.filters;
         _loc7_ = new STextField(param2,param3);
         if(_loc6_ != null)
         {
            _loc7_.filters = _loc6_;
         }
         _loc7_.x = param1.x;
         _loc7_.y = param1.y;
         _loc7_.width = param1.width + 2;
         _loc7_.height = param1.height;
         _loc7_.type = param1.type;
         _loc7_.antiAliasType = AntiAliasType.ADVANCED;
         _loc7_.gridFitType = GridFitType.SUBPIXEL;
         _loc7_.sharpness = param1.sharpness;
         _loc7_.thickness = param1.thickness;
         _loc7_.embedFonts = true;
         _loc7_.defaultTextFormat = _loc5_;
         param1.parent.addChildAt(_loc7_,_loc4_);
         param1.parent.removeChild(param1);
         param1 = null;
         return _loc7_;
      }
      
      public static function createNoneLanguageTextfield(param1:TextField) : TextField
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = param1.parent.getChildIndex(param1);
         var _loc3_:TextFormat = param1.defaultTextFormat;
         var _loc4_:Array = param1.filters;
         var _loc5_:TextField = new TextField();
         if(_loc4_ != null)
         {
            _loc5_.filters = _loc4_;
         }
         _loc5_.x = param1.x;
         _loc5_.y = param1.y;
         _loc5_.width = param1.width + 2;
         _loc5_.height = param1.height;
         _loc5_.type = param1.type;
         _loc5_.maxChars = param1.maxChars;
         _loc5_.selectable = param1.selectable;
         _loc5_.border = param1.border;
         _loc5_.borderColor = param1.borderColor;
         _loc5_.antiAliasType = AntiAliasType.ADVANCED;
         _loc5_.gridFitType = GridFitType.PIXEL;
         _loc5_.sharpness = -100;
         _loc5_.thickness = 20;
         _loc5_.embedFonts = true;
         _loc5_.multiline = param1.multiline;
         _loc5_.defaultTextFormat = _loc3_;
         param1.parent.addChildAt(_loc5_,_loc2_);
         param1.parent.removeChild(param1);
         param1 = null;
         return _loc5_;
      }
   }
}

