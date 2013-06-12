package jeka
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class SnapShot extends Sprite
	{
		private var bmd:BitmapData, bmdRect:BitmapData;
		private var bmp:Bitmap;
		private var rectangle:Rectangle;
		private var pt:Point, ptGlobal:Point;
		
		public function SnapShot(src:DisplayObject, rect:Rectangle):void
		{
			bmd = new BitmapData(src.width, src.height);
			bmdRect = new BitmapData(rect.width, rect.height);
			bmd.draw(src);
			ptGlobal = new Point(rect.x, rect.y);
			rectangle = new Rectangle(src.globalToLocal(ptGlobal).x, src.globalToLocal(ptGlobal).y, rect.width, rect.height);
			pt = new Point(0, 0);
			bmdRect.copyPixels(bmd, rectangle, pt);
			bmp = new Bitmap(bmdRect);
			addChild(bmp);
		}
	}
}
