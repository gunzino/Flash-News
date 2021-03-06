package mx.utils
{
   import mx.core.mx_internal;
   import mx.core.ISWFBridgeProvider;
   
   use namespace mx_internal;
   
   public class SecurityUtil
   {
      
      mx_internal static const VERSION:String = "3.6.0.21751";
       
      
      public function SecurityUtil()
      {
         super();
      }
      
      public static function hasMutualTrustBetweenParentAndChild(param1:ISWFBridgeProvider) : Boolean
      {
         if(param1 && param1.childAllowsParent && param1.parentAllowsChild)
         {
            return true;
         }
         return false;
      }
   }
}
