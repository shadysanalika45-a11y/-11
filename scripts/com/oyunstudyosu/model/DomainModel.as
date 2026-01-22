package com.oyunstudyosu.model
{
   import com.oyunstudyosu.sanalika.interfaces.IDomainModel;
   import flash.display.Stage;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   public class DomainModel implements IDomainModel
   {
      
      public var contextList:Array = [];
      
      public var securityDomain:SecurityDomain;
      
      public var mainAppDomain:ApplicationDomain;
      
      public var subAppDomain:ApplicationDomain;
      
      public var checkPolicyFile:Boolean;
      
      public var stage:Stage;
      
      private var _mainContext:LoaderContext;
      
      private var _subContext:LoaderContext;
      
      private var _assetContext:LoaderContext;
      
      public function DomainModel(param1:Stage)
      {
         super();
         this.stage = param1;
      }
      
      public function get mainContext() : LoaderContext
      {
         if(_mainContext == null)
         {
            _mainContext = new LoaderContext();
            if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
            {
               _mainContext.applicationDomain = new ApplicationDomain(mainAppDomain);
               _mainContext.allowCodeImport = true;
            }
            else
            {
               _mainContext.applicationDomain = mainAppDomain;
               _mainContext.securityDomain = securityDomain;
               _mainContext.checkPolicyFile = checkPolicyFile;
            }
            _mainContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            _mainContext.imageDecodingPolicy = "onLoad";
         }
         return _mainContext;
      }
      
      public function clearMainContext() : void
      {
         try
         {
            _mainContext.applicationDomain = null;
            _mainContext = null;
         }
         catch(e:Error)
         {
         }
      }
      
      public function get subContext() : LoaderContext
      {
         if(_subContext == null)
         {
            _subContext = new LoaderContext();
            if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
            {
               _subContext.applicationDomain = new ApplicationDomain(subAppDomain);
               _subContext.allowCodeImport = true;
            }
            else
            {
               _subContext.applicationDomain = subAppDomain;
               _subContext.securityDomain = securityDomain;
               _subContext.checkPolicyFile = checkPolicyFile;
            }
            _subContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            _subContext.imageDecodingPolicy = "onLoad";
         }
         return _subContext;
      }
      
      public function clearSubContext() : void
      {
         try
         {
            _subContext.applicationDomain = null;
            _subContext = null;
         }
         catch(e:Error)
         {
         }
      }
      
      public function get assetContext() : LoaderContext
      {
         if(_assetContext == null)
         {
            _assetContext = new LoaderContext();
            if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
            {
               _assetContext.applicationDomain = new ApplicationDomain(subAppDomain);
               _assetContext.allowCodeImport = true;
            }
            else
            {
               _assetContext.applicationDomain = subAppDomain;
               _assetContext.securityDomain = securityDomain;
               _assetContext.checkPolicyFile = checkPolicyFile;
            }
            _assetContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            _assetContext.imageDecodingPolicy = "onLoad";
         }
         return _assetContext;
      }
      
      public function clearAssetContext() : void
      {
         try
         {
            _assetContext.applicationDomain = null;
            _assetContext = null;
         }
         catch(e:Error)
         {
         }
      }
      
      public function generateContext(param1:String) : LoaderContext
      {
         if(contextList[param1] == null)
         {
            contextList[param1] = new Vector.<LoaderContext>();
         }
         var _loc2_:LoaderContext = new LoaderContext();
         _loc2_.checkPolicyFile = true;
         _loc2_.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         _loc2_.securityDomain = null;
         _loc2_.allowCodeImport = false;
         _loc2_.imageDecodingPolicy = "onLoad";
         contextList[param1].push(_loc2_);
         return _loc2_;
      }
      
      public function clearContext(param1:String) : void
      {
         if(this.contextList[param1] == null)
         {
            trace("context null!");
            return;
         }
         for each(var _loc2_ in contextList[param1])
         {
            _loc2_.applicationDomain = null;
            _loc2_ = null;
         }
         contextList[param1].splice(0,contextList[param1].length);
      }
      
      private function generateApplicationDomain() : ApplicationDomain
      {
         var _loc1_:ApplicationDomain = null;
         return new ApplicationDomain(ApplicationDomain.currentDomain);
      }
   }
}

