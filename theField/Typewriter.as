package theField {
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class Typewriter extends EventDispatcher {
		var ar:Array;
		var time:Timer;
		var speed:int;
		
		public function Typewriter(tf:TheField, animateIn:Boolean = true, speed:int = 30):void
		{	
			FilterShortcuts.init();
			DisplayShortcuts.init();
			CurveModifiers.init();
			ar = tf.getRands(0, 'letters', false);
			this.speed = speed;
			if (animateIn)
				animLines();
		}
		
		private function animLines():void
		{
			for (var i:String in ar)
				Tweener.addTween(ar[i], {_autoAlpha: 0});
				//Tweener.addTween(ar[i], {_autoAlpha: 0, y: ar[i].y - ar[i].height - 10, x: ar[i].x - 300});
			var time:Timer = new Timer(speed, ar.length);
			time.addEventListener(TimerEvent.TIMER, onTime);
			time.start();			
		}
		
		private function onTime(e:TimerEvent):void
		{
			var m:MovieClip = ar[e.target.currentCount - 1]
			//Tweener.addTween(m, {_autoAlpha: 1, y: m.y + m.height + 10, x: m.x + 300, _bezier: {y: m.y + 130, x: m.x - 30}, time: 1});
			Tweener.addTween(m, {_autoAlpha: 1, time: 1});
		}

	}
}
