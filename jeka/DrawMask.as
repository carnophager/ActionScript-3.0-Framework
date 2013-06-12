package jeka
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class DrawMask extends Sprite
	{
		public function DrawMask(X:Number = 0, Y:Number = 0, w:Number = 100, h:Number = 100, masked:DisplayObject = null, holder:DisplayObjectContainer = null, roundWidth:Number = 0, roundHeight:Number = 0) : void
		{
			with(graphics)
			{
				beginFill(0xFF0000);
				drawRoundRect(0, 0, w, h, roundWidth, roundHeight);
				endFill();
			}
			x = X;
			y = Y;
			masked.mask = this;
			if(holder != null)
				holder.addChild(this);
		}
	}
}		