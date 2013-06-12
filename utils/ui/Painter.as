package utils.ui
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Painter
	{
		public static function paint(element:Object, color:uint, alpha: Number, x:Number, y:Number, w:Number, h:Number) : void 
		{
/*			var type:Class = Class(getDefinitionByName(getQualifiedClassName(element)));
			if ( type != Shape && type != Sprite && type != MovieClip )
			{
				throw new TypeError('Allowed types are only Shape, Sprite and MovieClip.');
			}*/
			element.graphics.beginFill(color, alpha);
			element.graphics.drawRect(x, y, w, h);
			element.graphics.endFill();
		}
	}
}