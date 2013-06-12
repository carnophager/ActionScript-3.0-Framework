package projects.shared.pop_ups 
{
	import com.greensock.easing.Quart;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import projects.shared.pop_ups.events.PopUpEvent;
	/**
	 * Abstract class with common functionality for all pop-ups
	 * @author trayko
	 */
	public class AbstractPopUp extends Sprite
	{
		protected var _graphic	:MovieClip;
		
		public function AbstractPopUp(graphic_class_:Class) : void
		{
			addGraphic(graphic_class_);
			animateIn();
		}
		
		protected function addGraphic(graphic_class_:Class) : void
		{
			_graphic = new graphic_class_() as MovieClip;
			addChild(_graphic);
		}
		
		public function animateIn() : void
		{
			TweenMax.from(_graphic, .5, { alpha: 0, y: 35, ease: Quart.easeOut, onComplete: animateInHandler } );
			
			dispatchEvent(new PopUpEvent(PopUpEvent.ANIMATE_IN));
		}
		
		public function animateOut() : void
		{
			TweenMax.to(_graphic, .3, { alpha: 0, y: 30, ease: Quart.easeOut, onComplete: animateOutHandler } );
			
			dispatchEvent(new PopUpEvent(PopUpEvent.ANIMATE_OUT));
		}
		
		protected function animateInHandler():void 
		{
			
		}
		
		public function animateOutHandler():void 
		{
			dispose();
		}
		
		public function get graphic():MovieClip 
		{
			return _graphic;
		}
		
		public function dispose() : void
		{
			if ( _graphic )
			{
				if ( _graphic.parent )
					_graphic.parent.removeChild(_graphic);
					
				_graphic = null;
			}
		}
		
	}

}