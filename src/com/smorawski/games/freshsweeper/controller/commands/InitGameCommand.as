package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.view.mediators.GameMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Initialize a new game.  Resets the move handler to GameFirstMoveCommand and resets the proxy.
	 * 
	 * @author Rick Smorawski
	 */
	public class InitGameCommand extends SimpleCommand {
		override public function execute(notification:INotification):void {
			facade.removeCommand(GameMediator.CELL_SELECTED);
			facade.registerCommand(GameMediator.CELL_SELECTED, GameFirstMoveCommand);	
			
			(facade.retrieveProxy(GameProxy.NAME) as GameProxy).reset();
		}
	}
}