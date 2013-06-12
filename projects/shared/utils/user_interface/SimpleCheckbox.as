package projects.shared.utils.user_interface 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * Simple two frames checkbox
	 * @author trayko
	 */
	public class SimpleCheckbox 
	{
		
		public static function initialize(checkbox_:MovieClip) 
		{
			checkbox_.mouseChildren = false;
			checkbox_.buttonMode = true;
			checkbox_.addEventListener(MouseEvent.CLICK, function() : void
			{
				checkbox_.gotoAndStop(checkbox_.currentFrameLabel == 'UNCHECKED' ? 'CHECKED' : 'UNCHECKED');
			});
		}
		
	}

}