package projects.shared.utils.text 
{
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	/**
	 * Dispatches input events from a text field
	 * 
	 * @author trayko
	 */
	public class InputDispatcher 
	{
		public static function registerField(field_:TextField, input_handler_:Function) : void
		{
			field_.addEventListener(Event.CHANGE, function() : void
			{
				input_handler_.apply(this, [field_.text]);
			});
		}
		
		
	}

}