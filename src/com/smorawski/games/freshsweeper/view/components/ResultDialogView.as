package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import com.smorawski.games.freshsweeper.model.constants.GameEvent;
	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	
	/**
	 * This view shows the win/lose dialog
	 * 
	 * @author Rick Smorawski
	 */
	public class ResultDialogView extends Sprite {
		/** Member Variables **/
		private var assetManager	:AssetManager	= null;
		// Sub Components
		private var bg				:Scale9Image	= null;
		private var title			:TextField		= null;
		private var quitButton		:Button 		= null;
		private var restartButton	:Button			= null;

		/**
		 * Constructor
		 * @param	assetManager
		 * @param	titleText
		 */
		public function ResultDialogView(assetManager:AssetManager, titleText:String) {
			super();			
			this.assetManager = assetManager;
			
			bg = new Scale9Image(new Scale9Textures(assetManager.getTexture(Assets.UI_GAME_FRAME), new Rectangle(17, 17, 9, 9)));
			bg.width	= 344;
			bg.height	= 84;
			addChild(bg);
			
			title = new TextField(340, 80, titleText, Assets.FONT_GENERAL, 64, Color.WHITE);
			title.batchable = true;
			title.x = 0;
			title.y = -64;
			addChild(title);
			
			quitButton = new Button();
			quitButton.width = 150;
			quitButton.height = 50;
			quitButton.label = "Quit";			
			quitButton.x = 17;
			quitButton.y = 17;			
			quitButton.addEventListener(Event.TRIGGERED, onTriggeredQuitButton);
			addChild(quitButton);
			
			restartButton = new Button();
			restartButton.width = 150;
			restartButton.height = 50;
			restartButton.label = "Play Again";
			restartButton.x = quitButton.x + quitButton.width + 5;
			restartButton.y = quitButton.y;			
			restartButton.addEventListener(Event.TRIGGERED, onTriggeredRestartButton);
			addChild(restartButton);
		}
		
		private function onTriggeredQuitButton(event:Event):void {
			dispatchEventWith(GameEvent.QUIT, true);
		}
		
		private function onTriggeredRestartButton(event:Event):void {
			dispatchEventWith(GameEvent.RESTART, true);
		}
	}

}