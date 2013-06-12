package projects.shared.utils.user_interface

{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * Basic instantiation of button
	 * @author trayko
	 */
	
	public class Button
	{
		public static function initializeButton(button_:Sprite, callback_handler_:Function = null, roll_over_handler_:Function = null, roll_out_handler_:Function = null, text_:String = null, use_alpha_animation_:Boolean = false) : void
		{
			button_.buttonMode = true;
			button_.mouseChildren = false;
			
			if ( callback_handler_ != null )
				button_.addEventListener(MouseEvent.CLICK		, callback_handler_	, false, 0, true);
				
			if ( text_ && button_.getChildByName('text') as TextField )
				TextField(button_.getChildByName('text')).text = text_;
			
			if ( use_alpha_animation_ )
			{
				roll_over_handler_ = rollOverAlphaHandler;
				roll_out_handler_ = rollOutAlphaHandler;
			}
			
			button_.addEventListener(MouseEvent.ROLL_OVER	, Boolean(roll_over_handler_) ? roll_over_handler_ : rollOverHandler	, false, 0, true);
			button_.addEventListener(MouseEvent.ROLL_OUT	, Boolean(roll_out_handler_) ? roll_out_handler_ : rollOutHandler	, false, 0, true);	
		}
		
		private static function rollOverHandler(e:MouseEvent) : void
		{
			TweenMax.to(e.target, .5, { colorMatrixFilter:{brightness:1.2, saturation:1.3, contrast: 1.3}});
		}
		
		private static function rollOutHandler(e:MouseEvent) : void 
		{
			TweenMax.to(e.target, .5, { colorMatrixFilter:{brightness:1, saturation:1, contrast: 1}});
		}
		
		private static function rollOverAlphaHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { alpha: .8 } );
		}
		
		private static function rollOutAlphaHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { alpha: 1 } );
		}
		
		public static function disposeButton(button_:Sprite, callback_handler_:Function = null, roll_over_handler_:Function = null, roll_out_handler_:Function = null) : void
		{
			button_.removeEventListener(MouseEvent.ROLL_OVER	, Boolean(roll_over_handler_) ? roll_over_handler_ : rollOverHandler);
			button_.removeEventListener(MouseEvent.ROLL_OUT		, Boolean(roll_out_handler_) ? roll_out_handler_ : rollOutHandler);
			
			if ( callback_handler_ != null )
				button_.removeEventListener(MouseEvent.CLICK	, callback_handler_);
			
			button_.mouseEnabled = false;
			button_.buttonMode = false;
		}
	}

}