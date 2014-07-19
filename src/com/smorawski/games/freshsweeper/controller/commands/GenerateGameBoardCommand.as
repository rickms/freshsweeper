package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.GameConfigVO;
	import com.smorawski.games.freshsweeper.model.vo.PositionVO;
	import com.smorawski.games.freshsweeper.util.ArrayUtils;
	import com.smorawski.games.freshsweeper.util.RandomInt;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Generates the game board, populates the seeds, and sums up neighbor seed counts
	 * 
	 * Game board is 0 indexed from Top Left to bottom right
	 * 
	 * @author Rick Smorawski
	 */
	public class GenerateGameBoardCommand extends SimpleCommand {	
		override public function execute(notification:INotification):void {
			var cell			:CellVO	= null;
			var column			:int 			= 0;
			var row				:int			= 0;
			var eligibleCells	:Array 			= new Array();	// List of cells that are eligible to contain seeds			
			
			// References
			var firstMove	:PositionVO		= notification.getBody() as PositionVO;
			var gameProxy	:GameProxy 		= facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			var gameConfig	:GameConfigVO	= gameProxy.gameConfig;
			
			var boardCells:Vector.<Vector.<CellVO>> = new Vector.<Vector.<CellVO>>(); // used for (column,row) lookup			
			
			// Create a CellVO for each cell, storing them in the boardCells vector
			for (column = 0; column < gameConfig.columns; column++) {
				var columnVector:Vector.<CellVO> = new Vector.<CellVO>();
				boardCells.push(columnVector);
				for (row = 0; row < gameConfig.rows; row++) {
					cell = new CellVO(column, row, 0, 0);
					boardCells[column].push(cell);
					
					// For a better game play experience, exclude the first move location and all surrounding cells as seed location candidates.
					if(firstMove != null) {
						if(!((column >= firstMove.column - 1 && column <= firstMove.column + 1) && (row >= firstMove.row - 1 && row <= firstMove.row + 1))) {
							eligibleCells.push(cell);
						} 
					}
				}
			}
			
			// Shuffle the array and start assign seeds
			var shuffledCells:Array = ArrayUtils.shuffle(eligibleCells);			
			var seedsRemaining:int = gameConfig.seeds;
			var i:int = 0;
			
			// Loop while we still have seeds to distribute
			while (seedsRemaining > 0) {				
				var seedsInCell:int = RandomInt(1, Math.min(seedsRemaining, gameConfig.maxSeedsPerCell)); // Select the number of seeds for this cell.
				cell = shuffledCells[i++];
				cell.seedCount = seedsInCell;
				seedsRemaining -= seedsInCell;
			}
			gameProxy.tilesWithSeeds = i;
			
			// Loop through the board and assign neighbor counts
			for (column = 0; column < gameConfig.columns; column++) {
				for (row = 0; row < gameConfig.rows; row++) {
					cell = boardCells[column][row];
					// North Neighbor
					if (row > 0) {
						cell.neighborSeedCount += boardCells[column][row - 1].seedCount;
					}
					// North East Neighbor
					if (row > 0 && (column + 1 < gameConfig.columns)) {
						cell.neighborSeedCount += boardCells[column + 1][row - 1].seedCount;
					}
					// East Neighbor
					if (column + 1 < gameConfig.columns) {
						cell.neighborSeedCount += boardCells[column + 1][row].seedCount;
					}
					// South East Neighbor
					if ( (row + 1 < gameConfig.rows) && (column + 1 < gameConfig.columns)) {
						cell.neighborSeedCount += boardCells[column + 1][row + 1].seedCount;
					}
					// South Neighbor
					if (row + 1 < gameConfig.rows) {
						cell.neighborSeedCount += boardCells[column][row + 1].seedCount;
					}				
					// South West Neighbor
					if ( (row + 1 < gameConfig.rows) && column > 0) {
						cell.neighborSeedCount += boardCells[column - 1][row + 1].seedCount;
					}
					// West Neighbor
					if (column > 0) {
						cell.neighborSeedCount += boardCells[column - 1][row].seedCount;
					}
					// North West Neighbor 
					if (column > 0 && row > 0) {
						cell.neighborSeedCount += boardCells[column - 1][row - 1].seedCount;
					}
				}
			}
			
			gameProxy.boardCells = boardCells;
		}		
	}
}