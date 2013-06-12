package fashion.nugget.events
{

	import flash.events.Event;

	/**
	 * @author Lucas Motta - http://lucasmotta.com
	 */
	public class SoundEvent extends Event
	{
		
		// ----------------------------------------------------
		// PUBLIC STATIC CONSTANTS
		// ----------------------------------------------------
		public static const SOUND_COMPLETE : String = "SoundEvent:SOUND_COMPLETE";
		
		public static const SOUND_START : String = "SoundEvent:SOUND_START";
		
		public static const MUTE_ALL : String = "SoundEvent:MUTE_ALL";
		
		public static const UNMUTE_ALL : String = "SoundEvent:UNMUTE_ALL";
		
		// ----------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------
		/**
		 * @constructor
		 */
		public function SoundEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
