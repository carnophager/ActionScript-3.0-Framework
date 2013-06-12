package utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Del
	{
		private var __timer				:Timer;
		private var __func				:Function;
		private var __params			:Array;
		
		public function Del(time:Number, func:Function, params:Array = null) : void
		{
			__func	= func;
			__params = params;
			createTimer(time);
		}
		
		private function createTimer(time:Number) : void
		{
			__timer = new Timer(time * 1000, 1);
			__timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			__timer.start();
		}
		
		private function timerCompleteHandler(e:TimerEvent) : void
		{
			kill();
			__func.apply(null, __params);
		}
		
		public function kill() : void
		{
			__timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			__timer.stop();
			__timer = null;
		}
	}
}