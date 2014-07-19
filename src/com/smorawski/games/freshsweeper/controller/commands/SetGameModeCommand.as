package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.model.constants.GameModeType;
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.model.vo.GameConfigVO;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	/**
	 * This command sets the game config based on the GameModeType sent.
	 * 
	 * @author Rick Smorawski
	 */
	public class SetGameModeCommand extends SimpleCommand{
		override public function execute(notification:INotification):void {
			var gameMode	:int		= notification.getBody() as int;
			var gameProxy	:GameProxy	= facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			
			switch(gameMode) {
				case GameModeType.EASY: 
					gameProxy.gameConfig = new GameConfigVO(9, 9, 10, 1);
					break;
				case GameModeType.MEDIUM:
					gameProxy.gameConfig = new GameConfigVO(16, 16, 40, 1);
					break;
				case GameModeType.HARD:
					gameProxy.gameConfig = new GameConfigVO(30, 16, 99, 1);
					break;
				case GameModeType.CHALLENGE:
					gameProxy.gameConfig = new GameConfigVO(30, 16, 150, 3);
					break;
			}
		}
	}
}