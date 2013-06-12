package videoplayer.assets.sound
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import utils.EasyRider;
	import videoplayer.events.VideoStatusEvent;

	public class SoundControl extends EventDispatcher
	{
		
		protected var __dragger				:MovieClip;
		protected var __icon				:MovieClip;
		protected var __progress			:MovieClip;
		protected var __timeline			:MovieClip;
		protected var __maxWidth			:Number;
		protected var __easyRider			:EasyRider;
		protected var __volume				:Number;
		protected var __muted				:Boolean;
		
		public function SoundControl(elements:Object, initVolume:Number = .5) : void
		{
			__dragger = elements.dragger;
			__icon = elements.icon;
			__progress = elements.progress;
			__timeline = elements.timeline;
			__maxWidth = __timeline.width;
			setRider();
			setListeners();
			__volume = initVolume;
			__dragger.x = initVolume * __maxWidth;
			onMove(null);
			dispatchVolume(initVolume);
		}
		
		protected function setRider() : void
		{
			__easyRider = new EasyRider(__dragger, new Rectangle(0, __dragger.y, __maxWidth, 0), [__dragger, __timeline]);
			__easyRider.addEventListener('moving', onMove);
		}
		
		protected function setListeners() : void
		{
			__icon.addEventListener(MouseEvent.ROLL_OVER, onOver);
			__icon.addEventListener(MouseEvent.ROLL_OUT, onOut);
			__dragger.addEventListener(MouseEvent.ROLL_OVER, onOver);
			__dragger.addEventListener(MouseEvent.ROLL_OUT, onOut);
			__icon.addEventListener(MouseEvent.CLICK, onIconClick);
			__timeline.buttonMode = true;
			__dragger.buttonMode = true;
			__icon.buttonMode = true;
			__icon.mouseChildren = false;
			__progress.mouseEnabled = false;
		}
		
		protected function onIconClick(e:MouseEvent) : void
		{
			__easyRider.kill();
			var volume:Number = __volume * __maxWidth;
			if ( !__muted )
			{
				__muted = true;
				volume = 0;
				__icon.gotoAndStop('STOP');
			} else  {
				__muted = false;
				__icon.gotoAndStop('PLAY');
			}
			TweenLite.to(__dragger, .5, { x: volume, ease: Strong.easeOut, onUpdate: function() : void { dispatchVolume(__dragger.x / __maxWidth); }} ); 
			TweenLite.to(__progress, .5, { scaleX: volume / __maxWidth, ease: Strong.easeOut } ); 
		}
		
		protected function onMove(e:Event) : void
		{
			__volume = __dragger.x / __maxWidth;
			__progress.scaleX = __volume;
			if ( __volume == 0 ) __icon.gotoAndStop('STOP');
			else __icon.gotoAndStop('PLAY');
			dispatchVolume(__volume);
		}
		
		protected function dispatchVolume(volume:Number) : void
		{
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.VOLUME_CHANGE, { volume: volume } ));
		}
		
		protected function onOver(e:MouseEvent) : void
		{
			TweenLite.to(e.target, .7, { colorTransform: { exposure: 1.2 }, ease: Strong.easeOut } );
		}
		
		protected function onOut(e:MouseEvent) : void
		{
			TweenLite.to(e.target, .7, { colorTransform: { exposure: 1 }, ease: Strong.easeOut } );
		}
		
		public function kill() : void 
		{
			__easyRider.kill();
		}
		
	}

}