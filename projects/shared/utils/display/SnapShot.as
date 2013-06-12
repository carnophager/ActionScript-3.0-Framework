package projects.shared.utils.display
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class SnapShot extends Sprite
	{
		var bmd:BitmapData, bmdRect:BitmapData;
		var bmp:Bitmap;
		var rectangle:Rectangle;
		var pt:Point, ptGlobal:Point;
		
		public function SnapShot(src:DisplayObject, rect:Rectangle, smoothing:Boolean = false) : void
		{
			bmd = new BitmapData(src.width, src.height, true, 0xFF0000);
			var bounds:Rectangle = src.getBounds(src);
			
			var offsetX:Number = ( bounds.width - src.width ) / 2;
			var offsetY:Number = ( bounds.height - src.height ) / 2;
			
			bmdRect = new BitmapData(rect.width, rect.height, true, 0xFF0000);
			bmd.draw(src, new Matrix(src.scaleX, 0, 0, src.scaleY/*, Math.round( -bounds.x - offsetX ), Math.round ( -bounds.y - offsetY )*/ ) );
			rectangle = new Rectangle(rect.x, rect.y, rect.width, rect.height);
			pt = new Point( 0, 0 );
			bmdRect.copyPixels(bmd, rectangle, pt);
			bmp = new Bitmap(bmdRect, 'auto', smoothing);
			addChild(bmp);
		}
		
		public function get bitmap_data() : BitmapData
		{
			return bmdRect;
		}
	}
}
