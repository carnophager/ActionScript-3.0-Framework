package videoplayer.assets.buttons 
{
	import com.greensock.easing.Strong;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import fl.motion.easing.Quadratic;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import videoplayer.events.VideoStatusEvent;

	public class MainControls extends EventDispatcher
	{
		
		public static var STOP					:String = 'stop';
		public static var PLAY					:String = 'play';
		public static var PAUSER				:String = 'pauser';
		public static var FULLSCREEN			:String = 'fullscreen';
		
		protected var __buttons					:Array;
		protected var __paused					:Boolean;
		
		public function set paused(value:Boolean):void 
		{
			__paused = value;
		}
		
		public function MainControls() : void
		{
			__buttons = [];
			TweenPlugin.activate([ColorTransformPlugin]);
		}
		
		public function addButton(button:DisplayObject, type:String) : void
		{
			__buttons.push( { button: button, type: type } );
			switch ( type )
			{
				case PAUSER :
					setPauser(MovieClip(button));
				break;
				
				case STOP :
					setStopper(MovieClip(button));
				break;
				
				case FULLSCREEN :
					setFullscreen(MovieClip(button));
				break;
			}
		}
		
		private function setStopper(button:MovieClip) : void
		{
			setPauser(button);
			button.removeEventListener(MouseEvent.CLICK, onPauseClick);
			button.addEventListener(MouseEvent.CLICK, stopClickHandler);
		}
		
		private function stopClickHandler(e:MouseEvent) : void
		{
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.STOP));
		}
		
		protected function setPauser(button:MovieClip) : void
		{
			button.addEventListener(MouseEvent.CLICK, onPauseClick);
			button.addEventListener(MouseEvent.ROLL_OVER, onPauseOver);
			button.addEventListener(MouseEvent.ROLL_OUT, onPauseOut);
			button.buttonMode = true;
			button.mouseChildren = false;
		}
		
		protected function onPauseOver(e:MouseEvent) : void
		{
			TweenLite.to(e.target, .7, { colorTransform: { exposure: 1.2 }, ease: Strong.easeOut } );
		}
		
		protected function onPauseOut(e:MouseEvent) : void
		{
			TweenLite.to(e.target, .7, { colorTransform: { exposure: 1 }, ease: Strong.easeOut } );
		}
		
		protected function onPauseClick(e:MouseEvent) : void
		{
			status(__paused ? PLAY : STOP);
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.PAUSE));
		}
		
		protected function setFullscreen(button:MovieClip) : void
		{
			button.addEventListener(MouseEvent.CLICK, onFullscreenClick);
			button.addEventListener(MouseEvent.ROLL_OVER, onFullscreenOver);
			button.addEventListener(MouseEvent.ROLL_OUT, onFullscreenOut);
			button.buttonMode = true;
			button.mouseChildren = false;
		}
		
		protected function onFullscreenClick(e:MouseEvent) : void
		{
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.FULLSCREEN));
		}
		
		protected function onFullscreenOver(e:MouseEvent) : void
		{
			
		}
		
		protected function onFullscreenOut(e:MouseEvent) : void
		{
			
		}
		
		public function status(status:String ) : void
		{	
			switch ( status )
			{
				case STOP :
					__paused = true;
					for (var name:String in __buttons) 
					{
						switch ( __buttons[name].type )
						{
							case PAUSER :
								__buttons[name].button.gotoAndStop(1);
							break;
						}
					}
				break;
				
				case PLAY :
					__paused = false;
					for (name in __buttons) 
					{
						switch ( __buttons[name].type )
						{
							case PAUSER :
								__buttons[name].button.gotoAndStop(2);
							break;
						}
					}
				break;
			}
		}
		
	}

}