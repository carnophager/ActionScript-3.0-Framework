package projects.xperia
{
	import projects.shared.MainBase;
	import projects.shared.screens.ScreensBase;
	import projects.xperia.screens.enum.ScreenType;
	import projects.xperia.screens.Screens;
	/**
	 * Xperia musical facebook app
	 * @author trayko
	 */
	public class Main extends MainBase
	{
		
		override public function initialize():void 
		{
			super.initialize();
			
			_screens.addScreen(ScreenType.START.type);
		}
		
		override protected function createScreens():ScreensBase 
		{
			return new Screens();
		}
		
	}

}