package jeka
{
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ShuffleText
	{
		
		var orderSpeed:uint, shuffleSpeed:uint;
		var shuffleAll:Boolean;
		
		public function ShuffleText(orderSpeed:uint = 30, shuffleSpeed: uint = 1):void
		{
			this.orderSpeed = orderSpeed;
			this.shuffleSpeed = shuffleSpeed;
		}
				
		public function shuffle(txt:TextField, str:String, os:uint = 0, ss:uint = 0, delay:uint = 0, shuffleAll:Boolean = false):void
		{
			if ( !os )
				os = orderSpeed;
			if ( !ss )
				ss = shuffleSpeed;
			if ( !delay )
				delay = os * 1.3;
				
			this.shuffleAll = shuffleAll;
			
			var added:String = '';
			
			var ar:Array = str.split('');
			
			var time:Timer = new Timer(os, ar.length);
			time.addEventListener(TimerEvent.TIMER, onTime);
			time.start();
			
			var inTime:Timer = new Timer(ss);
			inTime.addEventListener(TimerEvent.TIMER, getRand);
			inTime.start();
			
			function getRand(e:TimerEvent):void
			{
				if (shuffleAll) 
					txt.htmlText = added + ar.sort(Shuffler1000.shuffle).slice(0, ar.length - added.length).join('');
				else 
					txt.htmlText = added + ar.sort(Shuffler1000.shuffle).join('');
					
			}
			
			function onTime(e:TimerEvent):void
			{
				if (shuffleAll) added += str.charAt(e.target.currentCount - 1);
				else added += ar.splice(ar.indexOf(str.charAt(e.target.currentCount - 1)), 1);
				
				if (e.target.currentCount > (e.target.repeatCount / 3) * 2)
					e.target.delay = delay;
				
				if (e.target.currentCount == e.target.repeatCount)
				{
					inTime.reset();
					txt.htmlText = str;
				}
				
			}
			
		}
		
	}
}