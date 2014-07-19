package com.smorawski.games.freshsweeper.controller.commands {
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	/**
	 * Macro command to process the game's first move.  
	 * 
	 * The seed distribution is not generated until AFTER the player's first move.  The guarantees that 
	 * the player's first move, nor its surrounding cells will be a seed.  Once this move is complete,
	 * we switch the move handling logic to GameMoveCommand for future moves.
	 * 
	 * @author Rick Smorawski
	 */
	public class GameFirstMoveCommand extends MacroCommand {
		
		public function GameFirstMoveCommand() {
			addSubCommand(SwitchMoveHandlerCommand); // Switch the move handler from GameFistMoveCommand to GameMoveCommand
			addSubCommand(GenerateGameBoardCommand); // Generate the game board
			addSubCommand(GameMoveCommand);			 // Process the first game move
		}
	}
}