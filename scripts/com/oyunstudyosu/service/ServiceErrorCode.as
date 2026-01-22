package com.oyunstudyosu.service
{
   import com.oyunstudyosu.local.$;
   import com.printfas3.printf;
   
   public class ServiceErrorCode
   {
      
      private static var _masterRoles:Array;
      
      public static var serviceErrorList:Array = new Array();
      
      public static var roleErrorList:Array = new Array();
      
      public function ServiceErrorCode()
      {
         super();
      }
      
      public static function setData(param1:Array) : void
      {
         _masterRoles = param1;
      }
      
      public static function setRoles() : void
      {
         var _loc1_:* = 0;
         while(_loc1_ < _masterRoles.length)
         {
            roleErrorList[_masterRoles[_loc1_].index] = $("ROLE_ERROR_" + _masterRoles[_loc1_].name);
            _loc1_++;
         }
         serviceErrorList[0] = "Service error.";
         serviceErrorList[1] = "Service method does not match.";
         serviceErrorList[2] = "Expire OAuth access token.";
         serviceErrorList[3] = "Cannot get parameter value.";
         serviceErrorList[4] = "User access token is required for this service.";
         serviceErrorList[5] = "Invalid OAuth access token.";
         serviceErrorList[6] = "Invalid email address.";
         serviceErrorList[7] = "Emails do not match";
         serviceErrorList[8] = "This email is already registered";
         serviceErrorList[9] = "Avatar not found";
         serviceErrorList[10] = "For this operation, an unauthorized person";
         serviceErrorList[11] = "Wrong parameter";
         serviceErrorList[12] = "Missing parameter";
         serviceErrorList[13] = "Unauthorized client";
         serviceErrorList[14] = "Authorized client is not active";
         serviceErrorList[16] = "Person not found";
         serviceErrorList[17] = "Script error";
         serviceErrorList[18] = "Invalid item ID";
         serviceErrorList[19] = "Messaging exception";
         serviceErrorList[20] = "Json exception";
         serviceErrorList[21] = "Invalid rope request";
         serviceErrorList[22] = "Service not found";
         serviceErrorList[2002] = "Not enough diamond credits";
         serviceErrorList[2003] = "Not enough sanil credits";
         serviceErrorList[2008] = "You dont have valid item for this operation.";
         serviceErrorList[2009] = "You are not proper position.";
         serviceErrorList[2010] = "You have already this item.";
         serviceErrorList[5000] = "Your credits not enough.";
         serviceErrorList[5001] = "Insufficient quantity.";
         serviceErrorList[5002] = "Wrong item type.";
         serviceErrorList[5003] = "Invalid request.";
         serviceErrorList[5004] = "Already has card.";
         serviceErrorList[5005] = "Clothes";
         serviceErrorList["USER_HAS_ITEM"] = $("You already has maximum count of this item");
         serviceErrorList["EXTENSION_IDLE"] = $("Please try again in a few seconds.");
         serviceErrorList["FLOOD"] = $("You\'re doing a lot of requests, please calm down");
         serviceErrorList["NO_TRANSFERRABLE_ITEMS"] = $("Not available status for trading");
         serviceErrorList["NO_SELLABLE_ITEMS"] = $("Not available status for selling");
         serviceErrorList["HAS_BARTER"] = $("User is busy with another trade session");
         serviceErrorList["NOT_VIP"] = $("You must be VIP user for this operation");
         serviceErrorList["ALRADY_HAS_FLAT"] = $("You already have this place.");
         serviceErrorList["SYSTEM_ERROR"] = $("You got a simple problem :) You can report this problem to our moderators.");
         serviceErrorList["INSUFFICIENT_ROLE"] = $("You dont have role for this operation.");
         serviceErrorList["BUDDY_IS_NOT_ONLINE"] = $("Buddy is not online for responsing.");
         serviceErrorList["INVALID_SECURITYKEY"] = $("Invalid Security Key.");
         serviceErrorList["BANNED_FROM_ROOM"] = $("You are banned room by owner.");
         serviceErrorList["NOT_PACKAGE"] = $("Wrong item to open as package.");
         serviceErrorList["BUDDY_REQUEST_FULL_REQUESTER"] = $("The avatar you want to add as a friend has a full friend request list.");
         serviceErrorList["ROOM_PASSWORD_WRONG"] = $("your password is wrong to join room.");
         serviceErrorList["ROOM_IS_FULL"] = $("room is full.");
         serviceErrorList["FORTUNE_INSUFFICIENT_BALANCE"] = $("insufficient balance.");
         serviceErrorList["PUBLIC_MESSAGE_NOT_ALLOWED"] = $("Public messages disabled temporary");
         serviceErrorList["VISITOR_PUBLIC_MESSAGE_NOT_ALLOWED"] = $("Public messages from visitors are temporarily disabled");
         serviceErrorList["WRONG_POSITION"] = $("Wrong position to catch fish.");
         serviceErrorList["WRONG_ITEM"] = $("Wrong hand item to catch fish.");
         serviceErrorList["EMAIL_NOTACTIVATED"] = $("In order to complete this action you should first activate your email.");
         serviceErrorList["PHONE_NOTACTIVATED"] = $("In order to complete this action you should first activate your phone number.");
         serviceErrorList["ALREADY_HAS_ITEM"] = $("You already have this item");
      }
      
      public static function getMessageById(param1:String) : String
      {
         if(serviceErrorList[param1] != undefined)
         {
            return serviceErrorList[param1];
         }
         return "";
      }
      
      public static function getRoleErrorListFromIndexes(param1:Array) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(roleErrorList[param1[_loc3_]])
            {
               _loc2_ += roleErrorList[param1[_loc3_]];
               if(_loc3_ < param1.length - 1)
               {
                  _loc2_ += ",";
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getRoleErrors(param1:Array) : String
      {
         var _loc2_:String = getRoleErrorListFromIndexes(param1);
         return printf($("REQUIREMENTS"),_loc2_);
      }
   }
}

