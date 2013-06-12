package projects.thinkle_cake_drag.screens 
{
	import flash.events.MouseEvent;
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.user_interface.Button;
	/**
	 * Fans Info Screen
	 * 
	 * @author trayko
	 */
	public class FansInfo extends AbstractScreen
	{
		
		public function FansInfo() : void
		{
			Button.initializeButton(_graphic.continue_button, onContinueButton);
		}
		
		private function onContinueButton(e:MouseEvent):void 
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN));
		}
		
	}

}