/**
 * Draws a DisplayObject to Bitmap and adds it as a child to a container
 * @author carnophage
 */

package carn 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class MB extends Sprite
	{
		
		public function MB (displayObject:DisplayObject, transparent:Boolean = false, target:DisplayObjectContainer = null, xLoc:Number = NaN, yLoc:Number = NaN, fillColor:uint = 0xFFFFFF, depth:Number = 0):void 
		{
			target = target ? target : displayObject.parent;
			target.addChild(this);
			x = !isNaN(xLoc) ? xLoc : displayObject.x;
			y = !isNaN(yLoc) ? yLoc : displayObject.y;
			name = displayObject.name;
			MB.draw(displayObject, transparent, this, 0, 0, fillColor, depth);
		}
		
		public static function draw(displayObject:DisplayObject,  transparent:Boolean = false, target:DisplayObjectContainer = null, xLoc:Number = NaN, yLoc:Number = NaN, fillColor:uint = 0xFFFFFF, depth:Number = NaN):void 
		{
			var bd:BitmapData = new BitmapData(displayObject.width, displayObject.height, transparent, fillColor);
			var b:Bitmap = new Bitmap(bd);
			bd.draw(displayObject);
			target = target ? target : displayObject.parent;
			target.addChildAt(b, !isNaN(depth) ? depth : displayObject.parent.getChildIndex(displayObject));
			b.x = !isNaN(xLoc) ? xLoc : displayObject.x;
			b.y = !isNaN(yLoc) ? yLoc : displayObject.y;
			displayObject.parent.removeChild(displayObject);
		}
		
	}
}