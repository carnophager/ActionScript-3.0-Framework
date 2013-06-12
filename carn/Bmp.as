package carn
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	
	public class Bmp extends Bitmap
	{
		private var _bmd:BitmapData;
		
		public function Bmp (s:DisplayObjectContainer, bd:String, snapping:String = 'auto', smooth:Boolean = true):void
		{	
			var bmdClass:Class = Class(getDefinitionByName(bd));
			_bmd = new bmdClass(0, 0) as BitmapData;
			super(_bmd, snapping, smooth);
			s.addChild(this);
		}
		
		public function get bmd():BitmapData
		{
			return _bmd;
		}
	}	
}