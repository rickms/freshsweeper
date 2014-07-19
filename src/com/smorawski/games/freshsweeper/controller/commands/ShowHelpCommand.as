package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.view.mediators.ApplicationMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Show the game's help.
	 * @author Rick Smorawski
	 */
	public class ShowHelpCommand extends SimpleCommand {
		override public function execute(notification:INotification):void {
			var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;			
			appMediator.showHelpView();
		}
		
	}

}