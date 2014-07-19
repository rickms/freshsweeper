package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import com.smorawski.games.freshsweeper.model.constants.GameEvent;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.GameConfigVO;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	/**
	 * This view manages the game board
	 * 
	 * Dispatches: GameEvent.CELL_SELECTED
	 * 
	 * @author Rick Smorawski
	 */
	public class GameBoardView extends Sprite {
		/** Member Variables **/
		private var assetManager:AssetManager				= null;
		private var gameConfig	:GameConfigVO				= null;
		// Sub Components
		private var cells		:Vector.<Vector.<CellView>>	= new Vector.<Vector.<CellView>>();
		private var selectedCell:CellView					= null;
		
		/**
		 * Constructor
		 * 
		 * @param	assetManager
		 * @param	gameConfig
		 */
		public function GameBoardView(assetManager:AssetManager, gameConfig:GameConfigVO) {
			super();
			this.assetManager = assetManager;

			var bg:Scale9Image = new Scale9Image(new Scale9Textures(assetManager.getTexture(Assets.UI_GAME_FRAME), new Rectangle(17, 17, 9, 9)));
			bg.width	= gameConfig.columns * 28 + 40;
			bg.height	= gameConfig.rows * 28 + 40;
			addChild(bg);
			
			// Create all the individual cells
			for (var c:int = 0; c < gameConfig.columns; c++) {
				var columnCells:Vector.<CellView> = new Vector.<CellView>();
				cells.push(columnCells);
				for (var r:int = 0; r < gameConfig.rows; r++) {
					var cell:CellView = new CellView(assetManager, gameConfig, c, r);
					cell.addEventListener(TouchEvent.TOUCH, onCellTouched);
					cell.x = 17 + (c * 28);
					cell.y = 17 + (r * 28);
					addChild(cell);
					columnCells.push(cell);
				}
			}
		}
		
		/**
		 * Set the cell's backing CellVO.  This is called when the user clicks a cell
		 * @param	cell
		 */
		public function setCellInfo(cell:CellVO):void {
			var cellView:CellView = cells[cell.column][cell.row];
			cellView.cellInfo = cell;
			cellView.update();
		}
		
		/**
		 * Event handler to process cell touches, both click and hover.
		 * @param	event
		 */
		private function onCellTouched(event:TouchEvent):void {
			var cellView:CellView = event.currentTarget as CellView;
			var touch:Touch = event.getTouch(cellView, TouchPhase.ENDED);
			if (touch != null) {	
				dispatchEventWith(GameEvent.SELECTED_CELL, true, cellView);
			}
			
			touch = event.getTouch(cellView, TouchPhase.HOVER);
			if (touch != null) {
				cellView.selected = true;
				selectedCell = cellView;
			} else {
				cellView.selected = false;
				selectedCell = null;
			}
		}
		
		/**
		 * Mark the selected cell (will cycle between marks/no marks
		 */
		public function markSelected():void {
			if (selectedCell != null) {
				selectedCell.mark();
			}
		}
	}
}