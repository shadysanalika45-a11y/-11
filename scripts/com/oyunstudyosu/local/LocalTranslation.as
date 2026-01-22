package com.oyunstudyosu.local
{
   import de.polygonal.core.fmt.Sprintf;
   import flash.utils.Dictionary;
   
   public class LocalTranslation
   {
      
      private static var translations:Dictionary = new Dictionary();
      
      private static var translation:Dictionary = new Dictionary();
      
      public function LocalTranslation()
      {
         super();
      }
      
      private static function init() : *
      {
         addTranslationEntry("tr","PROGRESS_LOADING","><((((‘>");
         addTranslationEntry("tr","PROGRESS_CONNECTING","Sanalika\'ya bağlanıyor...");
         addTranslationEntry("tr","PROGRESS_LANG_FILE_READY","enişte koş koş başlıyor...");
         addTranslationEntry("tr","PROGRESS_CONNECTED","necati, nerede bu kablonun diğer ucu!...");
         addTranslationEntry("tr","PROGRESS_CONNECTION_FAIL","bağlantı başarısız");
         addTranslationEntry("tr","PROGRESS_CONNECTION_RETRY","Sanalika\'ya bağlanmaya çalışılıyor (%s deneme kaldı)");
         addTranslationEntry("tr","PROGRESS_LOGINED","galiba sanırsam bağlandık kaptan");
         addTranslationEntry("tr","PROGRESS_CONFIG_READY","gereksiz dosyalar yükleniyor...");
         addTranslationEntry("tr","PROGRESS_INFO_FILE_READY","daha fazla dosya yükleniyor...");
         addTranslationEntry("tr","PROGRESS_GAME_EXTENSIONS_LOADED","ısınmadan bu kadar yükleme yapılmaz! yavaş!");
         addTranslationEntry("tr","PROGRESS_INIT_READY","roketleri ateşlemeye 3...");
         addTranslationEntry("tr","PROGRESS_GAME_READY","neredeyse pişmek üzere");
         addTranslationEntry("tr","PROGRESS_PROGRESS_FULL","doldu abi, gazla!");
         addTranslationEntry("tr","PROGRESS_LOAD_DESIGNER","dekoratorü yükle Skati...");
         addTranslationEntry("tr","PROGRESS_DESIGNER_LOADED","dekoratör yüklendi Kaptan...");
         addTranslationEntry("tr","PROGRESS_JOINING_USER_ROOM","katıl kurt");
         addTranslationEntry("tr","PROGRESS_ROOM_FILES","oda dosyalarını da yükle güzel güzel");
         addTranslationEntry("tr","PROGRESS_QUEUE","kuyrukta bekliyoruz - %s. sıradasın!");
         addTranslationEntry("tr","The game could not be loaded","Oyun yüklenemedi");
         addTranslationEntry("tr","LOGIN_ACCOUNT_REVIEWING_TITLE","Hesap inceleniyor");
         addTranslationEntry("tr","LOGIN_ACCOUNT_REVIEWING","Hesap şu anda destek ekibimiz ({0}) tarafından inceleniyor.\nLütfen daha sonra tekrar giriş yapmayı deneyin.");
         addTranslationEntry("tr","LOGIN_ERROR_TITLE","Hata");
         addTranslationEntry("tr","LOGIN_ACCOUNT_NOT_ACTIVE","Hesabınız aktif değil");
         addTranslationEntry("tr","LOGIN_BANNED_USER","%s tarihine kadar uzaklaştırıldınız!!!");
         addTranslationEntry("tr","LOGIN_BANNED_USER_WITH_REASON","%1$s tarihine kadar \'%2$s\' sebebiyle uzaklaştırıldınız!!!");
         addTranslationEntry("tr","LOGIN_IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED","IP adresinizin bağlantı limiti aşıldı");
         addTranslationEntry("tr","Profanity","küfür/hakaret");
         addTranslationEntry("tr","Advertisement","reklam");
         addTranslationEntry("tr","Political","siyasi söylem");
         addTranslationEntry("tr","Religious","dini değerlere saygısızlık");
         addTranslationEntry("tr","Perversity","istismar/taciz");
         addTranslationEntry("tr","Cheat","hile");
         addTranslationEntry("ca","PROGRESS_LOADING","><((((‘>");
         addTranslationEntry("ca","PROGRESS_CONNECTING","conectando a sanalika...");
         addTranslationEntry("ca","PROGRESS_LANG_FILE_READY","Que? no no no y el archivo?...");
         addTranslationEntry("ca","PROGRESS_CONNECTED","si! para ese puerto!");
         addTranslationEntry("ca","PROGRESS_CONNECTION_FAIL","no se puede conectar");
         addTranslationEntry("ca","PROGRESS_CONNECTION_RETRY","intentarlo de nuevo");
         addTranslationEntry("ca","PROGRESS_LOGINED","entrando a un server de aliens?");
         addTranslationEntry("ca","PROGRESS_CONFIG_READY","contando estrellas...");
         addTranslationEntry("ca","PROGRESS_INFO_FILE_READY","todavía cargando archivos extraños...huh");
         addTranslationEntry("ca","PROGRESS_GAME_EXTENSIONS_LOADED","extendiendo reticulas");
         addTranslationEntry("ca","PROGRESS_INIT_READY","llegando a Latinoamérica...");
         addTranslationEntry("ca","PROGRESS_GAME_READY","listo para cumbias y regueton...");
         addTranslationEntry("ca","PROGRESS_PROGRESS_FULL","progreso completado");
         addTranslationEntry("ca","PROGRESS_LOAD_DESIGNER","cargando diseños...");
         addTranslationEntry("ca","PROGRESS_DESIGNER_LOADED","diseño cargado...");
         addTranslationEntry("ca","PROGRESS_JOINING_USER_ROOM","uniendose a salas de usuario");
         addTranslationEntry("ca","PROGRESS_ROOM_FILES","archivos de salas cargados");
         addTranslationEntry("ca","PROGRESS_QUEUE","esperando en la cola - ¡Estás en %sº lugar!");
         addTranslationEntry("ca","LOGIN_ACCOUNT_REVIEWING_TITLE","Cuenta en revisión");
         addTranslationEntry("ca","LOGIN_ACCOUNT_REVIEWING","La cuenta está siendo revisada por nuestro equipo de soporte ({0}).\nPor favor, intente iniciar sesión de nuevo más tarde.");
         addTranslationEntry("ca","LOGIN_ERROR_TITLE","Error de inicio de sesión");
         addTranslationEntry("ca","LOGIN_ACCOUNT_NOT_ACTIVE","La cuenta no está activa");
         addTranslationEntry("ca","LOGIN_BANNED_USER","Estás baneado hasta el %s!!!");
         addTranslationEntry("ca","LOGIN_BANNED_USER_WITH_REASON","Has sido baneado por \'%2$s\' ¡¡¡hasta %1$s!!!");
         addTranslationEntry("ca","LOGIN_IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED","Has alcanzado el límite de conexiones desde la misma IP.");
         addTranslationEntry("ca","Profanity","jurar/insultar");
         addTranslationEntry("ca","Advertisement","publicidad");
         addTranslationEntry("ca","Political","discurso político");
         addTranslationEntry("ca","Religious","profanación de los valores religiosos");
         addTranslationEntry("ca","Perversity","abuso/acoso");
         addTranslationEntry("ca","Cheat","engañar");
         addTranslationEntry("en","PROGRESS_LOADING","><((((‘>");
         addTranslationEntry("en","PROGRESS_CONNECTING","connecting to Sanalika...");
         addTranslationEntry("en","PROGRESS_LANG_FILE_READY","what? no no not that file...");
         addTranslationEntry("en","PROGRESS_CONNECTED","yes! plug that cable!");
         addTranslationEntry("en","PROGRESS_CONNECTION_FAIL","connect fail");
         addTranslationEntry("en","PROGRESS_CONNECTION_RETRY","");
         addTranslationEntry("en","PROGRESS_LOGINED","logged in to alien server?");
         addTranslationEntry("en","PROGRESS_CONFIG_READY","counting stars...");
         addTranslationEntry("en","PROGRESS_INFO_FILE_READY","still loading some useless files...huh");
         addTranslationEntry("en","PROGRESS_GAME_EXTENSIONS_LOADED","extending muscles");
         addTranslationEntry("en","PROGRESS_INIT_READY","initiating rockets...");
         addTranslationEntry("en","PROGRESS_GAME_READY","ready for some rock\'n roll...");
         addTranslationEntry("en","PROGRESS_PROGRESS_FULL","progress full");
         addTranslationEntry("en","PROGRESS_LOAD_DESIGNER","loading designer...");
         addTranslationEntry("en","PROGRESS_DESIGNER_LOADED","designer loaded...");
         addTranslationEntry("en","PROGRESS_JOINING_USER_ROOM","joining user room");
         addTranslationEntry("en","PROGRESS_ROOM_FILES","room files are loading");
         addTranslationEntry("en","PROGRESS_QUEUE","waiting in the queue - You\'re in the %s!");
         addTranslationEntry("en","LOGIN_ACCOUNT_REVIEWING_TITLE","Account is under review");
         addTranslationEntry("en","LOGIN_ACCOUNT_REVIEWING","The account is currently under review by our support team ({0}).\nPlease try logging in again later.");
         addTranslationEntry("en","LOGIN_ERROR_TITLE","Login error");
         addTranslationEntry("en","LOGIN_ACCOUNT_NOT_ACTIVE","Account is not active");
         addTranslationEntry("en","LOGIN_BANNED_USER","You are banned until %s!!!");
         addTranslationEntry("en","LOGIN_BANNED_USER_WITH_REASON","You have been banned for \'%2$s\' reason until %1$s!!!");
         addTranslationEntry("en","LOGIN_IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED","You have exceeded the maximum number of connections from your IP address.");
         addTranslationEntry("en","Profanity","swearing/insult");
         addTranslationEntry("en","Advertisement","advertisement");
         addTranslationEntry("en","Political","political discourse");
         addTranslationEntry("en","Religious","desecration of religious values");
         addTranslationEntry("en","Perversity","abuse/harassment");
         addTranslationEntry("en","Cheat","cheating");
         addTranslationEntry("ru","PROGRESS_LOADING","><((((‘>");
         addTranslationEntry("ru","PROGRESS_CONNECTING","Подключение к Sanalika..");
         addTranslationEntry("ru","PROGRESS_LANG_FILE_READY","что? нет, нет, не этот файл...");
         addTranslationEntry("ru","PROGRESS_CONNECTED","Да! Подключи этот кабель!");
         addTranslationEntry("ru","PROGRESS_CONNECTION_FAIL","");
         addTranslationEntry("ru","PROGRESS_CONNECTION_RETRY","");
         addTranslationEntry("ru","PROGRESS_LOGINED","Вход в чужой сервер");
         addTranslationEntry("ru","PROGRESS_CONFIG_READY","Подсчет звезд");
         addTranslationEntry("ru","PROGRESS_INFO_FILE_READY","хех..всё ещё загружает ненужные");
         addTranslationEntry("ru","PROGRESS_GAME_EXTENSIONS_LOADED","расширение мышц");
         addTranslationEntry("ru","PROGRESS_INIT_READY","иницирующие ракеты");
         addTranslationEntry("ru","PROGRESS_GAME_READY","готовы к рок-н-роллу");
         addTranslationEntry("ru","PROGRESS_PROGRESS_FULL","полный прогресс");
         addTranslationEntry("ru","PROGRESS_LOAD_DESIGNER","загрузка дизайнера");
         addTranslationEntry("ru","PROGRESS_DESIGNER_LOADED","дизайнер загружен");
         addTranslationEntry("ru","PROGRESS_JOINING_USER_ROOM","присоединение к пользовательской комнате");
         addTranslationEntry("ru","PROGRESS_ROOM_FILES","файлы комнаты загружаются");
         addTranslationEntry("ru","PROGRESS_QUEUE","ожидание в очереди - Вы - номер %s!");
         addTranslationEntry("ru","LOGIN_ACCOUNT_REVIEWING_TITLE","Счет на рассмотрении");
         addTranslationEntry("ru","LOGIN_ACCOUNT_REVIEWING","В настоящее время аккаунт рассматривается нашей службой поддержки ({0}).\nПопробуйте войти в систему позже.");
         addTranslationEntry("ru","LOGIN_ERROR_TITLE","Ошибка входа");
         addTranslationEntry("ru","LOGIN_ACCOUNT_NOT_ACTIVE","Ваш аккаунт не активирован.");
         addTranslationEntry("ru","LOGIN_BANNED_USER","Вы заблокированы до %s!!!");
         addTranslationEntry("ru","LOGIN_BANNED_USER_WITH_REASON","Вы были заблокированы по \'%2$s\' причине до %1$s!!!");
         addTranslationEntry("ru","LOGIN_IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED","Вы превысили максимальное количество подключений с одного IP-адреса.");
         addTranslationEntry("ru","Profanity","ругань/оскорбление");
         addTranslationEntry("ru","Advertisement","Реклама");
         addTranslationEntry("ru","Political","политический дискурс");
         addTranslationEntry("ru","Religious","осквернение религиозных ценностей");
         addTranslationEntry("ru","Perversity","оскорбления/домогательства");
         addTranslationEntry("ru","Cheat","мошенничество");
         addTranslationEntry("ar","PROGRESS_LOADING","جاري التحميل");
         addTranslationEntry("ar","PROGRESS_CONNECTING","جاري الاتصال بسناليكا ...");
         addTranslationEntry("ar","PROGRESS_LANG_FILE_READY","هيا أسرع يا صديقي .. نحن على وشك البدء ...");
         addTranslationEntry("ar","PROGRESS_CONNECTED","يا ناجي ، أين الطرف الآخر لهذا الكابل !");
         addTranslationEntry("ar","PROGRESS_CONNECTION_FAIL","فشل الاتصال");
         addTranslationEntry("ar","PROGRESS_CONNECTION_RETRY","محاولة الاتصال بـ سناليكا (بقية %s محاولات)");
         addTranslationEntry("ar","PROGRESS_LOGINED","على الأغلب أظن أننا على اتصال أيها القبطان");
         addTranslationEntry("ar","PROGRESS_CONFIG_READY","تحميل ملفات لا لزوم لها ...");
         addTranslationEntry("ar","PROGRESS_INFO_FILE_READY","جاري تحميل المزيد من الملفات ...");
         addTranslationEntry("ar","PROGRESS_GAME_EXTENSIONS_LOADED","ينبغي ألا يتم التحميل بهذا القدر قبل استكمال الإقلاع ! على مهلك !");
         addTranslationEntry("ar","PROGRESS_INIT_READY","نحن على وشك الإقلاع .. ثلاثة .. اثنان .. واحد");
         addTranslationEntry("ar","PROGRESS_GAME_READY"," أين انت نحن تقريبا أنتهينا ...");
         addTranslationEntry("ar","PROGRESS_PROGRESS_FULL","لقد امتلآت بالغاز");
         addTranslationEntry("ar","PROGRESS_LOAD_DESIGNER","جاري تحميل الديكور ...");
         addTranslationEntry("ar","PROGRESS_DESIGNER_LOADED"," لقد تم تحميل الديكور أيها القبطان ...");
         addTranslationEntry("ar","PROGRESS_JOINING_USER_ROOM"," لقد تم ...");
         addTranslationEntry("ar","PROGRESS_ROOM_FILES"," جاري تحميل ملفات الغرفة ...");
         addTranslationEntry("ar","PROGRESS_QUEUE","نحن في قائمة الانتظار\n أنت في المركز %s");
         addTranslationEntry("ar","LOGIN_ACCOUNT_REVIEWING_TITLE","الحساب قيد المراجعة");
         addTranslationEntry("ar","LOGIN_ACCOUNT_REVIEWING","الحساب قيد المراجعة حاليًا بواسطة فريق الدعم ({0}).\n يرجى محاولة تسجيل الدخول مرة أخرى في وقت لاحق.");
         addTranslationEntry("ar","LOGIN_ERROR_TITLE","خطأ في تسجيل الدخول");
         addTranslationEntry("ar","LOGIN_ACCOUNT_NOT_ACTIVE","الحساب غير نشط");
         addTranslationEntry("ar","LOGIN_BANNED_USER","تم حظرك حتى %s !!!");
         addTranslationEntry("ar","LOGIN_BANNED_USER_WITH_REASON","\'لقد تم حظرك لسبب %2$s\' حتى %1$s !!!");
         addTranslationEntry("ar","LOGIN_IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED","لقد تجاوزت الحد الأقصى للاتصال بعنوان IP");
         addTranslationEntry("ar","Profanity","الشتم/الاهانة");
         addTranslationEntry("ar","Advertisement","الاعلانات");
         addTranslationEntry("ar","Political","المشاركة السياسية");
         addTranslationEntry("ar","Religious","عدم احترام القيم الدينية");
         addTranslationEntry("ar","Perversity","سوء المعاملة/التحرش");
         addTranslationEntry("ar","Cheat","النصب / السرقة");
      }
      
      private static function addTranslationEntry(param1:String, param2:String, param3:String) : *
      {
         if(translations[param1] == null)
         {
            translations[param1] = new Dictionary();
         }
         translations[param1][param2] = param3;
      }
      
      public static function setLanguage(param1:String) : void
      {
         init();
         if(translations[param1] == null)
         {
            param1 = "en";
         }
         translation = translations[param1];
      }
      
      public static function translate(param1:String, ... rest) : String
      {
         if(!exists(param1))
         {
            return param1;
         }
         return Sprintf.format(translation[param1],rest);
      }
      
      public static function exists(param1:String) : Boolean
      {
         return translation[param1] != null;
      }
   }
}

