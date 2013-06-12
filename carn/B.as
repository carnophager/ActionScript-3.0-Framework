package carn
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	
	public class B 
	{
		public static function add (s:DisplayObjectContainer, bd:String, posX:Number = 0, posY:Number = 0, width:int = 0, height:int = 0, snapping:String = 'auto', smooth:Boolean = true):void
		{
			var b:Class = Class(getDefinitionByName(bd));
			var bitmap:Bitmap = new Bitmap(new b(width, height) as BitmapData, snapping, smooth)
			bitmap.x = posX;
			bitmap.y = posY;
			s.addChild(bitmap);
		}
	}	
}