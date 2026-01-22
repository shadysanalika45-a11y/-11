package com.oyunstudyosu.local
{
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.IToolTipModel;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class LocalizationModel implements ILocalizationModel
   {
      
      public static var instance:LocalizationModel;
      
      public static const LOCALIZATION_DATA_READY:String = "LOCALIZATION_DATA_READY";
      
      private var toolTipModel:IToolTipModel;
      
      private var stage:Stage;
      
      private var primaryTranslator:GetText;
      
      private var secondaryTranslator:GetText;
      
      private var secondaryList:Array = [];
      
      private var loadCount:int;
      
      private var currentCount:int;
      
      public var hasSecondaryLanguage:Boolean;
      
      public function LocalizationModel()
      {
         super();
         instance = this;
         Connectr.instance.serviceModel.listenExtension("langData",this.updateLangData);
      }
      
      public function init(param1:Object) : void
      {
         this.stage = param1.stage;
         this.toolTipModel = param1.toolTipModel;
         GetText.fileServer = param1.fileServer;
         GetText.version = param1.version;
         GetText.debugMode = param1.debugMode;
         this.currentCount = 0;
         if(this.secondaryList.indexOf(param1.language) > -1)
         {
            this.loadCount = 2;
            this.hasSecondaryLanguage = true;
            GetText.version = "/static/locale/en.mo";
            this.primaryTranslator = new GetText(param1.language,true);
            this.primaryTranslator.addEventListener(Event.COMPLETE,this.onComplete);
            this.primaryTranslator.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this.primaryTranslator.install();
            GetText.version = param1.version;
            this.secondaryTranslator = new GetText("en",false);
            this.secondaryTranslator.addEventListener(Event.COMPLETE,this.onComplete);
            this.secondaryTranslator.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this.secondaryTranslator.install();
         }
         else
         {
            this.loadCount = 1;
            this.primaryTranslator = new GetText(param1.language,true);
            this.primaryTranslator.addEventListener(Event.COMPLETE,this.onComplete);
            this.primaryTranslator.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this.primaryTranslator.install();
         }
      }
      
      protected function onError(param1:Event) : void
      {
         trace("translation load error.");
         this.check();
      }
      
      protected function onRightClick(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:TextField = null;
         var _loc2_:Array = this.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc2_[_loc5_] is TextField)
            {
               _loc4_ = _loc2_[_loc5_] as TextField;
               if(_loc4_.name.substr(0,4) == "lbl_")
               {
                  _loc3_ = _loc4_;
                  break;
               }
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            if(_loc3_.parent.mouseChildren == false)
            {
               this.toolTipModel.showTip(_loc3_.parent,(_loc3_ as TextField).text);
            }
            else
            {
               this.toolTipModel.showTip(_loc3_,(_loc3_ as TextField).text);
            }
         }
      }
      
      protected function check() : void
      {
         ++this.currentCount;
         if(this.loadCount == this.currentCount)
         {
            this.primaryTranslator.removeEventListener(Event.COMPLETE,this.onComplete);
            this.primaryTranslator.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            if(this.secondaryTranslator != null)
            {
               this.secondaryTranslator.removeEventListener(Event.COMPLETE,this.onComplete);
               this.secondaryTranslator.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            }
            Dispatcher.dispatchEvent(new Event(LOCALIZATION_DATA_READY));
         }
      }
      
      protected function onComplete(param1:Event) : void
      {
         this.check();
      }
      
      public function translate(param1:String) : String
      {
         var _loc2_:String = param1;
         if(this.primaryTranslator != null)
         {
            _loc2_ = this.primaryTranslator.translate(param1);
         }
         if(this.secondaryTranslator != null && _loc2_ == param1)
         {
            _loc2_ = this.secondaryTranslator.translate(param1);
         }
         return _loc2_;
      }
      
      public function translate2(param1:String = "") : String
      {
         return this.translate(param1);
      }
      
      private function updateLangData(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:Array = Base64.decode(param1.data).toString().split("\n");
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.substr(0,_loc3_.indexOf("|"));
            _loc5_ = _loc3_.substr(_loc3_.indexOf("|") + 1);
            this.primaryTranslator.update(_loc4_,_loc5_);
         }
      }
   }
}

