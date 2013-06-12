package projects.xperia.screens 
{
	import com.greensock.easing.Quad;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jeka.MovAnim;
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.movie_clip.MovieClipListener;
	import projects.shared.utils.user_interface.Button;
	import projects.xperia.effects.Swirls;
	/**
	 * Start screen of the application
	 * @author trayko
	 */
	public class StartScreen extends AbstractScreen
	{
		private var _swirls:Swirls;
		
		public function StartScreen() : void
		{
			_graphic.addEventListener(Event.ENTER_FRAME, onStartAnimationFrame);
			
			Button.initializeButton(_graphic.start_button, onStartButtonClicked, onStartButtonOver, onStartButtonOut);
			Button.initializeButton(_graphic.letter_animation.content.button_next, onNextButton);
			_graphic.start_button.over.alpha  = 0;
			_graphic.start_button.over.visible = false;
			
			_graphic.letter_animation.visible = false;
		}
		
		private function onStartAnimationFrame(e:Event):void 
		{
			if (MovieClip(e.target).currentFrame == MovieClip(e.target).totalFrames)
			{
				_graphic.removeEventListener(Event.ENTER_FRAME, onStartAnimationFrame);
				initializeSwirls();
			}
		}
		
		private function initializeSwirls() : void
		{
			_swirls = new Swirls(190, 297);
			_swirls.x = 30;
			_swirls.y = 125;
			TweenMax.from(_swirls, 1, { alpha: 0 } );
			_graphic.phone_animation.addChild(_swirls);
		}
		
		private function onStartButtonOver(e:MouseEvent):void
		{
			_graphic.start_button.over.visible = true;
			TweenMax.to(_graphic.start_button.over			, .3, { alpha: 1 } );
			TweenMax.to(_graphic.start_button.letter		, .4, { scaleX: 1.1, scaleY: 1.1, ease: Quad.easeInOut } );
		}
		
		private function onStartButtonOut(e:MouseEvent):void
		{
			TweenMax.to(_graphic.start_button.over			, .2, { alpha: 0 } );
			TweenMax.to(_graphic.start_button.letter		, .2, { scaleX: 1, scaleY: 1 } );
		}
		
		private function onStartButtonClicked(e:MouseEvent):void
		{
			Button.disposeButton(_graphic.start_button, onStartButtonClicked, onStartButtonOver, onStartButtonOut);
			
			_graphic.letter_animation.visible = true;
			TweenMax.from(_graphic.letter_animation.content	, .7, { alpha: 0, delay: 1.2 });
			_graphic.letter_animation.play();
		}
		
		private function onNextButton(e:MouseEvent):void
		{
			playClosingAnimations();
		}
		
		private function playClosingAnimations():void 
		{
			TweenMax.to(_graphic							, .2, { onComplete: closeScreen } );
			TweenMax.to(_graphic.letter_animation.content	, .3, { alpha: 0 } );
			TweenMax.to(_graphic.letter_animation			, .5, { alpha: 0, delay: .5, onComplete: exitScreen } );
			TweenMax.to(_graphic.phone_animation			, .5, { alpha: 0, delay: .2 } );
			
			_graphic.start_button.visible = false;
			
			_graphic.letter_animation.play();
		}
		
		override public function animateOut():void 
		{
			
		}
		
		override public function dispose():void 
		{
			_swirls.dispose();
			Button.disposeButton(_graphic.letter_animation.content.button_next, onNextButton);
			
			super.dispose();
		}
		
	}

}