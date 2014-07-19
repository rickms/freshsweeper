package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import com.smorawski.games.freshsweeper.model.constants.GameEvent;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.GameConfigVO;
	import feathers.controls.Button;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * This view manages the Game Play, includes game board and UI.
	 * 
	 * @author Rick Smorawski
	 */
	public class GameView extends Sprite {
		/** Member Variables **/
		private var assetManager	:AssetManager	= null;
		private var gameConfig		:GameConfigVO	= null;
		// Sub-Components
		private var scrim			:Quad			= null;
		private var gameBoardView	:GameBoardView  = null;
		private var quitButton		:Button 		= null;
		private var resultDialog	:DisplayObject	= null;
		private var markText		:TextField		= null;
		
		/**
		 * Constructor
		 * 
		 * @param	assetManager
		 * @param	gameConfig
		 */
		public function GameView(assetManager:AssetManager, gameConfig:GameConfigVO) {
			super();
			this.assetManager 	= assetManager;
			this.gameConfig		= gameConfig;

			// Quit Button
			quitButton = new Button();
			quitButton.width = 200;
			quitButton.height = 50;
			quitButton.label = "Quit";			
			quitButton.addEventListener(Event.TRIGGERED, onDidTriggerQuit);
			addChild(quitButton);
			
			// Event Listeners
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			markText = new TextField(340, 40, "Press 'F' to mark seeds", Assets.FONT_GENERAL, 24, Color.WHITE);
			markText.batchable = true;
			markText.hAlign = HAlign.LEFT;
			addChild(markText);
		}
		
		/**
		 * Initialize the game view.  This is done separate from the constructor
		 * because it is also called by the GameMediator when the game is restarted
		 */
		public function init():void {			
			if(scrim == null) {
				scrim = new Quad(stage.stageWidth, stage.stageHeight, Color.BLACK);
				scrim.y = -140;
				scrim.alpha = 0.76;
			} else {
				if (scrim.parent != null) {
					scrim.removeFromParent();
				}
			}
			
			// Game Board
			
			// Remove Existing board;
			if (gameBoardView != null && gameBoardView != null) {
				gameBoardView.removeFromParent();
			}
			
			// Create and and a new game board view
			gameBoardView = new GameBoardView(assetManager, gameConfig);
			addChild(gameBoardView);	
			
			gameBoardView.x = stage.stageWidth / 2 - gameBoardView.width / 2;
			gameBoardView.y = ((stage.stageHeight) / 2 - gameBoardView.height / 2) - 140 ;
			
			// Position Quit Button;
			quitButton.alignPivot(HAlign.RIGHT, VAlign.BOTTOM);
			quitButton.x = stage.stageWidth;
			quitButton.y = stage.stageHeight - 140;
			
			markText.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
			markText.x = 0;
			markText.y = stage.stageHeight - 140;
		}

		/**
		 * Sets a cell's info, revealing it to the player.
		 * @param	cell
		 */
		public function setCellInfo(cell:CellVO):void {
			gameBoardView.setCellInfo(cell);
		}
		
		/**
		 * Show Game Won Messaging/Menu
		 */
		public function showGameWon():void {
			addChild(scrim);
			
			resultDialog = new ResultDialogView(assetManager, "You Win!");
			addChild(resultDialog);			

			resultDialog.x = stage.stageWidth / 2 - resultDialog.width / 2;
			resultDialog.y = (stage.stageHeight / 2 - resultDialog.height / 2) - 140;
			resultDialog.addEventListener(GameEvent.QUIT, onDialogEvent);
			resultDialog.addEventListener(GameEvent.RESTART, onDialogEvent);			
		}
		
		/**
		 * Show the Game Lost Messaing/Menu
		 */
		public function showGameLost():void {
			addChild(scrim);
			
			resultDialog = new ResultDialogView(assetManager, "You Lose!");
			addChild(resultDialog);			

			resultDialog.x = stage.stageWidth / 2 - resultDialog.width / 2;
			resultDialog.y = (stage.stageHeight / 2 - resultDialog.height / 2) - 140;
			resultDialog.addEventListener(GameEvent.QUIT, onDialogEvent);
			resultDialog.addEventListener(GameEvent.RESTART, onDialogEvent);					
		}
		
		/**
		 * Handle Keyboard Events
		 * @param	event
		 */
		private function onKeyUp(event:KeyboardEvent):void {
			// 'F' key press
			if (event.keyCode == 70) {
				gameBoardView.markSelected();
			}
		}
		
		/**
		 * Player clicked quit
		 */
		private function onDidTriggerQuit(event:Event = null):void {
			dispatchEventWith(GameEvent.QUIT);
		}
		
		/**
		 * And event was fired from the ResultDialogView. 
		 * @param	event
		 */
		private function onDialogEvent(event:Event):void {
			if (scrim.parent != null) {
				scrim.removeFromParent();
			}
			
			if (resultDialog != null && resultDialog.parent != null) {
				resultDialog.removeFromParent();
			}
		}
		
		/**
		 * Event.ADDED_TO_STAGE handler
		 * @param	event
		 */
		private function onAddedToStage(event:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
			init();
		}
		
 	}
}