package com.oyunstudyosu.displayAd
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.engine.IsoScene;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class NpcBot extends Character
   {
      
      public static const MALE:String = "male";
      
      public static const FEMALE:String = "female";
      
      private var clothSet:Dictionary;
      
      private var position:Point;
      
      private var direction:int;
      
      private var activeClothes:Array;
      
      private var request:AssetRequest;
      
      public var data:Object;
      
      public var handItem:MovieClip;
      
      public var adClip:MovieClip;
      
      private var cookieModel:ICookieModel;
      
      public var botGender:String;
      
      private var assetPath:String = "/static/pubs/";
      
      public function NpcBot(param1:*)
      {
         super();
         this.direction = 5;
         clothSet = new Dictionary();
         if(param1.gender == "m")
         {
            if(!param1.clothes)
            {
               param1.clothes = ["A_1","B_1","C_1","pp9f5cfr_5","fbbzf8kd_7","SoC9l5hD_7","rmu9gg45_8"];
            }
            activeClothes = param1.clothes;
            botGender = "m";
         }
         else
         {
            if(!param1.clothes)
            {
               param1.clothes = ["A_2","B_2","C_2","90_6","zl7rkw2o_4","3_3","0301_13"];
            }
            activeClothes = param1.clothes;
            botGender = "f";
         }
         this.init($("TutorialCharName"),Sanalika.instance.engine.scene as IsoScene,0,botGender,activeClothes);
         this.avatarName = param1.nick;
         this.isNPC = true;
         this.reLocate(param1.x,param1.y,3,true);
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         _loc2_.addChar(this);
      }
      
      public function execute() : void
      {
      }
      
      private function onError(param1:Object) : void
      {
         request.dispose();
      }
      
      override public function terminate(param1:Boolean = true) : void
      {
         data = null;
         super.terminate(param1);
      }
   }
}

