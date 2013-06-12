package theField {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import caurina.transitions.*;

	public class BigWords extends EventDispatcher {
		var ar:Object;
		var words:Array;
		var time:Timer;
		
		public function BigWords(tf:TheField, words:Array):void
		{
			ar = tf.getRands(0, 'words', false);
			this.words = words;
			time = new Timer(2000, words.length);
			time.addEventListener(TimerEvent.TIMER, onTime);
			time.start();
		}
		
		public function kill():void
		{
			time.reset();
		}
		
		private function onTime(e:TimerEvent):void
		{
			var m:MovieClip = ar.words[ar.txt.indexOf(words[e.target.currentCount - 1])];
			//var m1:MovieClip = ar.words[ar.txt.indexOf(words[e.target.currentCount - 1]) + 1];
			animateWord(m);
			//animateWord(m1);
		}
		
		private function animateWord(m:MovieClip):void
		{
			var Y:Number = m.getChildAt(0).y;
			var X:Number = m.getChildAt(0).x;
			m.oldWidth = m.width / 2;			
			
			Tweener.addTween(ar.words, {alpha: .5, time: 1});
			Tweener.addTween(m, {scaleX: 2, scaleY: 2, alpha: 1, time: 1});
			Tweener.addTween(m, {x: -15, y: -10, time: 3});
			
			Tweener.addTween(m, {scaleX: 1, scaleY: 1, alpha: .5, time: 1, delay: 4});
			Tweener.addTween(m, {x: 0, y: 0, time: 3, delay: 4});
			Tweener.addTween(ar.words, {alpha: 1, time: 1, delay: 4});
			
			for (var i:int = 0; i < m.numChildren; i++)
			{
				MovieClip(m.getChildAt(i)).initX = m.getChildAt(i).x;
				Tweener.addTween(m.getChildAt(i), {y: m.getChildAt(i).y - (Y / 2 + 6), x: m.getChildAt(i).x - (X / 2 + m.oldWidth / 2), time: 1});
				Tweener.addTween(m.getChildAt(i), {y: Y, x: MovieClip(m.getChildAt(i)).initX, time: 1, delay: 4});
			}			
		}
	}
}
