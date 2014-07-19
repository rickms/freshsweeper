package com.smorawski.games.freshsweeper.controller.commands {
	import com.smorawski.games.freshsweeper.model.proxy.AssetProxy;
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.view.components.RootView;
	import com.smorawski.games.freshsweeper.view.mediators.ApplicationMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Initial startup command, getting PureMVC framework in order
	 * 
	 * @author Rick Smorawski
	 */
	public class StartupCommand extends SimpleCommand{		
		override public function execute(note:INotification):void {
			// Register Proxies
			var assetProxy:AssetProxy = new AssetProxy("");
			facade.registerProxy(assetProxy);
			facade.registerProxy(new GameProxy());
			
			// Register Mediators
			facade.registerMediator(new ApplicationMediator(note.getBody() as RootView,assetProxy.assetManager));
			assetProxy.load();
		}
	}

}