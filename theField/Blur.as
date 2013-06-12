package theField {
	import jeka.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	FilterShortcuts.init();
	
	public class Blur {
		
		
		public static function blur(elements:Array, blurRange:Array, timeRange:Array):void
		{
			for (var i:String in elements)
			{
				var rand:Number = Rando.rando(blurRange[0], blurRange[1]);
				Tweener.addTween(elements[i], {_Blur_blurX: rand, _Blur_blurY: rand});
				Tweener.addTween(elements[i], {_Blur_blurX: 0, _Blur_blurY: 0, time: Rando.rando(timeRange[0], timeRange[1])});
			}
		}
		
	}
}

