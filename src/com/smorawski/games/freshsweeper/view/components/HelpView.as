package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import com.smorawski.games.freshsweeper.model.constants.HelpEvent;
	import feathers.controls.Button;
	import feathers.controls.ScrollText;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * View to display the Help
	 * @author Rick Smorawski
	 */
	public class HelpView extends Sprite {
		/** Member Variable **/
		private var assetManager	:AssetManager	= null;

		// Embed the help html/css
		[Embed(source = "../../../../../../help.html", mimeType = "application/octet-stream")]
		private var helpTextData:Class;
		[Embed(source = "../../../../../../help.css", mimeType = "application/octet-stream")]
		private var helpStyleData:Class;		
		private var helpText		:String;
		private var helpStyles		:String;
		// Sub Components
		private var helpBox			:Sprite = null;
		private var mainMenuButton	:Button = null;

		/**
		 * Constructor
		 * @param	assetManager
		 */
		public function HelpView(assetManager:AssetManager) {
			super();
			this.assetManager = assetManager;
			
			// Convert the help embeds to strings
			var data:ByteArray = new helpTextData() as ByteArray;
			helpText = data.toString();			
			data = new helpStyleData() as ByteArray;
			helpStyles = data.toString();
			
			helpBox = new Sprite();
			
			var bg:Scale9Image = new Scale9Image(new Scale9Textures(assetManager.getTexture(Assets.UI_GAME_FRAME), new Rectangle(17, 17, 9, 9)));
			bg.width	= 768
			bg.height	= 384
			helpBox.addChild(bg);
			
			var scrollText:ScrollText = new ScrollText;
			scrollText.isHTML = true;
			scrollText.x = 17;
			scrollText.y = 17;
			scrollText.text = helpText;
			scrollText.styleSheet = new StyleSheet();
			scrollText.styleSheet.parseCSS(helpStyles);
			scrollText.width = 768 - 34;
			scrollText.height = 384 - 34;
			helpBox.addChild(scrollText);			
			addChild(helpBox);
			
			mainMenuButton = new Button();
			mainMenuButton.width = 150;
			mainMenuButton.height = 50;
			mainMenuButton.label = "Return To Main Menu";			
			mainMenuButton.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			mainMenuButton.addEventListener(Event.TRIGGERED, onMainMenuButtonTriggered);
			addChild(mainMenuButton);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Event.ADDED_TO_STAGE handler.
		 * @param	event
		 */
		private function onAddedToStage(event:Event):void { 
			trace(stage.stageWidth + ", " + helpBox.width);
			helpBox.x = stage.stageWidth / 2 - helpBox.width / 2;
		
			mainMenuButton.y = stage.stageHeight - 140;		
			mainMenuButton.x = stage.stageWidth / 2;
		}
		
		/**
		 * Main menu click handler
		 * @param	event
		 */
		private function onMainMenuButtonTriggered(event:Event):void {
			dispatchEventWith(HelpEvent.SELECTED_QUIT);
		}
	}

}