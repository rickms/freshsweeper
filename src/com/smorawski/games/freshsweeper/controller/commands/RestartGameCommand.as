package com.smorawski.games.freshsweeper.controller.commands {
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	/**
	 * This command is issued when currently on the game screen, and the player has chosen
	 * to restart the game
	 * 
	 * @author Rick Smorawski
	 */
	public class RestartGameCommand extends MacroCommand {		
		public function RestartGameCommand() {
			super();
			addSubCommand(InitGameCommand);
			addSubCommand(ResetGameBoardCommand);
		}
	}
}