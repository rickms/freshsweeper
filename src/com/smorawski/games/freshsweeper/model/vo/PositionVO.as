package com.smorawski.games.freshsweeper.model.vo {
	/**
	 * Value Object that represents a position.
	 * @author Rick Smorawski
	 */
	public class PositionVO {
		public var column:int = 0;
		public var row:int = 0;
		
		public function PositionVO(column:int, row:int) {
			this.column = column;
			this.row	= row;
		}
	}
}