package jeka
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class Del extends EventDispatcher
	{
		
		public static function delay(time:Number, func:Function, params:Array = null):void
		{
			var timer:Timer = new Timer(time * 1000);
			timer.addEventListener(TimerEvent.TIMER, onTime);
			timer.start();
			
			function onTime(e:TimerEvent):void
			{
				timer.removeEventListener(TimerEvent.TIMER, onTime);
				func.apply(null, params);
			}
			
		}

	}
}