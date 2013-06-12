package jeka
{
	import flash.display.*;
	public class Rez
	{
		var ratio:Number;
		public var w:Number;
		public var h:Number;
		
		public function rezo(mc:Sprite, w:Number):void
		{
			ratio = mc.height / mc.width;
			mc.width = w;
			mc.height = w * ratio;
		}
		
		public function rezoWidth(mc:DisplayObject, w:Number) : void
		{
			var ratio:Number = mc.height / mc.width;
			mc.width = w;
			mc.height = w * ratio;
		}
		
		public function rezoHeight(mc:DisplayObject, h:Number, rounded:Boolean = false) : void
		{
			var ratio:Number = mc.width / mc.height;
			mc.height = h;
			mc.width = h * ratio;
			if ( rounded ) mc.width = Math.round(mc.width);
		}
		
		public function rezoAnim(mc:Sprite, wi:Number):void
		{
			w = wi;
			ratio = mc.height / mc.width;
			h = w * ratio;
		}
	}
}
