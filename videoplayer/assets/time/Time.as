package videoplayer.assets.time
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.NetStream;
	import flash.text.TextField;
	import utils.EasyRider;
	import videoplayer.events.VideoStatusEvent;

	public class Time extends EventDispatcher
	{
		private var __ns				:NetStream
		private var __totalTime			:TextField;
		private var __elapsedTime		:TextField;
		private var __hours				:Boolean;
		
		public function Time(totalTime:TextField, elapsedTime:TextField, hours:Boolean) : void
		{
			__totalTime = totalTime;
			__elapsedTime = elapsedTime;
			__hours = hours;
		}
		
		public function init(duration:Number, ns:NetStream) : void
		{
			__ns = ns;
			setTotalTime(duration);
		}
		
		private function setTotalTime(duration:Number) : void
		{
			var totalHours:Number = Math.floor(duration / 3600);
			var totalMinutes:Number = Math.floor( ( duration % 3600 ) / 60);
			var totalSeconds:Number = Math.floor( ( ( duration % 3600 ) ) % 60);
			var hours:String = __hours ? (totalHours < 10 ? '0' + totalHours : totalHours).toString() + ':' : '';
			__totalTime.text = hours + (totalMinutes < 10 ? '0' + totalMinutes : totalMinutes).toString() + ':' + (totalSeconds < 10 ? '0' + totalSeconds : totalSeconds).toString();
		}
		
		public function setElapsedTime() : void
		{
			var currentMinutes:Number = Math.floor(__ns.time / 60);
			var currentSeconds:Number = Math.floor(__ns.time % 60);
			__elapsedTime.text = (currentMinutes < 10 ? '0' + currentMinutes : currentMinutes).toString() + ':' + (currentSeconds < 10 ? '0' + currentSeconds : currentSeconds).toString()
		}
		
	}
}