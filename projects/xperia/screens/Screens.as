package projects.xperia.screens
{
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.screens.ScreensBase;
	import projects.xperia.screens.enum.ScreenType;
	/**
	 * @author trayko
	 */
	public class Screens extends ScreensBase
	{
		override protected function afterScreenWithTypeClosed(screen_event_:ScreenEvent):void 
		{
			switch ( screen_event_.target.constructor )
			{
				case StartScreen :
					addScreen(ScreenType.CHOOSE_SONG.type);
				break;
			}
		}
	}
}