package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ApplicationBackground;
   
   public class _ApplicationStyle
   {
       
      
      public function _ApplicationStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Application");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Application",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundGradientAlphas = [1,1];
               this.backgroundColor = 8821927;
               this.paddingBottom = 24;
               this.backgroundImage = ApplicationBackground;
               this.horizontalAlign = "center";
               this.paddingRight = 24;
               this.backgroundSize = "100%";
               this.paddingTop = 24;
               this.paddingLeft = 24;
            };
         }
      }
   }
}
