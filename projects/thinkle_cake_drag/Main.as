package projects.thinkle_cake_drag
{
	import projects.shared.main_menu.MainMenuBase;
	import projects.shared.MainBase;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.screens.ScreensBase;
	import projects.shared.utils.photo_upload.UserPhotoBitmapData;
	import projects.thinkle_cake_drag.data.Parameters;
	import projects.thinkle_cake_drag.MainMenu;
	import projects.thinkle_cake_drag.screens.enum.ScreenType;
	import projects.thinkle_cake_drag.screens.Gallery;
	import projects.thinkle_cake_drag.screens.Screens;
	/**
	 * Thinkle drag cake facebook application
	 * @author trayko
	 */
	public class Main extends MainBase
	{
		
		public function Main() : void
		{
			Parameters.overrideParameters();
			UserPhotoBitmapData.MAX_WIDTH = 430;
			UserPhotoBitmapData.MAX_HEIGHT = 628;
			
			super();
			
			_screens.addScreen(ScreenType.FAN_INFO.type);
			_screens.addEventListener(ScreenEvent.ADD_SCREEN, onAddScreen);
			
			main_menu.visible = false;
		}
		
		private function onAddScreen(e:ScreenEvent):void 
		{
			main_menu.visible = ( Class(e.data) == Gallery ) ? true : false;
		}
		
		override protected function createScreens():ScreensBase
		{
			return new Screens();
		}
		
		override protected function createMainMenu() : MainMenuBase
		{
			return new MainMenu();
		}
	}

}