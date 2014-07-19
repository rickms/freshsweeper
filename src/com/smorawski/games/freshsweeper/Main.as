package com.smorawski.games.freshsweeper {
	import com.smorawski.games.freshsweeper.view.components.RootView;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * Main entry class
	 * @author Rick Smorawski
	 */
	public class Main extends Sprite {
		private var _starling:Starling = null;
		public function Main():void {
			if (stage) init();
			else addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:flash.events.Event = null):void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			_starling = new Starling(RootView, stage);
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingRootCreated);
			_starling.start();
		}
		
		private function onStarlingRootCreated(event:starling.events.Event):void {
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onStarlingRootCreated);
			ApplicationFacade.getInstance(ApplicationFacade.NAME).startup(_starling.root as RootView);
		}
		
	}
	
}