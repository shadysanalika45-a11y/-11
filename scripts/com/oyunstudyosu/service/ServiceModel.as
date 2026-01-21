package com.oyunstudyosu.service
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.debug.DebugConsole;
   import com.oyunstudyosu.debug.ContractLogger;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.variables.RoomVariable;
   import com.smartfoxserver.v2.entities.variables.SFSRoomVariable;
   import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
   import com.smartfoxserver.v2.entities.variables.UserVariable;
   import com.smartfoxserver.v2.requests.ExtensionRequest;
   import com.smartfoxserver.v2.requests.SetRoomVariablesRequest;
   import com.smartfoxserver.v2.requests.SetUserVariablesRequest;
   import flash.utils.Dictionary;
   
   public class ServiceModel implements IServiceModel
   {
      
      private var _sfs:SmartFox;
      
      private var isActive:Boolean;
      
      private var roomVarList:Dictionary;
      
      private var userVarList:Dictionary;
      
      private var extensionList:Dictionary;
      
      private var extListenerList:Dictionary;
      
      private var dataList:Dictionary;
      
      private var alertvo:AlertVo;
      
      private var processList:Dictionary;
      
      public var extensionIdle:Boolean = false;
      
      public function ServiceModel()
      {
         super();
         _sfs = new SmartFox(false);
         roomVarList = new Dictionary(false);
         userVarList = new Dictionary(false);
         extensionList = new Dictionary(false);
         extListenerList = new Dictionary(false);
         dataList = new Dictionary(false);
         processList = new Dictionary(false);
      }
      
      public function get sfs() : SmartFox
      {
         return _sfs;
      }
      
      public function set sfs(param1:SmartFox) : void
      {
         _sfs = param1;
      }
      
      public function activate() : void
      {
         if(isActive)
         {
            return;
         }
         try
         {
            DebugConsole.init(Sanalika.instance.layerModel.gameLayer);
            DebugConsole.info("STATE","ServiceModel.activate");
         }
         catch(e:Error)
         {
         }
         _sfs.addEventListener("userVariablesUpdate",onUserVariableUpdate);
         _sfs.addEventListener("roomVariablesUpdate",onRoomVariableUpdate);
         _sfs.addEventListener("extensionResponse",onExtensionResponse);
         isActive = true;
      }
      
      public function deactivate() : void
      {
         if(!isActive)
         {
            return;
         }
         _sfs.removeEventListener("userVariablesUpdate",onUserVariableUpdate);
         _sfs.removeEventListener("roomVariablesUpdate",onRoomVariableUpdate);
         _sfs.removeEventListener("extensionResponse",onExtensionResponse);
         isActive = false;
      }
      
      public function setRoomVariable(param1:Array, param2:Array) : void
      {
         var _loc4_:int = 0;
         if(param1.length != param2.length)
         {
            return;
         }
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.push(new SFSRoomVariable(param1[_loc4_],param2[_loc4_]));
            _loc4_++;
         }
         _sfs.send(new SetRoomVariablesRequest(_loc3_));
      }
      
      public function getVariableByUserId(param1:String, param2:String) : UserVariable
      {
         if(sfs.lastJoinedRoom == null)
         {
            return null;
         }
         var _loc3_:User = sfs.lastJoinedRoom.getUserByName(param2);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getVariable(param1);
      }
      
      public function setUserVariable(param1:Array, param2:Array) : void
      {
         var _loc4_:int = 0;
         if(param1.length != param2.length)
         {
            return;
         }
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.push(new SFSUserVariable(param1[_loc4_],param2[_loc4_]));
            _loc4_++;
         }
         _sfs.send(new SetUserVariablesRequest(_loc3_));
      }
      
      public function listenAndDispatchRoomVariable(param1:String, param2:Function) : void
      {
         listenRoomVariable(param1,param2);
         var _loc4_:Room = sfs.lastJoinedRoom;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:RoomVariable = _loc4_.getVariable(param1);
         if(_loc3_ == null)
         {
            return;
         }
         param2(_loc4_);
      }
      
      public function listenRoomVariable(param1:String, param2:Function) : void
      {
         if(roomVarList[param1] == null)
         {
            roomVarList[param1] = [];
         }
         roomVarList[param1].push(param2);
      }
      
      public function removeRoomVariable(param1:String, param2:Function) : void
      {
         if(roomVarList[param1] == null)
         {
            return;
         }
         var _loc3_:int = int(roomVarList[param1].indexOf(param2));
         if(_loc3_ == -1)
         {
            return;
         }
         roomVarList[param1].splice(_loc3_,1);
      }
      
      public function listenUserVariable(param1:String, param2:Function) : void
      {
         if(userVarList[param1] == null)
         {
            userVarList[param1] = [];
         }
         userVarList[param1].push(param2);
      }
      
      public function removeUserVariable(param1:String, param2:Function) : void
      {
         if(userVarList[param1] == null)
         {
            return;
         }
         var _loc3_:int = int(userVarList[param1].indexOf(param2));
         if(_loc3_ == -1)
         {
            return;
         }
         userVarList[param1].splice(_loc3_,1);
      }
      
      public function listenExtension(param1:String, param2:Function) : void
      {
         if(extListenerList[param1] == null)
         {
            extListenerList[param1] = [];
         }
         extListenerList[param1].push(param2);
      }
      
      public function removeExtension(param1:String, param2:Function) : void
      {
         if(extListenerList[param1] == null)
         {
            return;
         }
         var _loc3_:int = int(extListenerList[param1].indexOf(param2));
         if(_loc3_ == -1)
         {
            return;
         }
         extListenerList[param1].splice(_loc3_,1);
      }
      
      public function requestExtension(param1:String, param2:Object, param3:Function, param4:Room = null) : void
      {
         requestData(param1,param2,param3,param4);
      }
      
      public function requestData(param1:String, param2:Object, param3:Function, param4:Room = null) : void
      {
         var _loc6_:*;
         var _loc7_:ServiceParameters;
         var _loc5_:Object = null;
         var _loc8_:Object = null;
         _loc5_ = null;
         if(dataList[param1] == null)
         {
            dataList[param1] = [];
         }
         if(Boolean(param3))
         {
            dataList[param1].push(param3);
         }
         if(!ServiceRequestRate.check(param1) || extensionIdle)
         {
            trace("Request rate exceed.");
            if(param1 == "usedoor" || param1 == "usehousedoor")
            {
               Sanalika.instance.roomModel.mapInitalized = true;
               Sanalika.instance.roomModel.doorModel.busy = false;
            }
            if(extensionIdle)
            {
               _loc5_ = {};
               _loc5_.errorCode = "EXTENSION_IDLE";
               _loc5_.message = "Please try again in a few seconds.";
            }
            else
            {
               _loc5_ = {};
               _loc5_.errorCode = "FLOOD";
               _loc5_.message = "Stop flooding or you will be banned soon.";
            }
            alertvo = new AlertVo();
            alertvo.alertType = "tooltip";
            alertvo.description = ServiceErrorCode.getMessageById(_loc5_.errorCode);
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            for each(_loc6_ in dataList[param1])
            {
               if(Boolean(_loc6_))
               {
                  _loc6_(_loc5_);
               }
            }
            delete dataList[param1];
            return;
         }
         _loc7_ = new ServiceParameters();
         _loc7_.sn = param1;
         _loc7_.data = param2;
         try
         {
            DebugConsole.info("NET_OUT","cmd=",param1,"room=",param4 ? param4.name : (sfs.lastJoinedRoom ? sfs.lastJoinedRoom.name : "null"),"data=",JSON.stringify(param2));
         }
         catch(e1:Error)
         {
            DebugConsole.info("NET_OUT","cmd=",param1,"(data stringify failed)");
         }
         try
         {
            _loc8_ = ContractLogger.summarizeObject(param2 || {});
            ContractLogger.log("net_out",{
               "cmd":param1,
               "room":param4 ? param4.name : (sfs.lastJoinedRoom ? sfs.lastJoinedRoom.name : null),
               "payload":param2,
               "payloadKeys":_loc8_.keys,
               "payloadTypes":_loc8_.types
            });
         }
         catch(e1c:Error)
         {
            ContractLogger.log("net_out",{
               "cmd":param1,
               "room":param4 ? param4.name : (sfs.lastJoinedRoom ? sfs.lastJoinedRoom.name : null),
               "payloadError":"summarize_failed"
            });
         }
         _sfs.send(new ExtensionRequest(param1,_loc7_.getSFSObject(),param4));
         trace("## ServiceModel ## -> requestData : " + param1 + " sent. (type : requestData) ## ->" + JSON.stringify(param2));
      }
      
      protected function onExtensionResponse(param1:SFSEvent) : void
      {
         var _k:String;
         var _keys:Array;
         var _preview:String;
         var _summary:Object;
         var _loc3_:Boolean;
         var _loc2_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc12_:AlertVo = null;
         var _loc4_:PanelVO = null;
         var _loc11_:String = null;
         var _loc9_:Array = null;
         var _loc10_:* = undefined;
         var _loc8_:* = undefined;
         var _loc13_:String = param1.params.cmd;
         var _loc5_:ISFSObject = param1.params.params;
         _loc6_ = _loc5_.toObject();
         try
         {
            _keys = [];
            for(_k in _loc6_)
            {
               _keys.push(_k);
            }
            DebugConsole.info("NET_IN","cmd=",_loc13_,"respKeys=",_keys.join(","),"errorCode=",_loc6_.errorCode);
            _preview = JSON.stringify(_loc6_);
            if(_preview && _preview.length > 800)
            {
               _preview = _preview.substr(0,800) + "...";
            }
            DebugConsole.info("NET_IN","payload=",_preview);
         }
         catch(e0:Error)
         {
         }
         try
         {
            _summary = ContractLogger.summarizeObject(_loc6_);
            ContractLogger.log("net_in",{
               "cmd":_loc13_,
               "payload":_loc6_,
               "payloadKeys":_summary.keys,
               "payloadTypes":_summary.types,
               "errorCode":_loc6_.errorCode
            });
         }
         catch(e0c:Error)
         {
         }
         if(_loc6_.errorCode && _loc6_.errorCode == "FLOOD")
         {
            trace("FLOOD");
            ServiceRequestRate.create(_loc13_,_loc6_.nextRequest);
         }
         _loc3_ = false;
         _loc2_ = dataList[_loc13_];
         if(_loc2_ != null)
         {
            try
            {
               if(_loc6_.errorCode && _loc6_.errorCode == "INSUFFICIENT_ROLE")
               {
                  _loc8_ = new AlertVo();
                  _loc8_.alertType = "tooltip";
                  _loc8_.description = ServiceErrorCode.getRoleErrors(String(_loc6_.message).split(","));
                  Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
                  _loc3_ = true;
               }
               else if(_loc6_.errorCode != null && _loc6_.errorCode == "MISSING_ITEM")
               {
                  _loc12_ = new AlertVo();
                  _loc12_.alertType = "tooltip";
                  _loc12_.description = Sanalika.instance.localizationModel.translate("MISSING_ITEM") + ": " + $("pro_" + _loc6_.message);
                  Dispatcher.dispatchEvent(new AlertEvent(_loc12_));
               }
               else if(_loc6_.errorCode != null && _loc6_.errorCode == "GUEST_NOT_ALLOWED")
               {
                  _loc4_ = new PanelVO("GuestPanel");
                  _loc4_.params = _loc6_;
                  Sanalika.instance.panelModel.openPanel(_loc4_);
               }
               else if(_loc6_.errorCode == "WRONG_ITEM")
               {
                  _loc11_ = _loc6_.message;
                  _loc9_ = _loc11_.split(",");
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_.length)
                  {
                     _loc9_[_loc10_] = Sanalika.instance.localizationModel.translate("pro_" + _loc9_[_loc10_]);
                     _loc10_++;
                  }
                  _loc8_ = new AlertVo();
                  _loc8_.alertType = "tooltip";
                  _loc8_.description = Sanalika.instance.localizationModel.translate("Wrong hand item to catch fish.") + " (" + _loc9_.join(", ") + ")";
                  Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
               }
               else if(_loc6_.errorCode)
               {
                  _loc8_ = new AlertVo();
                  _loc8_.alertType = "tooltip";
                  _loc8_.description = ServiceErrorCode.getMessageById(_loc6_.errorCode);
                  Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
                  _loc3_ = true;
               }
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  if(_loc2_[_loc7_])
                  {
                     _loc2_[_loc7_](_loc6_);
                  }
                  _loc7_++;
               }
            }
            catch(error:Error)
            {
               trace(error.getStackTrace());
            }
            delete dataList[_loc13_];
         }
         _loc2_ = extensionList[_loc13_];
         if(_loc2_ != null)
         {
            try
            {
               if(_loc6_.errorCode && _loc6_.errorCode == "INSUFFICIENT_ROLE" && _loc13_ != "usedoor")
               {
                  if(!_loc3_)
                  {
                     trace("xx2222");
                     _loc8_ = new AlertVo();
                     _loc8_.alertType = "tooltip";
                     _loc8_.description = ServiceErrorCode.getRoleErrors(String(_loc6_.message).split(","));
                     Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
                  }
               }
               else if(_loc6_.errorCode)
               {
                  if(!_loc3_)
                  {
                     _loc8_ = new AlertVo();
                     _loc8_.alertType = "tooltip";
                     _loc8_.description = ServiceErrorCode.getMessageById(_loc6_.errorCode);
                     Dispatcher.dispatchEvent(new AlertEvent(_loc8_));
                  }
               }
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  if(_loc2_[_loc7_])
                  {
                     _loc2_[_loc7_](_loc6_);
                  }
                  _loc7_++;
               }
            }
            catch(error:Error)
            {
               trace(error.getStackTrace());
            }
         }
         _loc2_ = extListenerList[_loc13_];
         if(_loc2_ != null)
         {
            try
            {
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  if(_loc2_[_loc7_])
                  {
                     _loc2_[_loc7_](_loc6_);
                  }
                  _loc7_++;
               }
            }
            catch(error:Error)
            {
               trace(error.getStackTrace());
            }
         }
      }
      
      private function checkResponse(param1:String, param2:ISFSObject) : String
      {
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = int(param2.getInt("size"));
         var _loc3_:int = int(param2.getInt("sent"));
         var _loc5_:String = param2.getUtfString("data");
         if(_loc7_ < 2)
         {
            return _loc5_;
         }
         if(processList[param1] == null)
         {
            processList[param1] = [];
         }
         processList[param1][_loc3_ - 1] = _loc5_;
         if(processList[param1].length == _loc7_)
         {
            _loc4_ = "";
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_ += processList[param1][_loc6_];
               _loc6_++;
            }
            delete processList[param1];
            return _loc4_;
         }
         return null;
      }
      
      protected function onRoomVariableUpdate(param1:SFSEvent) : void
      {
         var _loc6_:Array;
         var _loc5_:Room;
         var _loc3_:*;
         var _loc8_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc9_:RoomVariable = null;
         trace("roomvarupdate");
         _loc6_ = param1.params.changedVars as Array;
         _loc5_ = param1.params.room as Room;
         try
         {
            DebugConsole.info("NET_IN","roomVariablesUpdate","room=",_loc5_ ? _loc5_.name : "null","changed=",_loc6_);
         }
         catch(eR:Error)
         {
         }
         for(_loc3_ in param1.params)
         {
            trace("key:",_loc3_,"value:",param1.params[_loc3_]);
         }
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc2_ = roomVarList[_loc6_[_loc8_]];
            trace("## ServiceModel ## -> room variable update : " + _loc6_[_loc8_]);
            try
            {
               if(_loc5_)
               {
                  _loc9_ = _loc5_.getVariable(_loc6_[_loc8_]);
                  if(_loc9_ != null)
                  {
                     ContractLogger.log("room_var_update",{
                        "room":_loc5_.name,
                        "name":_loc6_[_loc8_],
                        "type":_loc9_.type,
                        "value":_loc9_.getValue()
                     });
                  }
               }
            }
            catch(eRV:Error)
            {
            }
            if(_loc2_ == null)
            {
               trace("## ServiceModel ## -> No room listener for " + _loc6_[_loc8_] + " key.");
            }
            else
            {
               _loc4_ = _loc6_[_loc8_].substr(4,_loc6_[_loc8_].length);
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  _loc2_[_loc7_](_loc5_);
                  _loc7_++;
               }
            }
            _loc8_++;
         }
      }
      
      protected function onUserVariableUpdate(param1:SFSEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:Array = param1.params.changedVars as Array;
         var _loc3_:User = param1.params.user as User;
         var _loc7_:UserVariable = null;
         try
         {
            DebugConsole.info("NET_IN","userVariablesUpdate","user=",_loc3_ ? _loc3_.name : "null","changed=",_loc4_);
         }
         catch(eU:Error)
         {
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc2_ = userVarList[_loc4_[_loc6_]];
            try
            {
               if(_loc3_)
               {
                  _loc7_ = _loc3_.getVariable(_loc4_[_loc6_]);
                  if(_loc7_ != null)
                  {
                     ContractLogger.log("user_var_update",{
                        "user":_loc3_.name,
                        "name":_loc4_[_loc6_],
                        "type":_loc7_.type,
                        "value":_loc7_.getValue()
                     });
                  }
               }
            }
            catch(eUV:Error)
            {
            }
            if(_loc2_ == null)
            {
               trace("## ServiceModel ## -> No user listener for " + _loc4_[_loc6_] + " key.");
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  try
                  {
                     _loc2_[_loc5_](_loc3_);
                  }
                  catch(e:Error)
                  {
                  }
                  _loc5_++;
               }
            }
            _loc6_++;
         }
      }
      
      public function removeRequestData(param1:String, param2:Function) : void
      {
         if(dataList[param1] == null)
         {
            return;
         }
         var _loc3_:int = int(dataList[param1].indexOf(param2));
         if(_loc3_ == -1)
         {
            return;
         }
         dataList[param1].splice(_loc3_,1);
      }
      
      public function removeRequestExtension(param1:String, param2:Function) : void
      {
         removeRequestData(param1,param2);
      }
   }
}

