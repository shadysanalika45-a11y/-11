package feathers.style
{
   public interface ITheme
   {
      
      function getStyleProvider(param1:IStyleObject) : IStyleProvider;
      
      function dispose() : void;
   }
}

