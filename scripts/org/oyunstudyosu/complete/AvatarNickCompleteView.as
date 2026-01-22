package org.oyunstudyosu.complete
{
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1090")]
   public class AvatarNickCompleteView extends CoreMovieClip
   {
      
      private var filterList:Array;
      
      private var len:int;
      
      private var i:int;
      
      private var item:AvatarNickCompleteItem;
      
      public var selectedItem:AvatarNickCompleteItem;
      
      private var selectedIndex:int;
      
      public function AvatarNickCompleteView()
      {
         super();
         Connectr.instance.layerModel.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.downKeyboard);
      }
      
      protected function downKeyboard(param1:KeyboardEvent) : void
      {
         if(this.numChildren == 0)
         {
            return;
         }
         if(param1.keyCode == Keyboard.DOWN)
         {
            if(this.selectedIndex < this.numChildren - 1)
            {
               ++this.selectedIndex;
            }
            else
            {
               this.selectedIndex = 0;
            }
         }
         else if(param1.keyCode == Keyboard.UP)
         {
            if(this.selectedIndex > 0)
            {
               --this.selectedIndex;
            }
            else
            {
               this.selectedIndex = this.numChildren - 1;
            }
         }
         this.selectedItem.selected = false;
         this.selectedItem = this.getChildAt(this.selectedIndex) as AvatarNickCompleteItem;
         this.selectedItem.selected = true;
      }
      
      public function update(param1:String, param2:Array) : void
      {
         this.filterList = [];
         this.removeChildren();
         this.len = param2.length;
         this.selectedIndex = 0;
         this.i = 0;
         while(this.i < this.len)
         {
            if(param2[this.i].nick.toLowerCase().indexOf(param1.toLowerCase()) != -1)
            {
               if(!(Boolean(param2[this.i].isMe) || Boolean(param2[this.i].isNPC)))
               {
                  this.filterList.push(param2[this.i].nick);
               }
            }
            ++this.i;
         }
         if(this.filterList.length == 0)
         {
            if(this.len > 5)
            {
               this.len = 5;
            }
            else
            {
               this.len = param2.length;
            }
            this.i = 0;
            while(this.i < this.len)
            {
               if(!(Boolean(param2[this.i].isMe) || Boolean(param2[this.i].isNPC)))
               {
                  this.filterList.push(param2[this.i].nick);
               }
               ++this.i;
            }
         }
         this.len = this.filterList.length;
         if(this.len > 10)
         {
            this.len = 10;
         }
         else
         {
            this.len = this.filterList.length;
         }
         this.i = 0;
         while(this.i < this.len)
         {
            this.item = new AvatarNickCompleteItem();
            if(this.i == this.selectedIndex)
            {
               this.item.selected = true;
               this.selectedItem = this.item;
            }
            this.addChild(this.item);
            this.item.y = this.i * 30;
            this.item.title = this.filterList[this.i];
            ++this.i;
         }
      }
      
      public function clearAll() : void
      {
         if(this.numChildren > 0)
         {
            removeChildren();
         }
      }
   }
}

