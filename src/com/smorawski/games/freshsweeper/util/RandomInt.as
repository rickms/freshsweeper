package com.smorawski.games.freshsweeper.util {	
	public function RandomInt (min:int, max:int):int {
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

}