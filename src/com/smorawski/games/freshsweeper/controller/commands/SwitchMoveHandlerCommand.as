package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.view.mediators.GameMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Switches the game move handler after the first move
	 * @author Rick Smorawski
	 */
	public class SwitchMoveHandlerCommand extends SimpleCommand {		
		override public function execute(notification:INotification):void {
			facade.removeCommand(GameMediator.CELL_SELECTED);
			facade.registerCommand(GameMediator.CELL_SELECTED, GameMoveCommand);			
		}		
	}
}