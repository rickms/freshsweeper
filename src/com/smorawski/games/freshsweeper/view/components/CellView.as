package com.smorawski.games.freshsweeper.view.components {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import com.smorawski.games.freshsweeper.model.constants.CellState;
	import com.smorawski.games.freshsweeper.model.vo.CellVO;
	import com.smorawski.games.freshsweeper.model.vo.GameConfigVO;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	
	/**
	 * The view that represents and individual game cell
	 * 
	 * @author Rick Smorawski
	 */
	public class CellView extends Sprite {
		/** Member variables **/
		private var assetManager:AssetManager 	= null;
		private var _column		:int			= 0;
		private var _row		:int			= 0;
		private var state		:int			= CellState.HIDDEN;
		private var markCount	:int 			= 0;		
		private var _cellInfo	:CellVO			= null;
		private var gameConfig	:GameConfigVO	= null;
		// Sub Component
		private var bgImage		:Image			= null;
		private var iconObject	:DisplayObject	= null;	// See note in update()

		/**
		 * Constructor
		 * 
		 * @param	assetManager
		 * @param	gameConfig
		 * @param	column
		 * @param	row
		 */
		public function CellView(assetManager:AssetManager, gameConfig:GameConfigVO, column:int, row:int) {
			super();
			this.assetManager	= assetManager;
			this._column		= column;
			this._row			= row;
			this.gameConfig		= gameConfig;
			
			this.useHandCursor	= true;
			
			bgImage = new Image(assetManager.getTexture(Assets.BG_BLOCK_RED));
			addChild(bgImage);						
		}
		
		/**
		 * Sets the cell info, and shows the cell
		 */
		public function set cellInfo(cellInfo:CellVO):void {
			_cellInfo = cellInfo;
			state = CellState.SHOWN;
		}
		
		/**
		 * Update's the cell graphics based on the 
		 * state and cellInfo
		 */
		public function update():void {
			var iconImage:Image = null;
			
			// If there is an "iconObject" (this is either a number reflecting the number of neighboring 
			// seed, a use seed "mark" or the reveald seeds.
			//
			// Remove it if it exists.
			if (iconObject != null) {
				removeChild(iconObject);
			}
			
			if (state == CellState.HIDDEN) {
				// Show the hidden bg
				bgImage.texture = assetManager.getTexture(Assets.BG_BLOCK_RED);
				
				// If the player has marked this tile, then show the appropriate icon
				if (markCount > 0) {
					switch(markCount) {
						case 1: iconImage = new Image(assetManager.getTexture(Assets.ICON_SEED)); break;
						case 2: iconImage = new Image(assetManager.getTexture(Assets.ICON_SEED_2)); break;
						case 3: iconImage = new Image(assetManager.getTexture(Assets.ICON_SEED_3)); break;						
					}			
					iconImage.alignPivot();
					iconImage.x = bgImage.width / 2 - 1;
					iconImage.y = bgImage.height / 2 - 1;
					addChild(iconImage);
					
					iconObject = iconImage;
				}
			} else if(state == CellState.SHOWN) {
				bgImage.texture = assetManager.getTexture(Assets.BG_BLOCK_GREY);
				
				// If this cell contains seeds, show the appropriate icon
				if (_cellInfo.seedCount > 0) {
					switch(_cellInfo.seedCount) {
						case 1: iconImage = new Image(assetManager.getTexture(Assets.ICON_SEED)); break;
						case 2: iconImage = new Image(assetManager.getTexture(Assets.ICON_SEED_2)); break;
						case 3: iconImage = new Image(assetManager.getTexture(Assets.ICON_SEED_3)); break;						
					}
					iconImage.alignPivot();
					iconImage.x = bgImage.width / 2;
					iconImage.y = bgImage.height / 2;
					addChild(iconImage);
					
					iconObject = iconImage;
				} else if (_cellInfo.neighborSeedCount > 0) {
					// This cell has neighboring cells with seeds, show the count.
					var iconField:TextField = new TextField(28, 28, _cellInfo.neighborSeedCount.toString(), Assets.FONT_NUMBERS1, _cellInfo.neighborSeedCount > 9 ? 13 : 18, Color.WHITE);
					iconField.batchable = true;
					addChild(iconField);
					iconObject = iconField;
				}				
			}
		}
		
		/**
		 * Player has marked this cell as having seeds, each call to this function will cycle
		 * through marks from 0 to the maxSeedsPerCell in this GameModeType
		 */
		public function mark():void {
			markCount = markCount == gameConfig.maxSeedsPerCell ? 0 : markCount + 1;
			update();
		}
		
		/**
		 * Show a mouse-over effect 
		 */
		public function set selected(value:Boolean):void {
			if (state == CellState.HIDDEN && value) {
				bgImage.texture = assetManager.getTexture(Assets.BG_BLOCK_RED_HOVER);
			} else if (state == CellState.HIDDEN && !value) {
				bgImage.texture = assetManager.getTexture(Assets.BG_BLOCK_RED);
			}
		}
		
		/**
		 * Standard Getters/Setters
		 */
		public function get column():int {
			return _column;
		}
		
		public function set column(value:int):void {
			_column = value;
		}
		
		public function get row():int {
			return _row;
		}
		
		public function set row(value:int):void {
			_row = value;
		}
	}
}