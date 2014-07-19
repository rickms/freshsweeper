package com.smorawski.games.freshsweeper.controller.commands {
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	/**
	 * Start a new game (from main menu)
	 * 
	 * @author Rick Smorawski
	 */
	public class StartGameCommand extends MacroCommand {
		
		public function StartGameCommand() {
			super();
			addSubCommand(InitGameCommand);
			addSubCommand(SetGameModeCommand);
			addSubCommand(ShowGameBoardCommand);
		}
	}
}