package com.smorawski.games.freshsweeper.view.mediators {
	import com.smorawski.games.freshsweeper.model.constants.SceneTransitionDirection;
	import com.smorawski.games.freshsweeper.model.proxy.AssetProxy;
	import com.smorawski.games.freshsweeper.model.proxy.GameProxy;
	import com.smorawski.games.freshsweeper.view.components.GameView;
	import com.smorawski.games.freshsweeper.view.components.HelpView;
	import com.smorawski.games.freshsweeper.view.components.MainMenuView;
	import com.smorawski.games.freshsweeper.view.components.RootView;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import starling.utils.AssetManager;
	
	/**
	 * Mediator for the entire application.  Handles switching between main menu/help/game 
	 * 
	 * @author Rick Smorawski
	 */
	public class ApplicationMediator extends Mediator{
		/** Class Constants **/
		public static const NAME:String = "ApplicationMediator";
	
		/** Member Variables **/
		private var assetManager	:AssetManager	= null;	// The AssetManager instance that contains the assets

		public function ApplicationMediator(viewComponent:Object, assetManager:AssetManager){
			super(NAME, viewComponent);
			this.assetManager = assetManager;
		}
		
		[Inline]
		public final function get starlingRoot():RootView{
			return viewComponent as RootView;
		}
		
		/**
		 * Return the notifications this mediator cares about
		 * @return
		 */
		override public function listNotificationInterests():Array {
			return [
					AssetProxy.LOAD_COMPLETE
					];
		}
		
		/**
		 * Handle the notifications returned from listNotificationInterests()
		 * 
		 * @param	notification
		 */
		override public function handleNotification(notification:INotification):void {			
			switch(notification.getName()) {
				case AssetProxy.LOAD_COMPLETE:
					starlingRoot.init(assetManager);
					break;
			}
		}
		
		/**
		 * Show the game play view, creating a new view/mediator for each game.  
		 * This ensures we have a nice "clean" start to each game.
		 */
		public function showGameView():void {
			if (facade.hasMediator(GameMediator.NAME)) {
				facade.removeMediator(GameMediator.NAME);
			}
			var assetProxy	:AssetProxy	= facade.retrieveProxy(AssetProxy.NAME) as AssetProxy;
			var gameProxy	:GameProxy	= facade.retrieveProxy(GameProxy.NAME)	as GameProxy;			
			
			var view:GameView = new GameView(assetProxy.assetManager,gameProxy.gameConfig);
			
			facade.registerMediator(new GameMediator(view));

			starlingRoot.setScene(view,SceneTransitionDirection.RIGHT);
		}
		
		/**
		 * Show the main menu.  This works differently from showGameView, as it will only 
		 * create the view and mediator once, and just re-use it.
		 * 
		 * @param source The source mediator that triggered this transition
		 */
		public function showMainMenuView(source:String):void {
			var view		:MainMenuView 	= null;
			var assetProxy	:AssetProxy		= facade.retrieveProxy(AssetProxy.NAME) as AssetProxy;

			if (!facade.hasMediator(MainMenuMediator.NAME)) {
				view = new MainMenuView(assetProxy.assetManager);
				facade.registerMediator(new MainMenuMediator(view));
			} else {
				var mainMenuMediator:MainMenuMediator = facade.retrieveMediator(MainMenuMediator.NAME) as MainMenuMediator;
				view = mainMenuMediator.mainMenuView;
			}
			
			var sceneTransitionDirection:int = SceneTransitionDirection.NONE;
			if (source == GameMediator.NAME) {
				sceneTransitionDirection = SceneTransitionDirection.LEFT;
			} else if (source == HelpMediator.NAME) {
				sceneTransitionDirection = SceneTransitionDirection.RIGHT;
			}
			starlingRoot.setScene(view, sceneTransitionDirection);
		}
		
		/**
		 * Show the help.  This works differently from showGameView, as it will only 
		 * create the view and mediator once, and just re-use it.
		 */
		public function showHelpView():void {
			var view		:HelpView 	= null;
			var assetProxy	:AssetProxy		= facade.retrieveProxy(AssetProxy.NAME) as AssetProxy;

			if (!facade.hasMediator(HelpMediator.NAME)) {
				view = new HelpView(assetProxy.assetManager);
				facade.registerMediator(new HelpMediator(view));
			} else {
				var helpMediator:HelpMediator = facade.retrieveMediator(HelpMediator.NAME) as HelpMediator;
				view = helpMediator.helpView;
			}
			starlingRoot.setScene(view, SceneTransitionDirection.LEFT);
		}		
	}
}