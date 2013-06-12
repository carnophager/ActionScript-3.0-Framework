package projects.dojo_card
{
	import adobe.utils.CustomActions;
	import carn.Bmp;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import jeka.MovAnim;
	import jeka.Rez;
	import projects.shared.utils.net.OpenURL;
	import projects.shared.utils.display.Swiper;
	import utils.EasyRider;
	/**
	 * Controls the entire scrolling view
	 * @author trayko
	 */
	public class HandScroller extends Sprite
	{
		public static const PIECES	:int = 19;
		
		private var SCROLL_ON		:MovieClip;
		
		private var _graphic		:Sprite;
		private var _resizer		:Rez;
		private var _scrollbar		:EasyRider;
		private var _swiper			:Swiper;
		private var _slogans		:Slogans;
		private var _card			:MovieClip;
		private var _card_mode		:Boolean;
		private var _prototype		:MovAnim;
		private var _card_timer		:Timer;
		private var _scroll_on_big	:MovieClip;
		private var _slogan_changed	:Boolean;
		private var _slogan_distance:int;
		private var _saved_point	:int;
		
		public function HandScroller() : void
		{
			_prototype = new MovAnim();
			_resizer = new Rez();
			_card_mode = false;
			
			_graphic = new Sprite();
			_graphic.buttonMode = true;
			addChild(_graphic);
			
			_slogan_changed = true;
			_slogans = new Slogans(this, PIECES);
			_slogans.addEventListener('TIME_FOR_CHANGE', onSlogansChange);
			
			createHand();
			createCard();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			SCROLL_ON = new SCROLL_ON_TIGER();
			addChild(SCROLL_ON);
			
			var scroll_dragger:Sprite = new ScrollDragger();
			scroll_dragger.buttonMode = true;
			scroll_dragger.y = stage.stageHeight - scroll_dragger.height;
			addChild(scroll_dragger);
			
			_swiper = new Swiper(_graphic, 10, 5);
			_scrollbar = new EasyRider(scroll_dragger, new Rectangle(0, 0, stage.stageWidth - scroll_dragger.width, 0), null, 10);
			
			_swiper.addEventListener('moving', onSwipe);
			_scrollbar.addEventListener('moving', onScrollbar);
			
			_graphic.addEventListener(MouseEvent.MOUSE_DOWN, onGraphicMouseDown);
			scroll_dragger.addEventListener(MouseEvent.MOUSE_DOWN, onScrollDragMouseDown);
			
			_scroll_on_big = new ScrollOnBig();
			addChild(_scroll_on_big);
			
			resize();
		}
		
		private function onGraphicMouseDown(e:MouseEvent):void 
		{
			_scrollbar.kill();
		}
		
		private function onScrollDragMouseDown(e:MouseEvent):void 
		{
			_swiper.kill();
		}
		
		private function onSwipe(e:Event):void 
		{
			_scrollbar.dragger.x = ( _graphic.x / -_swiper.limit_end ) * _scrollbar.limits.width;
			checkSlogan();
		}
		
		private function onScrollbar(e:Event):void 
		{
			_graphic.x = Math.round( ( _scrollbar.dragger.x / _scrollbar.limits.width ) * -_swiper.limit_end );
			checkSlogan();
		}
		
		private function checkSlogan():void 
		{
			_slogans.checkForChange( int(( _graphic.x / -_swiper.limit_end ) * PIECES ) )
			
			_slogan_distance = _saved_point - Math.abs(_graphic.x);
			if ( _slogan_changed && Math.abs(_slogan_distance) > 4000 )
			{
				_slogan_changed = false;
				_slogans.addNewSlogan();
			}
			
			if ( _card_mode )
			{
				if ( _card.currentFrame > 1 )
				{
					_card.removeEventListener(MouseEvent.ROLL_OVER, onCardOver);
					_graphic.x = _card.width - _graphic.width - 100;
					//trace(_graphic.scaleX, _card.width, _card.scaleX);
					_scrollbar.dragger.x = _scrollbar.limits.width;
					
					if ( !_card_timer )
					{
						_card_timer = new Timer(30);
						_card_timer.addEventListener(TimerEvent.TIMER, onCardTimer);
						_card_timer.start();
					}
				} else if ( _graphic.x > _card.width - _graphic.width - 100 ) {
					//_slogans.checkForChange(17);
					_card_mode = false;
					
					_card.addEventListener(MouseEvent.ROLL_OVER, onCardOver);
				}
			}
			
			if ( _scroll_on_big && _graphic.x < -400 )
			{
				removeChild(_scroll_on_big);
				_scroll_on_big = null;
			}
		}
		
		private function hideSlogan():void 
		{
			_slogans.hideCurrentSlogan();
			_slogans.current_slogan_id = 0;
			
			SCROLL_ON.gotoAndStop('HIDE');
		}
		
		private function onSlogansChange(e:Event):void 
		{
			_saved_point = Math.abs(_graphic.x);
			_slogan_changed = true;
			
			var scroll_on_label:MovieClip = SCROLL_ON.scroll_on;
			scroll_on_label.gotoAndStop(scroll_on_label.currentFrame < scroll_on_label.totalFrames ? scroll_on_label.currentFrame + 1 : 1);
			SCROLL_ON.play();
		}
		
		private function onCardOver(e:MouseEvent):void 
		{
			_card_mode = true;
			
			_scrollbar.kill();
			_swiper.kill();
			
			if (  _graphic.x != _card.width * _graphic.scaleX - _graphic.width )
			{
				TweenMax.killTweensOf(_graphic);
				TweenMax.to(_graphic, .3, { x: _card.width * _graphic.scaleX - _graphic.width, onComplete: function() : void { if ( _card_mode && _card.hitTestPoint(mouseX, mouseY) ) _card.over(); } } );
			} else {
				_card.over();
			}
		}
		
		private function onCardTimer(e:TimerEvent):void 
		{
			_card.gotoAndStop(_card.currentFrame - 5);
			
			if ( _card.currentFrame == 1 )
			{
				_card_timer.removeEventListener(TimerEvent.TIMER, onCardTimer);
				_card_timer.stop();
				_card_timer = null;
			}
		}
		
		private function onCardOut(e:Event):void 
		{
			_card_mode = false;
		}
		
		private function createHand():void 
		{
			var i			:int;
			var length		:int = PIECES;
			var bmp			:Bmp;
			var x_position	:Number = 0;
			
			for (i = 0; i < length; i++) 
			{
				bmp = new Bmp(_graphic, i == length - 1 ? 'hand_end' : 'hand_loop');
				
				bmp.x = x_position;
				x_position += bmp.width;
				_graphic.addChild(bmp);
			}
		}
		
		private function createCard():void 
		{
			_card = new Card();
			_card.stop();
			
			_card.addEventListener(MouseEvent.ROLL_OVER	, onCardOver);
			_card.addEventListener(MouseEvent.ROLL_OUT	, MovAnim.onOut);
			
			_graphic.addChild(_card);
		}
		
		public function resize():void 
		{
			//_resizer.rezoHeight(_graphic, Math.round(stage.stageHeight), true);
			//_graphic.width = 500;
			//_graphic.height = 500;
			//trace(_graphic.height, _graphic.width, Math.round(stage.stageHeight));
			//trace(stage.getBounds(_graphic.getChildAt(1)));
			//trace(_graphic.getChildAt(1).localToGlobal(new Point(0, 0)));
			repositionSlices();
			_scrollbar.dragger.y = stage.stageHeight - _scrollbar.dragger.height;
			_swiper.resizeLimits(0, _graphic.width - stage.stageWidth);
			_scrollbar.limits = new Rectangle(0, 0, stage.stageWidth - _scrollbar.dragger.width, 0);
			_slogans.reposition();
			
			if ( _scroll_on_big )
			{
				_scroll_on_big.x = stage.stageWidth >> 1;
				_scroll_on_big.y = stage.stageHeight >> 1;
			}
			
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0, 0, stage.stageWidth, 31);
			graphics.drawRect(0, stage.stageHeight - 18, stage.stageWidth, 18);
			graphics.endFill();
		}
		
		private function repositionSlices():void 
		{
			var i				:int;
			var length			:int = _graphic.numChildren;
			var piece			:DisplayObject;
			var x_position		:Number = 0;
			var piece_height	:Number = 0;
			
			
			for (i = 0; i < length; i++) 
			{
				piece = _graphic.getChildAt(i);
				piece_height = Math.round(stage.stageHeight);
				if ( i == length - 1 )
				{
					piece_height *= 1.044;
					piece.y = -piece_height * 0.051;
				}
				
				_resizer.rezoHeight(piece, piece_height, true);
				piece.x = x_position;
				x_position += piece.width;
			}
		}
		
	}

}