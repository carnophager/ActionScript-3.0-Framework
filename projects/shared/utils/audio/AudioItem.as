package projects.shared.utils.audio 
{
	import carn.Bmp;
	import flash.events.EventDispatcher;
	import flash.media.*;
	import projects.shared.data.Library;
	/**
	 * Plays a single audio item exported from the library with linkage_name_ passed as an argument.
	 * @author trayko
	 */
	public class AudioItem extends EventDispatcher
	{
		private var _sound			:Sound;
		private var _sound_channel	:SoundChannel;
		
		public function AudioItem(linkage_name_:String) : void
		{
			var SoundClass:Class = Library.getClass(linkage_name_);
			_sound = new SoundClass() as Sound;
			_sound_channel = new SoundChannel();
			_sound_channel = _sound.play();
			trace(_sound_channel);
		}
		
	}

}