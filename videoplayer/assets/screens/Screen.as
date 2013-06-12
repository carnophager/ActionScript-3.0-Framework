package videoplayer.assets.screens
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Video;
	import flash.net.NetStream;
	
	public class Screen extends Sprite
	{
		
		private var __video			:Video;
		private var __pW			:Number;
		private var __pH			:Number;
		private var __initPlayerX	:Number;
		private var __initPlayerY	:Number;
		
		public function get w() : Number { return __pW; }
		public function get h() : Number { return __pH; }
		public function get initX() : Number { return __video.x; }
		public function get initY() : Number { return __video.y; }
		
		public function Screen() : void { }
		
		public function set video(value:Video):void 
		{
			__video = value;
			setProperties();
			replaceFatherhood();
		}
		
		private function replaceFatherhood() : void
		{
			__video.parent.addChildAt(this, __video.parent.getChildIndex(__video));
			addChild(__video);
		}
		
		public function resetVideo() : void 
		{
			var video:Video = new Video(__video.width, __video.height);
			__video.parent.addChildAt(video, __video.parent.getChildIndex(__video));
			video.smoothing = __video.smoothing;
			__video.parent.removeChild(__video);
			__video = null;
			__video = video;
		}
		
		private function setProperties() : void
		{
			__pW = __video.width;
			__pH = __video.height;
			__initPlayerX = __video.x;
			__initPlayerY = __video.y;
		}
		
		public function set stream(value:NetStream) : void
		{
			__video.attachNetStream(value);
		}
		
		public function set smoothing(value:Boolean) : void 
		{
			__video.smoothing = value;
		}
		
		public function clear() : void
		{
			__video.clear();
		}
		
		public function propResize(w:Number, h:Number, centered:Boolean = true)
		{
			var videoWidth = w;
			var videoHeight = h;
			
			__video.width = __pW;
			__video.height = __pH;
			
			if (__pW >= videoWidth && __pH >= videoHeight)
			{
				__video.width = videoWidth;
				__video.height = videoHeight;
			} else if (__pW >= videoWidth && __pH <= videoHeight) {
				__video.width = __pH * (videoWidth / videoHeight);
			} else if (__pW <= videoWidth && __pH >= videoHeight) {
				__video.height = __pW * (videoHeight / videoWidth);
			} else if (__pW <= videoWidth && __pH <= videoHeight) {
				if (videoHeight / videoWidth < __pH / __pW)
				{
					__video.height = __pW * (videoHeight / videoWidth);
				} else {
					__video.width = __pH * (videoWidth / videoHeight);
				}
			}
			
			if ( centered ) 
			{
				__video.x = __initPlayerX + (__pW - __video.width) / 2;
				__video.y = __initPlayerY + (__pH - __video.height) / 2;
			}
			
		}
		
		public function setSize(w:Number, h:Number) : void 
		{
			__video.width = w;
			__video.height = h;
		}
		
		public function setPosition(x:Number, y:Number) : void 
		{
			__video.x = x;
			__video.y = y;
		}
		
	}

}