package com.smorawski.games.freshsweeper.view.mediators {
	import com.smorawski.games.freshsweeper.model.constants.GameEvent;
	import com.smorawski.games.freshsweeper.model.constants.GameNotification;
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.PositionVO;
	import com.smorawski.games.freshsweeper.view.components.CellView;
	import com.smorawski.games.freshsweeper.view.components.GameView;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import starling.events.Event;
	
	/**
	 * Mediator for the game play view
	 * 
	 * @author Rick Smorawski
	 */
	public class GameMediator extends Mediator {
		/** Class Constants **/
		public static const NAME:String = "GameMediator";
		// Notifications
		public static const CELL_SELECTED:String = NAME + "CellSelected";
		
		public function GameMediator(viewComponent:GameView) {
			super(NAME, viewComponent);	
			
			viewComponent.addEventListener(GameEvent.RESTART, onRestartSelected);
			viewComponent.addEventListener(GameEvent.QUIT, onQuitSelected);
		}
		
		/**
		 * Convenience  Function
		 */
		[Inline]
		public final function get gameView():GameView {
			return viewComponent as GameView;
		}
		
		/**
		 * Return the notifications this mediator cares about
		 * @return
		 */	
		override public function listNotificationInterests():Array {
			return [
					GameProxy.CELL_STATE_CHANGED,
					GameNotification.GAME_WON,
					GameNotification.GAME_LOST
					];
		}
		
		/**
		 * Handle the notifications returned from listNotificationInterests()
		 * 
		 * @param	notification
		 */	
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()) {
				case GameProxy.CELL_STATE_CHANGED:
					var cell:CellVO = notification.getBody() as CellVO;
					gameView.setCellInfo(cell);
					break;
				case GameNotification.GAME_WON:
					gameView.showGameWon();
					break;
				case GameNotification.GAME_LOST:
					gameView.showGameLost();
					break;
			}
		}
		
		override public function onRegister():void {
			gameView.addEventListener(GameEvent.SELECTED_CELL, onCellSelected);
		}
		
		/**
		 * Restart the current running game.
		 */
		public function restartGame():void {
			gameView.init();
		}
		
		/**
		 * GameEvent.SELECTED_CELL handler 
		 * @param	event
		 */
		private function onCellSelected(event:Event):void {
			var cellView:CellView = event.data as CellView;
			sendNotification(CELL_SELECTED, new PositionVO(cellView.column, cellView.row));
		}
		
		/**
		 * GameEvent.RESTART handler
		 * @param	event
		 */
		private function onRestartSelected(event:Event = null):void {
			sendNotification(GameNotification.GAME_RESTART);
		}
		
		/**
		 * GameEvent.QUIT handler
		 *
		 * @param	event
		 */
		private function onQuitSelected(event:Event = null):void {
			sendNotification(GameNotification.GAME_QUIT,NAME);
		}
	}
}