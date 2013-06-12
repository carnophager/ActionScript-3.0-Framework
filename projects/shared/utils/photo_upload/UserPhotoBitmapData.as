package projects.shared.utils.photo_upload
{
	import flash.display.BitmapData;
	
	public class UserPhotoBitmapData
	{
		protected static var _bitmap_data	:BitmapData;
		protected static var _width			:Number;
		protected static var _height		:Number;
		
		public static var MAX_WIDTH			:int = 420;
		public static var MAX_HEIGHT		:int = 200;
		
		public static var _user_bitmap_datas:Array = [];
		
		public static function writeData(bitmap_data_:BitmapData, id_:int) : void
		{
			_bitmap_data = bitmap_data_;
			
			_user_bitmap_datas[id_] = _bitmap_data;
		}
		
		public static function getData(id_:int) : BitmapData
		{
			return _user_bitmap_datas[id_];
		}
		
		public static function set width(width_:Number) : void
		{
			_width = width_;
		}
		
		public static function get width() : Number
		{
			return _width;
		}
		
		public static function set height(height_:Number) : void
		{
			_height = height_;
		}
		
		public static function get height() : Number
		{
			return _height;
		}
	}
}