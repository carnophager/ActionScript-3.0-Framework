package projects.shared.screens
{
	import avmplus.getQualifiedClassName;
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import projects.shared.data.Library;
	import projects.shared.screens.events.ScreenEvent;
	/**
	 * @author trayko
	 */
	public class AbstractScreen extends Sprite
	{
		protected var _graphic			:MovieClip;
		
		public function AbstractScreen() : void
		{
			addMainGraphic();
		}
		
		protected function addMainGraphic():void 
		{
			var main_graphic_class_name:String = getQualifiedClassName(this).split('::').pop().replace( /([A-Z])/g, function x():String { return (arguments[2] == 0 ? '' : '_' ) + arguments[0].toLowerCase(); });
			
			if ( ApplicationDomain.currentDomain.hasDefinition(main_graphic_class_name) )
			{
				_graphic = addGraphic( main_graphic_class_name ) as MovieClip;
			} else {
				trace('Unfortunately there is no graphic with linkage name of \'' + main_graphic_class_name + '\' to accompany this marvelous ' + Object(this).constructor + ' Screen object!');
			}
		}
		
		protected function addGraphic(graphic_class_:String) : Sprite
		{
			var graphic:Sprite = Library.instantiateSprite(graphic_class_);
			addChild(graphic);
			return graphic;
		}
		
		public function animateIn(complete_handler_:Function = null):void 
		{
			TweenMax.from(_graphic, 1, { alpha: 0, ease: Sine.easeOut, onComplete: complete_handler_ } );
		}
		
		public function animateOut() : void
		{
			if ( _graphic )
				TweenMax.to(_graphic, .5, { alpha: 0, ease: Sine.easeOut, onComplete: exitScreen } );
			else
				exitScreen();
		}
		
		protected function exitScreen():void 
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.EXIT_SCREEN));
		}
		
		protected function closeScreen() : void
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN));
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