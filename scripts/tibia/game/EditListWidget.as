package tibia.game
{
   import flash.events.Event;
   import tibia.network.Communication;
   import shared.utility.StringHelper;
   import mx.controls.TextArea;
   import flash.events.KeyboardEvent;
   import tibia.input.PreventWhitespaceInput;
   import flash.events.TextEvent;
   
   public class EditListWidget extends PopUpBase
   {
      
      private static const BUNDLE:String = "EditListWidget";
      
      public static const TYPE_UNKNOWN:int = -1;
      
      public static const TYPE_HOUSE_SUBOWNERS:int = 2;
      
      public static const TYPE_NAME_DOOR:int = 3;
      
      public static const TYPE_HOUSE_GUESTS:int = 1;
       
      
      private var m_UncommittedMaxChars:Boolean = false;
      
      protected var m_MaxChars:int = 2000;
      
      private var m_UncommittedText:Boolean = false;
      
      protected var m_Text:String = null;
      
      private var m_UncommittedType:Boolean = false;
      
      private var m_UncommittedID:Boolean = false;
      
      protected var m_ID:uint = 0;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIText:TextArea = null;
      
      protected var m_Type:int = -1;
      
      public function EditListWidget()
      {
         super();
         title = resourceManager.getString(BUNDLE,"TITLE");
         keyboardFlags = PopUpBase.KEY_ESCAPE;
         width = 300;
         height = 300;
      }
      
      private function onTextChange(param1:Event) : void
      {
         if(param1 != null)
         {
            this.m_Text = this.m_UIText.text;
         }
      }
      
      public function get text() : String
      {
         return this.m_Text;
      }
      
      override public function hide(param1:Boolean = false) : void
      {
         var _loc2_:Communication = null;
         if(param1)
         {
            _loc2_ = Tibia.s_GetCommunication();
            if(_loc2_ != null && _loc2_.isGameRunning)
            {
               _loc2_.sendCEDITLIST(this.m_Type,this.m_ID,StringHelper.s_CleanNewline(this.m_UIText.text));
            }
         }
         super.hide(param1);
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedType)
         {
            this.m_UncommittedType = false;
         }
         if(this.m_UncommittedID)
         {
            this.m_UncommittedID = false;
         }
         if(this.m_UncommittedMaxChars)
         {
            this.m_UIText.maxChars = this.m_MaxChars;
            this.m_UncommittedMaxChars = false;
         }
         if(this.m_UncommittedText)
         {
            this.m_UIText.text = this.m_Text;
            this.m_UncommittedText = false;
         }
      }
      
      public function get maxChars() : int
      {
         return this.m_MaxChars;
      }
      
      public function get ID() : uint
      {
         return this.m_ID;
      }
      
      public function set text(param1:String) : void
      {
         if(param1 != null)
         {
            param1 = StringHelper.s_Trim(param1);
            param1 = param1.substr(0,this.m_MaxChars);
         }
         if(this.m_Text != param1)
         {
            this.m_Text = param1;
            this.m_UncommittedText = true;
            invalidateProperties();
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIText = new TextArea();
            this.m_UIText.maxChars = this.m_MaxChars;
            this.m_UIText.percentHeight = 100;
            this.m_UIText.percentWidth = 100;
            this.m_UIText.text = this.m_Text;
            this.m_UIText.addEventListener(Event.CHANGE,this.onTextChange);
            this.m_UIText.addEventListener(KeyboardEvent.KEY_DOWN,PreventWhitespaceInput);
            this.m_UIText.addEventListener(TextEvent.TEXT_INPUT,PreventWhitespaceInput);
            addChild(this.m_UIText);
            this.m_UIConstructed = true;
         }
      }
      
      public function set maxChars(param1:int) : void
      {
         if(this.m_MaxChars != param1)
         {
            if(param1 < this.m_MaxChars && this.m_Text != null)
            {
               this.m_Text = StringHelper.s_Trim(this.m_Text);
               this.m_Text = this.m_Text.substr(0,param1);
               this.m_UncommittedText = true;
               invalidateProperties();
            }
            this.m_MaxChars = param1;
            this.m_UncommittedMaxChars = true;
            invalidateProperties();
         }
      }
      
      public function set type(param1:int) : void
      {
         if(param1 != TYPE_HOUSE_GUESTS && param1 != TYPE_HOUSE_SUBOWNERS && param1 != TYPE_NAME_DOOR)
         {
            param1 = TYPE_UNKNOWN;
         }
         if(this.m_Type != param1)
         {
            this.m_Type = param1;
            this.m_UncommittedType = true;
            invalidateProperties();
         }
      }
      
      public function set ID(param1:uint) : void
      {
         if(this.m_ID != param1)
         {
            this.m_ID = param1;
            this.m_UncommittedID = true;
            invalidateProperties();
         }
      }
      
      public function get type() : int
      {
         return this.m_Type;
      }
   }
}
