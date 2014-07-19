package com.smorawski.games.freshsweeper.model.vo {
	import com.smorawski.games.freshsweeper.model.constants.CellState;
	/**
	 * Value Object containt the state of a cell.
	 * @author Rick Smorawski
	 */
	public class CellVO {
		public var row				:int = 0;
		public var column			:int = 0;
		public var seedCount		:int = 0;
		public var neighborSeedCount:int = 0;
		public var state			:int = CellState.HIDDEN;
				
		public function CellVO(column:int = 0, row:int = 0, seedCount:int = 0, neighborSeedCount:int = 0 ) {
			this.row 				= row;
			this.column				= column;
			this.seedCount			= seedCount;
			this.neighborSeedCount	= neighborSeedCount;
		}
		
		public function toString():String {
			return "[CellVO @ " + column + "," + row + ". Seeds: " + seedCount + ", Neightbors:" + neighborSeedCount + "]";
		}
	}

}