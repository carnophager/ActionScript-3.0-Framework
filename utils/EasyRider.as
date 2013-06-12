package utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class EasyRider extends EventDispatcher
	{
		private var __dragger				:DisplayObject;
		private var __rect					:Rectangle;
		private var __mouseReceivers		:Array;
		private var __mouseDown				:Boolean;
		private var __distance				:Number;
		private var __easing				:Number;
		private var __prop					:String;
		private var __mouseProp				:String;
		private var __initDist				:Number;
		private var __initRect				:Rectangle;
		
		public function EasyRider(dragger:DisplayObject, rect:Rectangle, mouseReceivers:Array = null, easing:Number = 5, prop:String = 'x') : void 
		{
			__dragger = dragger;
			__rect = rect;
			__initRect = new Rectangle(__rect.x, __rect.y, __rect.width, __rect.height);
			__mouseReceivers = mouseReceivers;
			__easing = easing;
			__prop = prop;
			__mouseProp = prop == 'x' ? 'mouseX' : 'mouseY';
			setListeners();
		}
		
		private function setListeners() : void
		{
			for (var i:String in __mouseReceivers) __mouseReceivers[i].addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			__dragger.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			__dragger.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onDown(e:MouseEvent) : void
		{
			__mouseDown = true;
			__initDist = __dragger.mouseX;
			__rect.x = __initRect.x;
			__rect.width = __initRect.width;
			__rect.x += __initDist;
			__rect.width += __initDist;
			__dragger.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onUp(e:MouseEvent) : void
		{
			if ( __mouseDown == true ) dispatchEvent(new Event('up'));
			__mouseDown = false;
		}
		
		private function onEnter(e:Event) : void
		{
			if ( __mouseDown ) __distance = calcDistance();
			__dragger[__prop] -= ( __dragger[__prop] - __distance + __initDist ) / __easing;
			if ( Math.abs( __dragger[__prop] - __distance + __initDist ) < 1 && !__mouseDown )
			{
				kill();
				dispatchEvent(new Event('stopped'));
				return;
			}
			dispatchEvent(new Event('moving'));
		}
		
		private function calcDistance() : Number
		{
			return Math.min( Math.max( __rect[__prop], __dragger.parent[__mouseProp] ), __rect.width );
		}
		
		public function get limits() : Rectangle
		{
			return __initRect;
		}
		
		public function set limits(rect_:Rectangle) : void
		{
			__initRect = rect_;
		}
		
		public function get dragger():DisplayObject 
		{
			return __dragger;
		}
		
		public function kill (total:Boolean = false) : void
		{
			if ( total )
			{
				for (var i:String in __mouseReceivers) __mouseReceivers[i].removeEventListener(MouseEvent.MOUSE_DOWN, onDown); 	
				__dragger.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			}
			__dragger.removeEventListener(Event.ENTER_FRAME, onEnter);
		}
	}
}