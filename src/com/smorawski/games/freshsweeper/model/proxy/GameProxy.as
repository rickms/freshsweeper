package com.smorawski.games.freshsweeper.model.proxy {
	import com.smorawski.games.freshsweeper.model.constants.CellState;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.GameConfigVO;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * Proxy to keep all the game bits in order.
	 * 
	 * @author Rick Smorawski
	 */
	public class GameProxy extends Proxy {
		/** Class Constants **/	
		public static const NAME:String	= "GameProxy";		
		/** Notifications **/
		public static const CELL_STATE_CHANGED:String	= NAME + "CellStateChanged";
		
		/** Member Variables **/
		private var _gameConfig		:GameConfigVO					= null;
		private var _cells		:Vector.<Vector.<CellVO>>	= null;
		private var _shownCount		:int							= 0;			// Number of tiles revealed, used in winning condition.																		
		private var _tilesWithSeeds	:int							= 0;			// Count of the number of tiles that contain 1 or more seeds, 
																					// set by GenerateGameBoardCommand,  used in winning condition

		/**
		 * Constructor
		 */
		public function GameProxy() {
			super(NAME, null);
		}
		
		/**
		 * Returns a specific Cell
		 * 
		 * @param	column
		 * @param	row
		 * @return  BoardCellVO
		 */
		public function getCell(column:int, row:int):CellVO {
			return _cells[column][row];
		}
		
		/**
		 * Reset the game.  We intentionally don't reset game config here.
		 * If the game config needs updating, it will be done via the main menu
		 * sending a SetGameModeCommand (via StartGameCommand)
		 */
		public function reset():void {
			_cells = null;
			_tilesWithSeeds = 0;
			_shownCount = 0;
		}

		
		/**
		 * Returns true if the game is won.
		 * Win Condition: If all cells, except the ones with seeds have been revealed, then the game is won.
		 */
		public function get gameWon():Boolean {
			return ((gameConfig.columns * gameConfig.rows) - _tilesWithSeeds) == _shownCount;
		}
		
		/**
		 * Recursive function that reveals one more more cells.  If none of the neighboring cells have
		 * seeds, then we reveal not only the cell at (column,row) but all of it's neighbors as well,
		 * recursively, until we get to cells that have neighboring seeds.
		 * @param	column
		 * @param	row
		 */
		public function showCell(column:int, row:int):void {
			var cell:CellVO = _cells[column][row];
			if (cell.state == CellState.HIDDEN) {
				// Set the state to shown.
				cell.state = CellState.SHOWN;

				// Increment shown count
				_shownCount++; 
	
				// Send notification so view's can update
				sendNotification(CELL_STATE_CHANGED, cell);
				
				// If empty cell and no neighbors, reveal neighbor cells
				if (cell.seedCount == 0 && cell.neighborSeedCount == 0) {
					if (cell.row > 0) {	
						showCell(column, row -1); 
					}
					if (cell.row > 0 && cell.column + 1 < gameConfig.columns) { 
						showCell(column + 1, row - 1);
					}
					if (cell.column + 1 < gameConfig.columns) {
						showCell(column + 1, row);
					}				
					if (cell.row + 1 < gameConfig.rows && cell.column + 1 < gameConfig.columns) {
						showCell(column + 1, row + 1);
					}
					if (cell.row + 1 < gameConfig.rows) {
						showCell(column, row + 1);
					}
					if ( cell.row + 1 < gameConfig.rows && cell.column > 0) {
						showCell(column - 1, row + 1);
					}
					if (cell.column > 0) {
						showCell(column - 1, row);
					}
					if (cell.row > 0 && cell.column > 0) {
						showCell(column - 1, row - 1);
					}
				}
			}
		}
		
		/**
		 * Standard Setters/Getters
		 */
		public function get gameConfig():GameConfigVO {
			return _gameConfig;
		}

		public function set gameConfig(gameConfig:GameConfigVO):void {
			_gameConfig = gameConfig;
		}
		
		public function get boardCells():Vector.<Vector.<CellVO>> {
			return boardCells;
		}
		
		public function set boardCells(cells:Vector.<Vector.<CellVO>>):void {
			_cells = cells;
		}
		
		public function get tilesWithSeed():int {
			return _tilesWithSeeds;
		}
		
		public function set tilesWithSeeds(value:int):void {
			_tilesWithSeeds = value;
		}
	}
}