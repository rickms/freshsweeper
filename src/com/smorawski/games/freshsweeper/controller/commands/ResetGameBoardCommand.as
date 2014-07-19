package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.view.mediators.GameMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	/**
	 * Reset's the game board view.
	 * 
	 * @author Rick Smorawski
	 */
	public class ResetGameBoardCommand extends SimpleCommand{
		
		override public function execute(notification:INotification):void {

			var gameMediator:GameMediator = facade.retrieveMediator(GameMediator.NAME) as GameMediator;
			gameMediator.restartGame();
		}
		
	}

}