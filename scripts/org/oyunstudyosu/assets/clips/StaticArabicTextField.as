package org.oyunstudyosu.assets.clips
{
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.text.TextField;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol926")]
   public class StaticArabicTextField extends CoreMovieClip
   {
      
      public var txt:TextField;
      
      public var sText:STextField;
      
      public function StaticArabicTextField()
      {
         super();
         if(this.sText == null)
         {
            this.sText = TextFieldManager.convertAsArabicTextField(this.getChildByName("txt") as TextField,false);
         }
      }
   }
}

