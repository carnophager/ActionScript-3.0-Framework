package utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Roller
	{
		public static function init(mc:MovieClip) : void
		{
			mc.addEventListener(MouseEvent.ROLL_OVER, mcRollOverHandler);
			mc.addEventListener(MouseEvent.ROLL_OUT, mcRollOutHandler);
		}
		
		private static function mcRollOverHandler(e:MouseEvent) : void
		{
			goForth(e.target as MovieClip);
		}
		
		private static function mcRollOutHandler(e:MouseEvent) : void
		{
			goBack(e.target as MovieClip);
		}
		
		public static function goForth(mc:MovieClip) : void
		{
			clean(mc);
			mc.addEventListener(Event.ENTER_FRAME, forward);
		}
		
		public static function goBack(mc:MovieClip) : void
		{
			clean(mc);
			mc.addEventListener(Event.ENTER_FRAME, backward);
		}
		
		private static function forward(e:Event) : void
		{
			var mc:MovieClip = e.target as MovieClip;
			mc.nextFrame();
			if ( mc.currentFrame == mc.totalFrames ) mc.removeEventListener(Event.ENTER_FRAME, forward);
		}
		
		private static function backward(e:Event) : void
		{
			var mc:MovieClip = e.target as MovieClip;
			mc.prevFrame();
			if ( mc.currentFrame == 1 ) mc.removeEventListener(Event.ENTER_FRAME, backward);
		}
		
		public static function clean(mc:MovieClip) : void
		{
			mc.removeEventListener(Event.ENTER_FRAME, forward);
			mc.removeEventListener(Event.ENTER_FRAME, backward);
		}
	}
}