package com.oyunstudyosu.enums
{
   import com.oyunstudyosu.inventory.Item;
   
   public class ItemType
   {
      
      public static const TYPE_VIEWABLE:uint = 1;
      
      public static const TYPE_QUESTITEM:uint = 4;
      
      public static const TYPE_FOOD:uint = 8;
      
      public static const TYPE_ITEMVISIBLEIDLE:uint = 16;
      
      public static const TYPE_ITEMVISIBLEWALKING:uint = 32;
      
      public static const TYPE_ITEMVISIBLESITTING:uint = 64;
      
      public static const TYPE_ITEMVISIBLEDANCE:uint = 128;
      
      public static const TYPE_HANDVISIBLEIDLE:uint = 256;
      
      public static const TYPE_HANDVISIBLEWALKING:uint = 512;
      
      public static const TYPE_HANDVISIBLESITTING:uint = 1024;
      
      public static const TYPE_MAKEITEM:uint = 2048;
      
      public static const TYPE_SWFLOADER:uint = 4096;
      
      public static const TYPE_VIP:uint = 8192;
      
      public static const TYPE_USEABLE:uint = 16384;
      
      public static const TYPE_PLANT:uint = 32768;
      
      public static const TYPE_APPLICATION:uint = 65536;
      
      public static const TYPE_GROUND_OBJECT:uint = 131072;
      
      public static const TYPE_PACKAGE:uint = 262144;
      
      public function ItemType()
      {
         super();
      }
      
      public static function isHandItem(param1:int) : Boolean
      {
         return isViewable(param1) && param1 >> 8 > 0;
      }
      
      public static function isWearableItem(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 >> 4 & 0x0F) > 0;
      }
      
      public static function isViewable(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_VIEWABLE) > 0;
      }
      
      public static function isQuestItem(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_QUESTITEM) > 0;
      }
      
      public static function isFood(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_FOOD) > 0;
      }
      
      public static function isItemVisibleIdle(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_ITEMVISIBLEIDLE) > 0;
      }
      
      public static function isItemVisibleWalking(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_ITEMVISIBLEWALKING) > 0;
      }
      
      public static function isItemVisibleSitting(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_ITEMVISIBLESITTING) > 0;
      }
      
      public static function isItemVisibleDance(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_ITEMVISIBLEDANCE) > 0;
      }
      
      public static function isHandVisibleIdle(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_HANDVISIBLEIDLE) > 0;
      }
      
      public static function isHandVisibleWalking(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_HANDVISIBLEWALKING) > 0;
      }
      
      public static function isHandVisibleSitting(param1:int) : Boolean
      {
         return isViewable(param1) && (param1 & TYPE_HANDVISIBLESITTING) > 0;
      }
      
      public static function isMakeItem(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_MAKEITEM) > 0;
      }
      
      public static function isSwfLoader(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_SWFLOADER) > 0;
      }
      
      public static function isVip(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_VIP) > 0;
      }
      
      public static function isUseable(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_USEABLE) > 0;
      }
      
      public static function isPlant(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_PLANT) > 0;
      }
      
      public static function isApplication(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_APPLICATION) > 0;
      }
      
      public static function isGroundObject(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_GROUND_OBJECT) > 0;
      }
      
      public static function isPackage(param1:int) : Boolean
      {
         return param1 > 0 && (param1 & TYPE_PACKAGE) > 0;
      }
      
      public static function traceAll(param1:Item) : void
      {
         trace("-------------------------------");
         trace("ITEM NAME[" + param1.clip + "] TYPE[" + param1.getType() + "]");
         trace("isViewable:\t" + isViewable(param1.getType()));
         trace("isQuestItem:\t" + isQuestItem(param1.getType()));
         trace("isFood:\t" + isFood(param1.getType()));
         trace("---");
         trace("isItemVisibleIdle:\t" + isItemVisibleIdle(param1.getType()));
         trace("isItemVisibleWalking:\t" + isItemVisibleWalking(param1.getType()));
         trace("isItemVisibleSitting:\t" + isItemVisibleSitting(param1.getType()));
         trace("isItemVisibleDance:\t" + isItemVisibleDance(param1.getType()));
         trace("---");
         trace("isHandVisibleIdle:\t" + isHandVisibleIdle(param1.getType()));
         trace("isHandVisibleWalking:\t" + isHandVisibleWalking(param1.getType()));
         trace("isHandVisibleSitting:\t" + isHandVisibleSitting(param1.getType()));
         trace("isMakeItem:\t" + isMakeItem(param1.getType()));
         trace("isSwfLoader:\t" + isSwfLoader(param1.getType()));
         trace("isVip:\t" + isVip(param1.getType()));
         trace("isUseable:\t" + isUseable(param1.getType()));
         trace("isPlant:\t" + isPlant(param1.getType()));
         trace("isApplication:\t" + isApplication(param1.getType()));
         trace("isGroundObject:\t" + isGroundObject(param1.getType()));
         trace("isPackage:\t" + isPackage(param1.getType()));
         trace("---");
         trace("isHandItem:\t" + isHandItem(param1.getType()));
         trace("isWearableItem:\t" + isWearableItem(param1.getType()));
         trace("-------------------------------");
      }
   }
}

