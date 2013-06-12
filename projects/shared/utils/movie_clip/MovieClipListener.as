package projects.shared.utils.movie_clip
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Listens to when a movieclips reaches particular frames executes callbacks at that moment
	 * @author 
	 */
	public class MovieClipListener extends EventDispatcher
	{
		private var _movie_clip	:MovieClip;
		private var _frames		:Array;
		private var _callbacks	:Array;
		
		public function MovieClipListener(movie_clip_:MovieClip) : void
		{
			_frames = [];
			_callbacks = [];
			_movie_clip = movie_clip_;
			_movie_clip.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function get movie_clip():MovieClip 
		{
			return _movie_clip;
		}
		
		public function listen(frame_:Object, callback_:Function, ...arguments_):void
		{
			_frames.push(frame_);
			_callbacks.push({ callback: callback_, arguments: arguments_ });
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var result:int = Math.max(_frames.indexOf(_movie_clip.currentFrameLabel), _frames.indexOf(_movie_clip.currentFrame) );
			if ( result != -1 )
			{
				_callbacks[result].callback.apply(this, _callbacks[result].arguments);
			}
		}
		
		public function dispose():void 
		{
			_frames = null;
			_callbacks = null;
			
			_movie_clip.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
	}

}