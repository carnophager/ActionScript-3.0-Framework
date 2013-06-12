package videoplayer.assets.timelines
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import videoplayer.events.VideoStatusEvent;

	public class Timeline extends EventDispatcher
	{
		protected var __progress			:MovieClip;
		protected var __played				:MovieClip;
		protected var __dragger				:MovieClip;
		protected var __maxWidth			:Number;
		protected var __offset				:Number;
		
		public function Timeline( elements:Object ) : void
		{
			__progress = elements.preloader;
			__played = elements.played;
			__dragger = elements.dragger;
			__maxWidth = __progress.width;
			__offset = Math.round(__dragger.getBounds( __dragger).x) != -Math.round(__dragger.width / 2) ? __dragger.width + __dragger.getBounds(__dragger).x : 0;
			__progress.scaleX = __played.scaleX = 0;
			__played.mouseEnabled = __dragger.mouseEnabled = false;
		}
		
		public function init() : void
		{
			__progress.buttonMode = true;
			setListeners();
		}
		
		protected function setListeners() : void
		{
			__progress.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			__dragger.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		}
		
		protected function onDown(e:MouseEvent) : void
		{
			__dragger.x = __progress.mouseX * (__progress.scaleX - __offset);
			//__dragger.startDrag(false, new Rectangle(0, __dragger.y, __maxWidth - __offset, 0));
			__progress.addEventListener(Event.ENTER_FRAME, onMove);
			__progress.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.START_DRAG));
		}
		
		protected function onUp(e:MouseEvent) : void
		{
			__dragger.stopDrag();
			__progress.removeEventListener(Event.ENTER_FRAME, onMove);
			__progress.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.STOP_DRAG));
		}
		
		protected function onMove(e:Event) : void
		{
			__dragger.x = Math.min( Math.max( 0, __dragger.parent.mouseX ), __progress.scaleX * ( __maxWidth - __offset));
			var percents:Number = __dragger.x / ( __maxWidth - __offset );
			__played.scaleX = percents;
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.ON_TIME_CHANGE, { time: percents } ));
		}
		
		public function update(progressScale:Number, playedScale:Number) : void
		{
			__progress.scaleX = progressScale;
			__played.scaleX = playedScale;
			__dragger.x = playedScale * ( __maxWidth - __offset );
		}
	}

}