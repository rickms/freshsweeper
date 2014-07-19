package com.smorawski.games.freshsweeper.view.mediators {
	import com.smorawski.games.freshsweeper.model.constants.HelpEvent;
	import com.smorawski.games.freshsweeper.view.components.HelpView;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import starling.events.Event;
	
	/**
	 * Mediate the help view
	 * @author Rick Smorawski
	 */
	public class HelpMediator extends Mediator {		
		/** Class Constants **/
		public static const NAME:String = "HelpMediator";		
		// Notifications
		public static const SELECTED_QUIT:String = NAME	+ "SelectedQuit";

		public function HelpMediator(viewComponent:HelpView) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			helpView.addEventListener(HelpEvent.SELECTED_QUIT, onDidSelectQuit);
		}
		
		/**
		 * Convenience  Function
		 */
		[Inline]
		public final function get helpView():HelpView {
			return viewComponent as HelpView;
		}
		
		/**
		 * HelpEvent.SELECTED_QUIT handler
		 * @param	event
		 */
		private function onDidSelectQuit(event:Event):void {
			sendNotification(SELECTED_QUIT, NAME);
		}
		
	}

}