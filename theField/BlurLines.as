package theField {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class BlurLines extends EventDispatcher {
		var ar:Array;
		var time:Timer;
		
		public function BlurLines(tf:TheField, animateIn:Boolean = true):void
		{	
			FilterShortcuts.init();
			ar = tf.getRands(0, 'lines', false);
			if (animateIn)
			{
				animLines();
				Tweener.addTween(this, {delay: (ar.length * .15) / .5, onComplete: function():void{dispatchEvent(new Event('showed'));}});
			}
		}
		
		private function animLines():void
		{
			for (var i:String in ar)
				Tweener.addTween(ar[i], {alpha: 0, _Blur_blurX: 500, x: -300});
			var time:Timer = new Timer(150, ar.length);
			time.addEventListener(TimerEvent.TIMER, onTime);
			time.start();			
		}
		
		private function onTime(e:TimerEvent):void
		{
			Tweener.addTween(ar[e.target.currentCount - 1], {alpha: 1, _Blur_blurX: 0, x: 0, time: .5});
		}
		
		public function out():void
		{
			for (var i:String in ar)
				Tweener.pauseTweens(ar[i], 'alpha', '_Blur_blurX', 'x');
			if (time != null)
				time.reset();
			time = new Timer(100, ar.length);
			time.addEventListener(TimerEvent.TIMER, onOutTime);
			time.start();
			Tweener.addTween(ar[0], {time: (ar.length) * .189, onComplete: function():void{dispatchEvent(new Event(Event.COMPLETE));}});
		}
		
		private function onOutTime(e:TimerEvent):void
		{
			Tweener.addTween(ar[e.target.currentCount - 1], {alpha: 0, _Blur_blurX: 500, x: -300, time: .5, transition: 'easeInExpo'});
		}
		
	}
}
