package theField {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class DropCurveLines extends EventDispatcher {
		var ar:Array;
		var time:Timer;
		var speed:int;
		
		public function DropCurveLines(tf:TheField, animateIn:Boolean = true, speed:int = 30):void
		{	
			FilterShortcuts.init();
			DisplayShortcuts.init();
			CurveModifiers.init();
			ar = tf.getRands(0, 'lines', false);
			this.speed = speed;
			if (animateIn)
				animLines();
		}
		
		private function animLines():void
		{
			for (var i:String in ar)
				Tweener.addTween(ar[i], {_autoAlpha: 0, y: -ar[i].height-10, x: -300});
			var time:Timer = new Timer(speed, ar.length);
			time.addEventListener(TimerEvent.TIMER, onTime);
			time.start();			
		}
		
		private function onTime(e:TimerEvent):void
		{
			Tweener.addTween(ar[e.target.currentCount - 1], {_autoAlpha: 1, y: 0, x: 0, _bezier: {y: 130, x: -30}, time: .9, transition: 'easeOutBack'});
		}

	}
}
