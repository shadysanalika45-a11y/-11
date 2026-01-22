package com.oyunstudyosu.cloth
{
   public class ClothType
   {
      
      public static const BIT00_BODY_BOTTOM:int = 1 << 0;
      
      public static const BIT01_BODY_MIDDLE:int = 1 << 1;
      
      public static const BIT02_BODY_TOP:int = 1 << 2;
      
      public static const BIT012_BODY_FULL:int = BIT00_BODY_BOTTOM | BIT01_BODY_MIDDLE | BIT02_BODY_TOP;
      
      public static const BIT03_UNASSIGNED:int = 1 << 3;
      
      public static const BIT04_FOOT:int = 1 << 4;
      
      public static const BIT05_LEG_BOTTOM:int = 1 << 5;
      
      public static const BIT06_LEG_TOP:int = 1 << 6;
      
      public static const BIT07_BOT:int = 1 << 7;
      
      public static const BIT08_LEG_ALL:int = 1 << 8;
      
      public static const BIT09_SHIRT:int = 1 << 9;
      
      public static const BIT10_BELT:int = 1 << 10;
      
      public static const BIT11_TIE:int = 1 << 11;
      
      public static const BIT12_WRISTBAND:int = 1 << 12;
      
      public static const BIT13_JACKET:int = 1 << 13;
      
      public static const BIT14_BACKPACK:int = 1 << 14;
      
      public static const BIT15_NECK:int = 1 << 15;
      
      public static const BIT16_FACIAL_HAIR:int = 1 << 16;
      
      public static const BIT17_HAIR:int = 1 << 17;
      
      public static const BIT18_GLASS:int = 1 << 18;
      
      public static const BIT19_PIPE:int = 1 << 19;
      
      public static const BIT20_HAT:int = 1 << 20;
      
      public static const BIT21_EMOTICON:int = 1 << 21;
      
      public static const BIT22_HANDITEM:int = 1 << 22;
      
      public static const BIT23_EFFECT_BOTTOM:int = 1 << 23;
      
      public static const BIT24_EFFECT_MIDDLE:int = 1 << 24;
      
      public static const BIT25_EFFECT_TOP:int = 1 << 25;
      
      public static const BIT26_EFFECT_ALL:int = 1 << 26;
      
      public static const HANDITEM_BIT_INDEX:int = 22;
      
      public static const SHIRT_BIT_INDEX:int = 9;
      
      public static const HAT_BIT_INDEX:int = 20;
      
      public static const NECK_BIT_INDEX:int = 15;
      
      public function ClothType()
      {
         super();
      }
   }
}

