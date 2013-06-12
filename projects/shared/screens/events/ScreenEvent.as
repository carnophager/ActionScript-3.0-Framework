package projects.shared.screens.events 
{
	import flash.events.Event;
	
	/**
	 * Used for various events dispatched from the screens
	 * 
	 * @author trayko
	 */
	public class ScreenEvent extends Event
	{
		public static const CLOSE_SCREEN		:String = 'close_screen';
		public static const EXIT_SCREEN			:String = 'exit_screen';
		public static const ADD_SCREEN			:String = 'add_screen';
		static public const PHOTO_LOADED		:String = 'photo_loaded';
		static public const PHOTO_SAVED			:String = 'photo_saved';
		
		public var data							:Object;
		
		public function ScreenEvent(type_:String, data_:Object = null, bubbles_:Boolean = false) 
		{
			data = data_;
			
			super(type_, bubbles_);
		}
		
	}

}