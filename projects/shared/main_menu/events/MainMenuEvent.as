package projects.shared.main_menu.events
{
	import flash.events.Event;
	
	/**
	 * Used for various events dispatched from the main menu
	 * 
	 * @author trayko
	 */
	public class MainMenuEvent extends Event
	{
		public static const NAVIGATE			:String = 'navigate';
		
		public var data							:Object;
		
		public function MainMenuEvent(type_:String, data_:Object = null, bubbles_:Boolean = false) 
		{
			data = data_;
			
			super(type_, bubbles_);
		}
		
	}

}