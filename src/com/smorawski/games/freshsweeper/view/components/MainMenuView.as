package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.GameModeType;
	import com.smorawski.games.freshsweeper.model.constants.MainMenuEvent;
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * This view manages the main menu.
	 * 
	 * Dispatches: MainMenuEvent.SELECTED_MODE
	 * 
	 * @author Rick Smorawski
	 */
	public class MainMenuView extends Sprite {
		/** Class Constants **/
		private static const TOP_PADDING:int = 115;
		/** Member Variables **/
		private var assetManager	:AssetManager	= null;
		// Sub Views
		private var easyButton		:Button = null;
		private var mediumButton	:Button = null;
		private var hardButton		:Button = null;
		private var challengeButton	:Button = null;
		private var helpButton		:Button = null;
		
		/**
		 * Constructor
		 * @param	assetManager
		 */
		public function MainMenuView(assetManager:AssetManager) {
			super();
			
			easyButton			= new Button();
			easyButton.width	= 300;
			easyButton.height	= 50;
			easyButton.y		= TOP_PADDING;
			easyButton.label	= "Easy";
			easyButton.addEventListener(Event.TRIGGERED, onDidTriggerEasyButton);
			addChild(easyButton);
			
			mediumButton		= new Button();
			mediumButton.width	= 300;
			mediumButton.height = 50;			
			mediumButton.y		= TOP_PADDING + 60;
			mediumButton.label 	= "Medium";
			mediumButton.addEventListener(Event.TRIGGERED, onDidTriggerMediumButton);
			addChild(mediumButton);
			
			hardButton			= new Button();	
			hardButton.width	= 300;
			hardButton.height	= 50;			
			hardButton.y		= TOP_PADDING + 120;
			hardButton.label	= "Hard";
			hardButton.addEventListener(Event.TRIGGERED, onDidTriggerHardButton);
			addChild(hardButton);	
			
			challengeButton			= new Button();
			challengeButton.width	= 300;
			challengeButton.height	= 50;					
			challengeButton.y		= TOP_PADDING + 180;
			challengeButton.label	= "Challenge";
			challengeButton.addEventListener(Event.TRIGGERED, onDidTriggerChallengeButton);
			addChild(challengeButton);
			
			helpButton			= new Button();
			helpButton.width	= 150;
			helpButton.height	= 50;
			helpButton.label	= "Instructions";
			helpButton.addEventListener(Event.TRIGGERED, onDidTriggerHelpButton);			
			helpButton.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
			addChild(helpButton);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		/**
		 * Event.ADDDED_TO_STAGE handler
		 * @param	event
		 */
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			easyButton.x		= stage.stageWidth / 2 - easyButton.width / 2;
			mediumButton.x		= stage.stageWidth / 2 - mediumButton.width / 2;
			hardButton.x 		= stage.stageWidth / 2 - hardButton.width / 2;
			challengeButton.x	= stage.stageWidth / 2 - challengeButton.width / 2;
			helpButton.x		= 0;
			helpButton.y		= stage.stageHeight - 140;
		}
		
		/**
		 * Event.REMOVED_FROM_STAGE handler
		 * @param	event
		 */
		private function onRemovedFromStage(event:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		/** Menu Selection Handlers **/
		
		private function onDidTriggerEasyButton(event:Event):void {
			dispatchEventWith(MainMenuEvent.SELECTED_MODE,false,GameModeType.EASY);
		}
		private function onDidTriggerMediumButton(event:Event):void {
			dispatchEventWith(MainMenuEvent.SELECTED_MODE,false,GameModeType.MEDIUM);
		}
		private function onDidTriggerHardButton(event:Event):void {
			dispatchEventWith(MainMenuEvent.SELECTED_MODE,false,GameModeType.HARD);
		}		
		private function onDidTriggerChallengeButton(event:Event):void {
			dispatchEventWith(MainMenuEvent.SELECTED_MODE,false,GameModeType.CHALLENGE);
		}
		private function onDidTriggerHelpButton(event:Event):void {
			dispatchEventWith(MainMenuEvent.SELECTED_HELP);
		}
		
	}

}