package game.gui.popups
{
   import com.dchoc.graphics.DCResourceManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import game.gui.AutoTextField;
   import game.gui.IconAdapter;
   import game.gui.IconLoader;
   import game.gui.StylizedHeaderClip;
   import game.missions.Mission;
   import game.states.GameState;
   
   public class TutorialWindow extends PopUpWindow
   {
       
      
      private var mMission:Mission;
      
      private var mSpeechBubble:MovieClip;
      
      private var mCharacter:MovieClip;
      
      public function TutorialWindow()
      {
         var _loc1_:Class = DCResourceManager.getInstance().getSWFClass(Config.SWF_POPUPS_START_NAME,"popup_tutorial");
         super(new _loc1_());
      }
      
      public function Activate(param1:Function, param2:Mission) : void
      {
         var _loc3_:StylizedHeaderClip = null;
         mDoneCallback = param1;
         this.mMission = param2;
         if(Config.FOR_IPHONE_PLATFORM)
         {
            x = GameState.mInstance.getStageWidth() / 3;
            y = 2 * GameState.mInstance.getStageHeight() / 3;
         }
         else
         {
            x = GameState.mInstance.getStageWidth() / 2;
            y = GameState.mInstance.getStageHeight();
         }
         _loc3_ = new StylizedHeaderClip(mClip.getChildByName("Header") as MovieClip,param2.mTitle);
         var _loc4_:AutoTextField;
         (_loc4_ = new AutoTextField(mClip.getChildByName("Text_Description") as TextField)).setText(param2.mDescription);
         mouseEnabled = false;
         mouseChildren = false;
         if(param2.mNarratorCharacter)
         {
            this.installCharacter();
         }
         doOpeningTransition();
      }
      
      override public function alignToScreen() : void
      {
         if(Config.FOR_IPHONE_PLATFORM)
         {
            x = GameState.mInstance.getStageWidth() / 3;
            y = 2 * GameState.mInstance.getStageHeight() / 3;
         }
         else
         {
            x = GameState.mInstance.getStageWidth() / 2;
            y = GameState.mInstance.getStageHeight();
         }
      }
      
      private function installCharacter() : void
      {
         if(Boolean(this.mCharacter) && Boolean(this.mCharacter.parent))
         {
            this.mCharacter.parent.removeChild(this.mCharacter);
         }
         var _loc1_:MovieClip = null;
         if(FeatureTuner.USE_CHARACTER_DIALOQUE)
         {
            _loc1_ = mClip.getChildByName("Icon_Character") as MovieClip;
         }
         var _loc2_:Array = (this.mMission.mNarratorCharacter.Graphic as String).split("/");
         IconLoader.addIcon(_loc1_,new IconAdapter(_loc2_[2],_loc2_[0] + "/" + _loc2_[1]));
      }
   }
}
