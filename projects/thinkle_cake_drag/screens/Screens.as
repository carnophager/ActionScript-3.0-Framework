package projects.thinkle_cake_drag.screens
{
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.screens.ScreensBase;
	import projects.thinkle_cake_drag.screens.enum.ScreenType;
	/**
	 * @author trayko
	 */
	public class Screens extends ScreensBase
	{
		override protected function afterScreenWithTypeClosed(screen_event_:ScreenEvent):void 
		{
			switch ( screen_event_.target.constructor )
			{
				case FansInfo :
					addScreen(ScreenType.CARD_DECORATION.type);
				break;
				
				case CardDecoration :
					addScreen(screen_event_.data == 'back' ? ScreenType.FAN_INFO.type : ScreenType.REGISTRATION.type );
				break;
				
				case Registration :
					case Gallery :
						addScreen(ScreenType.SHARE_SCREEN.type);
				break;
				
				case ShareScreen :
					addScreen(ScreenType.GALLERY.type);
				break;
			}
		}
	}
}