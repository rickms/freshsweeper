package com.smorawski.games.freshsweeper.view.mediators {
	import com.smorawski.games.freshsweeper.model.constants.MainMenuEvent;
	import com.smorawski.games.freshsweeper.view.components.MainMenuView;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Rick Smorawski
	 */
	public class MainMenuMediator extends Mediator {
		/** Class Constants **/
		public static const NAME :String = "MainMenuMediator";		
		// Notifications
		public static const SELECTED_MODE:String = NAME	+ "SelectedMode";
		public static const SELECTED_HELP:String = NAME + "SelectedHelp";
		
		public function MainMenuMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			mainMenuView.addEventListener(MainMenuEvent.SELECTED_MODE, onDidSelectMode);
			mainMenuView.addEventListener(MainMenuEvent.SELECTED_HELP, onDidSelectHelp);
		}
		
		/**
		 * Convenience  Function
		 */
		[Inline]
		public final function get mainMenuView():MainMenuView {
			return viewComponent as MainMenuView;
		}
		
		/**
		 * MainMenuEvent.SELECTED_MODE handler
		 * @param	event
		 */
		private function onDidSelectMode(event:Event):void {
			sendNotification(SELECTED_MODE, event.data);
		}
		
		/**
		 * MainMenyEvent.SELECTED_HELP handler
		 * @param	event
		 */
		private function onDidSelectHelp(event:Event):void {
			sendNotification(SELECTED_HELP);
		}		
	}

}