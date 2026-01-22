package com.oyunstudyosu.discord
{
   import flash.display.Stage;
   import flash.events.Event;
   
   public class DiscordModel
   {
      
      private var stage:Stage;
      
      private var discord:* = null;
      
      public function DiscordModel(param1:Stage)
      {
         super();
         this.stage = param1;
      }
      
      public function init() : void
      {
         var _loc1_:Class = null;
         if(discord != null)
         {
            return;
         }
         try
         {
            if(stage.loaderInfo.applicationDomain.hasDefinition("com.oyunstudyosu.DiscordRPC"))
            {
               _loc1_ = stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.DiscordRPC") as Class;
               discord = new _loc1_();
               if(!discord.available)
               {
                  discord = null;
               }
               discord.addEventListener("DiscordOnJoinEvent",onJoinEvent);
               discord.addEventListener("DiscordOnJoinRequestedEvent",onJoinRequestEvent);
            }
         }
         catch(e:*)
         {
         }
      }
      
      private function onJoinRequestEvent(param1:Event) : void
      {
         var _loc2_:* = param1;
         var _loc3_:DiscordRequestModel = new DiscordRequestModel(_loc2_.params);
      }
      
      private function onJoinEvent(param1:Event) : void
      {
         var _loc2_:* = param1;
         var _loc3_:* = JSON.parse(_loc2_.params);
         var _loc4_:* = JSON.parse(_loc3_.secret);
         Sanalika.instance.roomModel.roomID = _loc4_.roomID;
         Sanalika.instance.roomModel.type = _loc4_.type;
         Sanalika.instance.roomModel.doorModel.useHouseDoor(_loc4_.roomID,null);
      }
      
      public function setDetails(param1:String) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.setDetails(param1);
      }
      
      public function setState(param1:String) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.setState(param1);
      }
      
      public function setSecrets(param1:String, param2:String = "") : void
      {
         if(discord == null)
         {
            return;
         }
         discord.setSecrets(param1,param2);
      }
      
      public function setParty(param1:String, param2:int, param3:int) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.setParty(param1,param2,param3);
      }
      
      public function setLargeImage(param1:String, param2:String) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.setLargeImage(param1,param2);
      }
      
      public function clearLargeImage() : void
      {
         if(discord == null)
         {
            return;
         }
         discord.clearLargeImage();
      }
      
      public function setSmallImage(param1:String, param2:String) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.setSmallImage(param1,param2);
      }
      
      public function clearSmallImage() : void
      {
         if(discord == null)
         {
            return;
         }
         discord.clearSmallImage();
      }
      
      public function acceptJoinRequest(param1:String) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.acceptJoinRequest(param1);
      }
      
      public function rejectJoinRequest(param1:String) : void
      {
         if(discord == null)
         {
            return;
         }
         discord.rejectJoinRequest(param1);
      }
   }
}

