package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import com.smorawski.games.freshsweeper.model.constants.SceneTransitionDirection;
	import feathers.themes.MetalWorksDesktopTheme;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	/**
	 * The root starling display element.  Acts as a director for transitioning from screen to screen.
	 * @author Rick Smorawski
	 */
	public class RootView extends Sprite {
		// Class Variables
		private static const HEADER_HEIGHT	:int = 140;
		// Member Variables
		private var _currentScene	:DisplayObject = null;
		private var assetManager	:AssetManager = null;
		
		/**
		 * Constructor;
		 */
		public function RootView(){
			super();		
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}	
		
		/**
		 * Event.ADDED_TO_STAGE handler
		 * @param	event
		 */
		private function onAddedToStage(event:Event):void {
			new MetalWorksDesktopTheme();	// Init feathers theme
		}
		
		/**
		 * Initialize the stage (once assets are loaded).
		 * 
		 * In this implementation there is always one static header/bg and new scenes are slid in.
		 * 
		 * @param	assetManager
		 */
		public function init(assetManager:AssetManager):void {
			this.assetManager = assetManager;
			var bg:Image = new Image(assetManager.getTexture(Assets.BACKGROUND));
			addChildAt(bg, 0);		
			
			var logo:Image = new Image(assetManager.getTexture(Assets.LOGO));
			logo.x = 300;
			addChildAt(logo, 1);

			var title:Image = new Image(assetManager.getTexture(Assets.LABEL_TITLE));
			title.x = logo.x + logo.width;
			title.y = logo.height / 2 - title.height / 2;
			addChildAt(title, 1);

		}
		
		/**
		 * Set's a new scene, sliding it in, and the sliding the old scene out.
		 * @param	scene
		 * @param	direction
		 */
		public function setScene(scene:DisplayObject, direction:int = SceneTransitionDirection.NONE):void {
			var newSceneTween:Tween = null;
			var currentSceneTween:Tween = null;
			
			switch(direction) {
				case SceneTransitionDirection.NONE :
					if (_currentScene != null && _currentScene.parent != null) {
						_currentScene.removeFromParent();
					}

					addChild(scene);
					scene.x = 0;
					scene.y = HEADER_HEIGHT;
					
					break;
				case SceneTransitionDirection.RIGHT :
					if (_currentScene != null && currentScene.parent != null) {
						currentSceneTween = new Tween(_currentScene, 0.5);
						currentSceneTween.moveTo( -stage.stageWidth, _currentScene.y);
						currentSceneTween.onComplete = cleanupTween;
						currentSceneTween.onCompleteArgs = [ currentSceneTween ];
						Starling.juggler.add(currentSceneTween);
					}
					
					addChild(scene);

					scene.x = stage.stageWidth;
					scene.y = HEADER_HEIGHT;
					trace(scene.width + "," + scene.height);
					newSceneTween = new Tween(scene, 0.5);
					newSceneTween.moveTo(0, HEADER_HEIGHT);
					Starling.juggler.add(newSceneTween);
					
					break;
				case SceneTransitionDirection.LEFT :
					if (_currentScene != null && currentScene.parent != null) {
						currentSceneTween = new Tween(_currentScene, 0.5);
						currentSceneTween.moveTo(stage.stageWidth * 1.5, _currentScene.y);
						currentSceneTween.onComplete = cleanupTween;
						currentSceneTween.onCompleteArgs = [ currentSceneTween ];
						Starling.juggler.add(currentSceneTween);
					}

					addChild(scene);
					scene.x = -stage.stageWidth;
					scene.y = HEADER_HEIGHT;					

					newSceneTween = new Tween(scene, 0.5);
					newSceneTween.moveTo( 0, HEADER_HEIGHT);
					Starling.juggler.add(newSceneTween);
					
					break;					
			}
				
			_currentScene = scene;
		}
		
		public function get currentScene():DisplayObject {
			return _currentScene;
		}
		
		private function cleanupTween(tween:Tween):void {			
			var object:DisplayObject = tween.target as DisplayObject;
			Starling.juggler.remove(tween);
			object.removeFromParent();
		}
	}
}