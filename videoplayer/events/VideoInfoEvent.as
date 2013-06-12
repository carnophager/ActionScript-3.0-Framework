package videoplayer.events 
{
	import flash.events.Event;

	public class VideoInfoEvent extends Event
	{
		public var info						:Object;
		public static const ON_META_DATA	:String = 'on_meta_data';
		public static const ON_XMP_DATA		:String = 'on_xmp_data';
		public static const ON_CUE_DATA		:String = 'on_cue_data';
		
		public function VideoInfoEvent(e:String, info:Object = null) : void 
		{
			this.info = info;
			super(e, true, false);
		}
		
	}

}