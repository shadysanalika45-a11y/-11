package com.oyunstudyosu.local
{
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class GetText extends EventDispatcher
   {
      
      public static var fileServer:String;
      
      public static var version:String;
      
      public static var debugMode:Boolean;
      
      public static const iso639_languageDict:Object = {
         "aa":"Afar. ",
         "ab":"Abkhazian",
         "ae":"Avestan",
         "af":"Afrikaans",
         "am":"Amharic",
         "ar":"Arabic",
         "as":"Assamese",
         "ay":"Aymara",
         "az":"Azerbaijani",
         "ba":"Bashkir",
         "be":"Byelorussian; Belarusian",
         "bg":"Bulgarian",
         "bh":"Bihari",
         "bi":"Bislama",
         "bn":"Bengali; Bangla",
         "bo":"Tibetan",
         "br":"Breton",
         "bs":"Bosnian",
         "ca":"Catalan",
         "ce":"Chechen",
         "ch":"Chamorro",
         "co":"Corsican",
         "cs":"Czech",
         "cu":"Church Slavic",
         "cv":"Chuvash",
         "cy":"Welsh",
         "da":"Danish",
         "de":"German",
         "dz":"Dzongkha; Bhutani",
         "el":"Greek",
         "en":"English",
         "eo":"Esperanto",
         "es":"Spanish",
         "et":"Estonian",
         "eu":"Basque",
         "fa":"Persian",
         "fi":"Finnish",
         "fj":"Fijian; Fiji",
         "fo":"Faroese",
         "fr":"French",
         "fy":"Frisian",
         "ga":"Irish",
         "gd":"Scots; Gaelic",
         "gl":"Gallegan; Galician",
         "gn":"Guarani",
         "gu":"Gujarati",
         "gv":"Manx",
         "ha":"Hausa (?)",
         "he":"Hebrew (formerly iw)",
         "hi":"Hindi",
         "ho":"Hiri Motu",
         "hr":"Croatian",
         "hu":"Hungarian",
         "hy":"Armenian",
         "hz":"Herero",
         "ia":"Interlingua",
         "id":"Indonesian (formerly in)",
         "ie":"Interlingue",
         "ik":"Inupiak",
         "io":"Ido",
         "is":"Icelandic",
         "it":"Italian",
         "iu":"Inuktitut",
         "ja":"Japanese",
         "jv":"Javanese",
         "ka":"Georgian",
         "ki":"Kikuyu",
         "kj":"Kuanyama",
         "kk":"Kazakh",
         "kl":"Kalaallisut; Greenlandic",
         "km":"Khmer; Cambodian",
         "kn":"Kannada",
         "ko":"Korean",
         "ks":"Kashmiri",
         "ku":"Kurdish",
         "kv":"Komi",
         "kw":"Cornish",
         "ky":"Kirghiz",
         "la":"Latin",
         "lb":"Letzeburgesch",
         "ln":"Lingala",
         "lo":"Lao; Laotian",
         "lt":"Lithuanian",
         "lv":"Latvian; Lettish",
         "mg":"Malagasy",
         "mh":"Marshall",
         "mi":"Maori",
         "mk":"Macedonian",
         "ml":"Malayalam",
         "mn":"Mongolian",
         "mo":"Moldavian",
         "mr":"Marathi",
         "ms":"Malay",
         "mt":"Maltese",
         "my":"Burmese",
         "na":"Nauru",
         "nb":"Norwegian BokmÃ¥l",
         "nd":"Ndebele, North",
         "ne":"Nepali",
         "ng":"Ndonga",
         "nl":"Dutch",
         "nn":"Norwegian Nynorsk",
         "no":"Norwegian",
         "nr":"Ndebele, South",
         "nv":"Navajo",
         "ny":"Chichewa; Nyanja",
         "oc":"Occitan; ProvenÃ§al",
         "om":"(Afan) Oromo",
         "or":"Oriya",
         "os":"Ossetian; Ossetic",
         "pa":"Panjabi; Punjabi",
         "pi":"Pali",
         "pl":"Polish",
         "ps":"Pashto, Pushto",
         "pt":"Portuguese",
         "qu":"Quechua",
         "rm":"Rhaeto-Romance",
         "rn":"Rundi; Kirundi",
         "ro":"Romanian",
         "ru":"Russian",
         "rw":"Kinyarwanda",
         "sa":"Sanskrit",
         "sc":"Sardinian",
         "sd":"Sindhi",
         "se":"Northern Sami",
         "sg":"Sango; Sangro",
         "si":"Sinhalese",
         "sk":"Slovak",
         "sl":"Slovenian",
         "sm":"Samoan",
         "sn":"Shona",
         "so":"Somali",
         "sq":"Albanian",
         "sr":"Serbian",
         "ss":"Swati; Siswati",
         "st":"Sesotho; Sotho, Southern",
         "su":"Sundanese",
         "sv":"Swedish",
         "sw":"Swahili",
         "ta":"Tamil",
         "te":"Telugu",
         "tg":"Tajik",
         "th":"Thai",
         "ti":"Tigrinya",
         "tk":"Turkmen",
         "tl":"Tagalog",
         "tn":"Tswana; Setswana",
         "to":"Tonga",
         "tr":"Turkish",
         "ts":"Tsonga",
         "tt":"Tatar",
         "tw":"Twi",
         "ty":"Tahitian",
         "ug":"Uighur",
         "uk":"Ukrainian",
         "ur":"Urdu",
         "uz":"Uzbek",
         "vi":"Vietnamese",
         "vo":"VolapÃ¼k; Volapuk",
         "wa":"Walloon",
         "wo":"Wolof",
         "xh":"Xhosa",
         "yi":"Yiddish (formerly ji)",
         "yo":"Yoruba",
         "za":"Zhuang",
         "zh":"Chinese",
         "zh_tw":"Chinese Transitional",
         "zh_cn":"Chinese Simplified",
         "zu":"Zulu"
      };
      
      private var translations:Object;
      
      private var name:String;
      
      private var language:String;
      
      private var charset:String;
      
      private var info:Object;
      
      public function GetText(param1:String, param2:Boolean)
      {
         super();
         this.name = FindLanguageInfo(param1);
         this.language = param1;
         if(param2)
         {
            if(Connectr.instance.configModel != null)
            {
               Connectr.instance.configModel.listenVariable("langFile",this.updateLangFile);
            }
         }
      }
      
      public static function FindLanguageInfo(param1:String) : String
      {
         if(iso639_languageDict.hasOwnProperty(param1))
         {
            return iso639_languageDict[param1];
         }
         return "";
      }
      
      private function updateLangFile(param1:String) : void
      {
         Connectr.instance.gameModel.languageFileVersion = version = "/static/" + param1 + ".mo";
         this.install();
      }
      
      final public function install() : void
      {
         var _loc1_:String = null;
         _loc1_ = fileServer + version;
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         var _loc3_:URLStream = new URLStream();
         _loc3_.addEventListener(Event.COMPLETE,this.handleEvent);
         _loc3_.addEventListener(Event.OPEN,this.handleEvent);
         _loc3_.addEventListener(ProgressEvent.PROGRESS,this.handleEvent);
         _loc3_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.handleEvent);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleEvent);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleEvent);
         _loc3_.load(_loc2_);
      }
      
      public function getLocale() : String
      {
         return this.language;
      }
      
      protected function handleEvent(param1:Event) : void
      {
         var evt:Event;
         var byte:ByteArray = null;
         var retObject:Object = null;
         var errEvent:ErrorEvent = null;
         var event:Event = param1;
         if(event.type == Event.COMPLETE)
         {
            byte = new ByteArray();
            byte.endian = Endian.LITTLE_ENDIAN;
            event.target.readBytes(byte,0,event.target.bytesAvailable);
            try
            {
               retObject = Parser.parse(byte);
               this.translations = retObject.translation;
               this.info = retObject.info;
               this.charset = retObject.charset;
            }
            catch(e:Error)
            {
               errEvent = new ErrorEvent(ErrorEvent.ERROR,true,false,"EOFError: " + e.message);
               this.dispatchEvent(errEvent);
               return;
            }
         }
         evt = new Event(event.type,true,true);
         this.dispatchEvent(evt);
      }
      
      public function translate(param1:String) : String
      {
         if(this.translations == null)
         {
            return param1;
         }
         if(this.translations[param1])
         {
            return this.translations[param1];
         }
         return param1;
      }
      
      public function update(param1:String, param2:String) : void
      {
         this.translations[param1] = param2;
      }
   }
}

