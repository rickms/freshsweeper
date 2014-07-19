package com.smorawski.games.freshsweeper.model.vo {
	/**
	 * Value Object that contains the current game's setup
	 * @author Rick Smorawski
	 */
	public class GameConfigVO {
		public var columns			:int = 0;
		public var rows				:int = 0;
		public var seeds			:int = 0;	
		public var maxSeedsPerCell	:int = 1;

		public function GameConfigVO(columns:int = 0, rows:int = 0, seeds:int = 0, maxSeedsPerCell:int = 1) {
			this.columns 			= columns;
			this.rows				= rows;
			this.seeds				= seeds;
			this.maxSeedsPerCell	= maxSeedsPerCell;
		}
	}
}