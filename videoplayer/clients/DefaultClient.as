package videoplayer.clients 
{
	import flash.events.EventDispatcher;
	import videoplayer.events.VideoInfoEvent;

	public class DefaultClient extends EventDispatcher
	{
		
		public function DefaultClient() : void{}
		
		public function onMetaData(info:Object) : void
		{
			//for (var i:String in info) { trace(i, info[i]); }
			dispatchEvent(new VideoInfoEvent(VideoInfoEvent.ON_META_DATA, { duration: info.duration, w: info.width, h: info.height } ));
		}
		
		public function onCuePoint(info:Object) : void
		{
			//for (var i:String in info) { trace(i, info[i]); }
			dispatchEvent(new VideoInfoEvent(VideoInfoEvent.ON_CUE_DATA, info));
		}
		
		public function onXMPData(info:Object) : void 
		{
			//for (var i:String in info) { trace(i, info[i]); }
			dispatchEvent(new VideoInfoEvent(VideoInfoEvent.ON_XMP_DATA));
		}
		
	}

}