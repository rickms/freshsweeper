package com.smorawski.games.freshsweeper.model.proxy {
	import com.smorawski.games.freshsweeper.model.constants.Assets;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import starling.utils.AssetManager;
	
	/**
	 * Proxy for loading assets via the starling AssetManager class.
	 * 
	 * @author Rick Smorawski
	 */
	public class AssetProxy extends Proxy {
		// Class Constants
		public static const NAME:String = "AssetProxy";
		// Notifiations
		public static const LOAD_PROGRESS	:String	= NAME + "LoadProgress";
		public static const LOAD_COMPLETE	:String = NAME + "LoadComplete";
		// Member Vars
		private var loadComplete	:Boolean		= false;
		private var assetPath		:String 		= "";
		
		public function AssetProxy(assetPath:String = "") {
			super(NAME, new AssetManager());		
			this.assetPath = assetPath;
		}
		
		/**
		 * Enqueue assets once this proxy is registerd.
		 */
		override public function onRegister():void {		
			assetManager.enqueue(absolutePath(Assets.BACKGROUND_FILE));
			assetManager.enqueue(absolutePath(Assets.SPRITESHEET1_TEXTURE));
			assetManager.enqueue(absolutePath(Assets.SPRITESHEET1_DATA));
			assetManager.enqueue(absolutePath(Assets.FONT_NUMBERS1_DATA));
			assetManager.enqueue(absolutePath(Assets.FONT_GENERAL_DATA));			
		}
		
		/**
		 * resolves a relative path to and absolute path.
		 * 
		 * @param	relativePath
		 * @return
		 */
		private function absolutePath(relativePath:String):String {
			return assetPath == "" ? relativePath : assetPath + '/' + relativePath;
		}
		
		/**
		 * Load enqueued assets
		 */
		public function load():void {
			assetManager.loadQueue(onAssetLoadProgress);
		}
		
		/**
		 * Are the assets loaded?
		 */
		public function get isLoadComplete():Boolean {
			return loadComplete;
		}
		
		/**
		 * Send LOAD_PROGRESS/LOAD_COMPLETE events, useful if using a preloader screen.
		 * @param	progress
		 */
		private function onAssetLoadProgress(progress:Number):void {
			sendNotification(LOAD_PROGRESS, progress);
			if (progress == 1.0) {
				loadComplete = true;
				sendNotification(LOAD_COMPLETE);
			}
		}
		
		[Inline]
		public final function get assetManager():AssetManager {
			return getData() as AssetManager;
		}
		
	}

}