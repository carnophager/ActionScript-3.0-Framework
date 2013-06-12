package projects.shared.pop_ups.events 
{
	import flash.events.Event;
	
	/**
	 * Used for various events dispatched from the popups
	 * 
	 * @author trayko
	 */
	public class PopUpEvent extends Event
	{
		public static const CLOSE				:String = 'close';
		public static const ANIMATE_IN			:String = 'animate_in';
		public static const ANIMATE_OUT			:String = 'animate_out';
		
		public var data							:Object;
		
		public function PopUpEvent(type_:String, data_:Object = null, bubbles_:Boolean = false) 
		{
			data = data_;
			
			super(type_, bubbles_);
		}
		
	}

}