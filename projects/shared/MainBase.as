package projects.shared
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import projects.shared.facebook.FacebookDataBase;
	import projects.shared.main_menu.events.MainMenuEvent;
	import projects.shared.main_menu.MainMenuBase;
	import projects.shared.screens.ScreensBase;
	import projects.shared.utils.display.StageMonitor;
	import projects.thinkle_cake_drag.screens.enum.ScreenType;
	/**
	 * Base Main Logic class
	 * 
	 * @author trayko
	 */
	public class MainBase extends Sprite
	{
		protected var _facebook			:FacebookDataBase;
		protected var _screens			:ScreensBase;
		protected var _main_menu		:MainMenuBase;
		protected var _stage_monitor	:StageMonitor;
		
		public function MainBase() : void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			initialize();
		}
		
		public function initialize():void 
		{
			initializeScreens();
			initializeMainMenu();
		}
		
		protected function initializeFacebook():void 
		{
			_facebook = createFacebookData();
		}
		
		protected function createFacebookData() : FacebookDataBase 
		{
			return new FacebookDataBase();
		}
		
		protected function initializeScreens() : void
		{
			_screens = createScreens();
			addChild(_screens);
		}		
		
		protected function createScreens() : ScreensBase
		{
			return new ScreensBase();
		}
		
		protected function initializeMainMenu():void 
		{
			_main_menu = createMainMenu();
			stage.addEventListener(MainMenuEvent.NAVIGATE, onMainMenuNavigate);
			
		}
		
		protected function createMainMenu() : MainMenuBase
		{
			return new MainMenuBase();
		}
		
		protected function onMainMenuNavigate(e:MainMenuEvent):void 
		{
			_screens.addScreen(e.data as Class);
		}
		
		protected function initializeStageMonitor() : void
		{
			_stage_monitor = new StageMonitor(stage);
			_stage_monitor.addEventListener(StageMonitor.STAGE_RESIZE_EVENT, onStageResize);
		}
		
		protected function onStageResize(e:Event):void 
		{
			
		}
	}
}