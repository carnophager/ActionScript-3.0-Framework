package videoplayer
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import videoplayer.assets.buttons.MainControls;
	import videoplayer.assets.covers.Picture;
	import videoplayer.assets.screens.Screen;
	import videoplayer.assets.sound.SoundControl;
	import videoplayer.assets.time.Time;
	import videoplayer.assets.timelines.Timeline;
	import videoplayer.clients.DefaultClient;
	import videoplayer.events.VideoInfoEvent;
	import videoplayer.events.VideoStatusEvent;

	public class Player extends EventDispatcher
	{
		protected var __netConnection			:NetConnection
		protected var __netStream				:NetStream;
		protected var __client					:DefaultClient;
		protected var __video					:Screen;
		protected var __smoothing				:Boolean;
		protected var __centered				:Boolean;
		protected var __propResize				:Boolean;
		protected var __isPlaying				:Boolean;
		protected var __paused					:Boolean;
		protected var __stopped					:Boolean;
		protected var __ending					:Boolean;
		protected var __videoURL				:String;
		protected var __picture					:Picture;
		protected var __duration				:Number;
		protected var __volume					:Number;
		protected var __timeline				:Timeline;
		protected var __mainControls			:MainControls;
		protected var __soundControl			:SoundControl;
		protected var __time					:Time;
		
		public function set centered(value:Boolean) : void 
		{
			__centered = value;
		}
		
		public function set propResize(value:Boolean) : void 
		{
			__propResize = value;
		}
		
		public function Player() : void
		{
			createVideo();
			createControls();
			__smoothing = true;
			__centered = true;
			__propResize = true;
			__volume = .5;
		}
		
		protected function createVideo() : void
		{
			__video = new Screen();	
		}
		
		protected function createControls() : void
		{
			__mainControls = new MainControls();
			__mainControls.addEventListener(VideoStatusEvent.PAUSE, pauseClickHandler);
			__mainControls.addEventListener(VideoStatusEvent.STOP, stopVideoHandler);
		}
		
		protected function render(e:Event) : void
		{
			if ( __timeline ) __timeline.update(__netStream.bytesLoaded / __netStream.bytesTotal, __netStream.time / __duration);
			if ( __time ) __time.setElapsedTime();
			//if ( __netStream.time >= __duration || __duration - __netStream.time < .1 ) onVideoFinish();
		}
		
		protected function onVideoFinish() : void
		{
			__video.removeEventListener(Event.ENTER_FRAME, render);
			__stopped = true;
			__paused = true;
			__netStream.pause();
			__video.visible = false;
			if ( __picture ) __picture.show();
			if ( __timeline ) __timeline.update(1, 0);
			if ( __mainControls ) __mainControls.status(MainControls.STOP);
		}
		
		public function init() : void
		{
			setNetConnection();
		}
		
		protected function setNetConnection() : void
		{
			__netConnection = new NetConnection();
			__netConnection.addEventListener(NetStatusEvent.NET_STATUS, onStatus);
			__netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			__netConnection.connect(null);
		}
		
		protected function onStatus(e:NetStatusEvent) : void
		{
			switch (e.info.code)
			{
				case 'NetConnection.Connect.Success' :
					setClient();
					setStream();
					setVideo();
				break;
				
				case 'NetStream.Play.StreamNotFound' :
					throw new Error('Stream not found');
				break;
				
				case 'NetStream.Play.Stop' :
					dispatchEvent(new VideoStatusEvent(VideoStatusEvent.FINISH));
					onVideoFinish();
				break;
			}
		}
		
		protected function finalStatus(e:NetStatusEvent) : void
		{
			if ( e.info.code == 'NetStream.Seek.Notify' )
			{
				__video.addEventListener(Event.ENTER_FRAME, render);
				__netStream.removeEventListener(NetStatusEvent.NET_STATUS, finalStatus);
			}
		}
		
		protected function onSecurityError(e:SecurityErrorEvent) : void
		{
			throw new Error('Security Error: ' + e);
		}
		
		public function set video(value:Video) : void
		{
			__video.video = value;
		}
		
		public function set smoothing(value:Boolean):void 
		{
			__smoothing = value;
		}
		
		protected function setVideo() : void
		{
			__video.stream = __netStream;
			__video.smoothing = __smoothing;
		}
		
		protected function setStream() : void
		{
			__netStream = new NetStream(__netConnection);
			__netStream.addEventListener(NetStatusEvent.NET_STATUS, onStatus);
			__netStream.client = __client;
		}
		
		public function play(videoURL:String, pictureURL:String = null, autoStart:Boolean = true) : void
		{
			__videoURL = videoURL;
			if ( __isPlaying ) kill();
			__isPlaying = false;
			__paused = true;
			if ( autoStart ) 
			{
				__stopped = false;
				if ( __mainControls ) __mainControls.status(MainControls.PLAY);
				playVideo();
			} else if ( __mainControls ) {
				__mainControls.paused = true;
			}
			if ( pictureURL ) setPicture(pictureURL);
		}
		
		public function kill() : void
		{
			if ( __picture )
			{
				__picture.remove();
				__picture = null;
			}
			onVideoFinish();
			__netStream.close();
			__video.clear();
			__video.resetVideo();
			__video.stream = __netStream;
		}
		
		public function replay() : void 
		{
			__netStream.play(__videoURL);
			__netStream.seek(0);
		}
		
		protected function setPicture(pictureURL:String) : void
		{
			__picture = new Picture(pictureURL, __video.w, __video.h);
			__picture.x = __video.initX;
			__picture.y = __video.initY;
			__video.parent.addChildAt(__picture, __video.parent.getChildIndex(__video) + 1);
			if ( __isPlaying ) __picture.hide();
		}
		
		public function addButton(value:DisplayObject, type:String) : void
		{
			__mainControls.addButton(value, type);
		}
		
		public function set time(value:Object) : void
		{
			__time = new Time(value.total, value.elapsed, value.hours != null ? value.hours : true);
		}
		
		protected function pauseClickHandler(e:VideoStatusEvent ) : void
		{
			playVideo();
		}
		
		protected function stopVideoHandler(e:VideoStatusEvent) : void
		{
			onVideoFinish();
		}
		
		protected function playVideo() : void
		{
			if ( __paused ) __paused = false;
			else __paused = true;
			if ( __isPlaying )
			{
				__netStream.togglePause();
			} else {
				if ( __picture ) __picture.hide();
				__netStream.play(__videoURL);
				__netStream.seek(0);
				__video.visible = false;
				__netStream.pause();
				__isPlaying = true;
				__netStream.soundTransform = new SoundTransform(__volume);
			}
			
			if ( __stopped )
			{
				__video.visible = true;
				__stopped = false;
				__netStream.addEventListener(NetStatusEvent.NET_STATUS, finalStatus);
				__netStream.seek(0);
				if ( __picture ) __picture.hide();
			}
		}
		
		protected function setClient() : void
		{
			__client = new DefaultClient();
			__client.addEventListener(VideoInfoEvent.ON_META_DATA, onMetaData);
		}
		
		protected function onMetaData(e:VideoInfoEvent) : void
		{
			if ( __propResize ) __video.propResize(e.info.w, e.info.h, __centered);
			__netStream.resume();
			__video.visible = true;
			__duration = e.info.duration;
			if ( __time ) __time.init(__duration, __netStream);
			if ( __timeline ) __timeline.init();
			__video.addEventListener(Event.ENTER_FRAME, render);
		}
		
		public function set timeline (value:Object) : void 
		{
			__timeline = new Timeline(value);
			setTimelineBehavior();
		}
		
		protected function setTimelineBehavior() : void
		{
			__timeline.addEventListener(VideoStatusEvent.START_DRAG, onStartDrag);
			__timeline.addEventListener(VideoStatusEvent.STOP_DRAG, onStopDrag);
			__timeline.addEventListener(VideoStatusEvent.ON_TIME_CHANGE, onTimeChange);
		}
		
		protected function onStartDrag (e:VideoStatusEvent) : void
		{
			__netStream.pause();
			__video.removeEventListener(Event.ENTER_FRAME, render);
		}
		
		protected function onStopDrag(e:VideoStatusEvent) : void
		{
			if ( __ending ) 
			{
				onVideoFinish();
				return;
			}
			if ( !__paused ) __netStream.resume();
			__video.addEventListener(Event.ENTER_FRAME, render);
		}
		
		protected function onTimeChange(e:VideoStatusEvent) : void
		{
			var time:Number = Math.round(e.info.time * __duration);
			//if ( time > __duration - 1 ) time = __duration - 1;
			if ( time >= __duration ) __ending = true;
			else __ending = false;
			if ( __stopped )
			{
				playVideo();
				__netStream.removeEventListener(NetStatusEvent.NET_STATUS, finalStatus);
				onStartDrag(null);
				if ( __mainControls ) __mainControls.status(MainControls.PLAY);
			}
			if ( __time ) __time.setElapsedTime();
			__netStream.seek(time);
		}
		
		public function set sound(value:Object) : void
		{
			__soundControl = new SoundControl(value);
			__soundControl.addEventListener(VideoStatusEvent.VOLUME_CHANGE, onVolumeChange);
		}
		
		protected function onVolumeChange(e:VideoStatusEvent) : void
		{
			__volume = e.info.volume;
			__netStream.soundTransform = new SoundTransform(e.info.volume);
		}
		
	}
}