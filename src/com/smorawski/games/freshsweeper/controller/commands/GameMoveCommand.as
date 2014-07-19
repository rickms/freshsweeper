package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.model.constants.GameNotification;
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.PositionVO;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Processes a player's move, showing the results.  
	 * Sends GameNotificaiton.GAME_LOST and GameNotification.GAME_WON if applicable
	 * 
	 * @author Rick Smorawski
	 */
	public class GameMoveCommand extends SimpleCommand {	
		override public function execute(notification:INotification):void {	
			var movePosition:PositionVO		= notification.getBody() as PositionVO;
			var gameProxy	:GameProxy		= facade.retrieveProxy(GameProxy.NAME) as GameProxy;

			gameProxy.showCell(movePosition.column, movePosition.row);

			var cell:CellVO = gameProxy.getCell(movePosition.column, movePosition.row);
		
			// If the selected cell has 1 or more seeds, the player has lost.
			if (cell.seedCount > 0) {
				sendNotification(GameNotification.GAME_LOST);
			}
			
			// If the player has revealed all non-seed cells, the player has won.
			if (gameProxy.gameWon) {
				sendNotification(GameNotification.GAME_WON);
			}
		}		
	}
}