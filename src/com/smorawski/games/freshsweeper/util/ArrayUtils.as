package com.smorawski.games.freshsweeper.util {
	/**
	 * ...
	 * @author Rick Smorawski
	 */
	public class ArrayUtils {
		/**
		 * Fisher-Yates shuffle
		 * @param	array
		 * @return
		 */
		public static function shuffle(array:Array):Array {
			var i:int = 0;
			var j:int = array.length;
			
			while (j > 0) {
				i = Math.floor(Math.random() * j--);
				var t:* = array[j];
				array[j] = array[i];
				array[i] = t;
			}
			
			return array;
		}
	}

}