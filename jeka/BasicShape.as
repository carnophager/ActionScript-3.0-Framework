package jeka
{
	import flash.display.*;
	public class BasicShape  extends Sprite
	{
		function BasicShape(color:uint, trance:Number, figure:Number):void
		{
			graphics.beginFill(color, trance);
			graphics.drawRect(figure, figure, figure, figure);
		}
	}
}