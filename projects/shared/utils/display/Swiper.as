package projects.shared.utils.display
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	public class Swiper extends EventDispatcher
	{
		private var _swipe_target			:DisplayObject;
		private var _mouse_down				:Boolean;
		private var _distance				:Number;
		private var _easing					:Number;
		private var _prop					:String;
		private var _mouse_prop				:String;
		private var _init_point				:Number;
		private var _init_pos				:Number;
		private var _limit_begin			:int;
		private var _limit_end				:int;
		private var _speed					:Number;
		
		public function Swiper(swipe_target_:DisplayObject, easing:Number = 5, speed_:Number = 1, limit_begin_:int = 0, limit_end_:int = int.MAX_VALUE, prop:String = 'x') : void
		{
			_swipe_target = swipe_target_;
			_easing = easing;
			_prop = prop;
			resizeLimits(limit_begin_, limit_end_);
			_distance = _limit_begin;
			_speed = speed_;
			_mouse_prop = prop == 'x' ? 'mouseX' : 'mouseY';
			
			setListeners();
		}
		
		private function setListeners() : void
		{
			_swipe_target.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			_swipe_target.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onDown(e:MouseEvent) : void
		{
			_mouse_down = true;
			
			_init_point = _swipe_target.parent[_mouse_prop];
			_init_pos = _swipe_target[_prop];
			
			swipe();
		}
		
		private function swipe():void 
		{
			_swipe_target.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onUp(e:MouseEvent) : void
		{
			if ( _mouse_down == true ) dispatchEvent(new Event('up'));
			_mouse_down = false;
		}
		
		private function onEnter(e:Event) : void
		{
			if ( _mouse_down )
				_distance = Math.max(Math.min( ( _swipe_target.parent[_mouse_prop] - _init_point ) * _speed + _init_pos, 0), - _limit_end);
				
			// init pos makes it final destination of _swipe_target property, without it _distance is from 0 to _mouse_prop position
			_swipe_target[_prop] -= ( _swipe_target[_prop] - _distance ) / _easing;
			
			if ( Math.abs( _swipe_target[_prop] - _distance) < 1 && !_mouse_down )
			{
				kill();
				dispatchEvent(new Event('stopped'));
				return;
			}
			
			dispatchEvent(new Event('moving'));
		}
		
		public function resizeLimits(limit_begin_:int, limit_end_:int ) : void
		{
			_limit_begin = limit_begin_;
			_limit_end = limit_end_;
			
			if ( _swipe_target[_prop] < -_limit_end )
			{
				_distance = -_limit_end;
				
				if ( _swipe_target[_prop] > _limit_begin )
					_distance = _limit_begin;
			} else {
				_distance = _swipe_target[_prop] + 2;
			}
			swipe();
		}
		
		public function get limit_end():int 
		{
			return _limit_end;
		}
		
		public function kill() : void
		{
			_swipe_target.removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function dispose() : void
		{
			_swipe_target.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			kill();
		}
	}
}