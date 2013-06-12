package theField {
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;

	public class Glow {
		
		
		public function Glow(elements:Array, range:Array, sRange:Array, color:uint):void
		{
			for (var i:String in elements)
			{
				var rand:Number = Rando.rando(range[0], range[1]);
				var sRand:Number = Rando.rando(sRange[0], sRange[1]);
				var gf:GlowFilter = new GlowFilter(color, 1, rand, rand, sRand, 3);
				var filts:Array = [gf];
				
				var time:Timer = new Timer(300);
				time.addEventListener(TimerEvent.TIMER, onTime);
				time.start();
				
				function onTime(e:TimerEvent):void
				{
					gf.alpha -= .03;
					gf.strength -= .03;
					for (var i:String in elements)
					{
						elements[i].filters = filts;
					}
					
					if (gf.alpha == 0)
					{
						e.target.stop();
						e.target.reset();
						e.target.removeEventListener(TimerEvent.TIMER, onTime);
					}
					
				}
			}
		}
		
	}
}
