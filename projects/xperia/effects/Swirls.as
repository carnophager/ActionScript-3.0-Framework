package projects.xperia.effects 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Creates a swirl Bitmap that scrolls itself
	 * @author trayko
	 */
	public class Swirls extends Bitmap
	{
		private var _bitmap_data	:BitmapData;
		private var _swirl_data		:BitmapData;
		private var _matrix			:Matrix;
		private var _scroll_amount	:int;
		private var _width			:int;
		private var _height			:int;
		private var _limit_x		:int
		
		public function Swirls(width_:int, height_:int) : void
		{
			_height	= height_;
			_width	= width_;
			_scroll_amount = 0;
			_matrix = new Matrix();
			
			var begin_swirl_data:BitmapData = new SwirlTrack(0, 0);
			_swirl_data = new BitmapData(begin_swirl_data.width + _width, begin_swirl_data.height, true, 0x00FFFFFF);
			_swirl_data.draw(begin_swirl_data);
			_swirl_data.copyPixels(begin_swirl_data, new Rectangle(0, 0, _width, begin_swirl_data.height), new Point(begin_swirl_data.width, 0));
			
			_limit_x = _width - _swirl_data.width;
			
			_bitmap_data = new BitmapData(_width, _height, true, 0x00FFFFFF);
			super(_bitmap_data);
			
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			_scroll_amount--;
			if ( _scroll_amount % 2 )
				return;
			
			_matrix.tx--;
			if ( _matrix.tx < _limit_x )
			{
				_matrix.tx = 0;
			}
			
			_bitmap_data.fillRect(_bitmap_data.rect, 0);
			_bitmap_data.draw(_swirl_data, _matrix);
		}
		
		public function dispose():void 
		{
			removeEventListener(Event.ENTER_FRAME, onEnter);
			
			_bitmap_data.dispose();
			_swirl_data.dispose();
			_matrix = null;
			
			this.bitmapData = null;
		}
		
	}

}