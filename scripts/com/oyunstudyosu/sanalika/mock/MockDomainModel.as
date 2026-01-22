package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.sanalika.interfaces.IDomainModel;
   import flash.system.ApplicationDomain;
   import flash.system.ImageDecodingPolicy;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   public class MockDomainModel implements IDomainModel
   {
      
      public var securityDomain:SecurityDomain;
      
      public var mainAppDomain:ApplicationDomain;
      
      public var subAppDomain:ApplicationDomain;
      
      public var checkPolicyFile:Boolean;
      
      private var _mainContext:LoaderContext;
      
      private var _subContext:LoaderContext;
      
      private var _assetContext:LoaderContext;
      
      public function MockDomainModel()
      {
         super();
      }
      
      public function get mainContext() : LoaderContext
      {
         if(this._mainContext == null)
         {
            this._mainContext = new LoaderContext();
            this._mainContext.checkPolicyFile = this.checkPolicyFile;
            this._mainContext.applicationDomain = this.mainAppDomain;
            this._mainContext.securityDomain = this.securityDomain;
            this._mainContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
         }
         return this._mainContext;
      }
      
      public function clearMainContext() : void
      {
      }
      
      public function get subContext() : LoaderContext
      {
         if(this._subContext == null)
         {
            this._subContext = new LoaderContext();
            this._subContext.checkPolicyFile = this.checkPolicyFile;
            this._subContext.applicationDomain = this.subAppDomain;
            this._subContext.securityDomain = this.securityDomain;
            this._subContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
         }
         return this._subContext;
      }
      
      public function clearSubContext() : void
      {
      }
      
      public function get assetContext() : LoaderContext
      {
         if(this._assetContext == null)
         {
            this._assetContext = new LoaderContext();
            this._assetContext.checkPolicyFile = this.checkPolicyFile;
            this._assetContext.applicationDomain = this.subAppDomain;
            this._assetContext.securityDomain = this.securityDomain;
            this._assetContext.allowCodeImport = false;
            this._assetContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
         }
         return this._assetContext;
      }
      
      public function clearAssetContext() : void
      {
      }
      
      public function generateContext(param1:String) : LoaderContext
      {
         return null;
      }
      
      public function clearContext(param1:String) : void
      {
      }
      
      private function generateApplicationDomain() : ApplicationDomain
      {
         return null;
      }
   }
}

