package videoplayer.events 
{
	import flash.events.Event;

	public class VideoStatusEvent extends Event
	{
		
		public var info							:Object;
		
		public static const PAUSE				:String = 'paused';
		public static const STOP				:String = 'stop';
		public static const FINISH				:String = 'finish';
		public static const ON_TIME_CHANGE		:String = 'onTimeChange';
		public static const START_DRAG			:String = 'startDrag';
		public static const STOP_DRAG			:String = 'stopDrag';
		public static const VOLUME_CHANGE		:String = 'volumeChange';
		public static const COVER_LOADED		:String = 'coverLoaded';
		public static const FULLSCREEN			:String = 'fullscreen';
		
		public function VideoStatusEvent(type:String, info:Object = null) : void
		{
			this.info = info;
			super(type, true, false);
		}
		
	}

}