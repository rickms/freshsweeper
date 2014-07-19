package com.smorawski.games.freshsweeper {
	import com.smorawski.games.freshsweeper.controller.commands.RestartGameCommand;
	import com.smorawski.games.freshsweeper.controller.commands.ShowHelpCommand;
	import com.smorawski.games.freshsweeper.controller.commands.ShowMainMenuCommand;
	import com.smorawski.games.freshsweeper.controller.commands.StartGameCommand;
	import com.smorawski.games.freshsweeper.controller.commands.StartupCommand;
	import com.smorawski.games.freshsweeper.model.constants.AppNotification;
	import com.smorawski.games.freshsweeper.model.constants.GameNotification;
	import com.smorawski.games.freshsweeper.model.proxy.AssetProxy;
	import com.smorawski.games.freshsweeper.view.components.RootView;
	import com.smorawski.games.freshsweeper.view.mediators.HelpMediator;
	import com.smorawski.games.freshsweeper.view.mediators.MainMenuMediator;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author Rick Smorawski
	 */
	public class ApplicationFacade extends Facade {
		public static const NAME		:String = "PlanetSweeper";
		
		public function ApplicationFacade(key:String){
			super(key);
		}
		
		public static function getInstance(key:String):ApplicationFacade{
			if (instanceMap[key] == null) {
				instanceMap[key] = new ApplicationFacade(key);
			}
			return instanceMap[key];
		}
		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(AppNotification.STARTUP, StartupCommand);
			registerCommand(AssetProxy.LOAD_COMPLETE, ShowMainMenuCommand);
			registerCommand(MainMenuMediator.SELECTED_MODE, StartGameCommand);	
			registerCommand(MainMenuMediator.SELECTED_HELP, ShowHelpCommand);
			registerCommand(HelpMediator.SELECTED_QUIT, ShowMainMenuCommand);
			registerCommand(GameNotification.GAME_RESTART, RestartGameCommand);
			registerCommand(GameNotification.GAME_QUIT, ShowMainMenuCommand);
		}
		
		public function startup(rootView:RootView):void{
			sendNotification(AppNotification.STARTUP, rootView);
		}
	}
}