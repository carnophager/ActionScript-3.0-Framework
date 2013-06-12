package projects.xperia.screens 
{
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import projects.shared.screens.AbstractScreen;
	import utils.EasyRider;
	/**
	 * User can choose the song he wants to guess here
	 * @author 
	 */
	public class ChooseSongScreen extends AbstractScreen
	{
		
		public function ChooseSongScreen() : void
		{
			_graphic.addEventListener(Event.ADDED_TO_STAGE, onGraphicAdded);
		}
		
		private function onGraphicAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onGraphicAdded);
			
			var easy_rider:EasyRider = new EasyRider(_graphic.player.scrubber, new Rectangle(0, 0, 300, 0), null, .5);
		}
		
		override public function animateIn(complete_handler_:Function = null):void 
		{
			TweenMax.from(_graphic, .5, { alpha: 0, ease: Sine.easeInOut, onComplete: complete_handler_ } );
		}
		
	}

}