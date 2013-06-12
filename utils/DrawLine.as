package utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class DrawLine extends Shape
	{
		
		private var __holder				:DisplayObjectContainer;
		private var __speed					:Number;
		private var __startPoint			:Point;
		private var __endPoint				:Point;
		private var __color					:uint;
		private var __bitmapStyle			:BitmapData;
		private var __destinationX			:Number = 0;
		private var __destinationY			:Number = 0;
		
		public function DrawLine(holder:DisplayObjectContainer, startPoint:Point, endPoint:Point, speed:Number = 3, color:uint = 0xFF0000, bitmapStyle:BitmapData = null) : void
		{
			__holder = holder;
			__startPoint = startPoint;
			__endPoint = endPoint;
			__speed = speed;
			__color = color;
			__bitmapStyle = bitmapStyle;
			__holder.addChildAt(this, 0);
			__holder.addEventListener(Event.ENTER_FRAME, draw);
		}
		
		private function draw(e:Event) : void
		{
			var dx:Number = __endPoint.x - __startPoint.x;
			var dy:Number = __endPoint.y - __startPoint.y;
			var angle:Number = Math.atan2(dy, dx);
			var vx:Number = Math.cos(angle) * __speed;
			var vy:Number = Math.sin(angle) * __speed;
			__destinationX += vx;
			__destinationY += vy;
			graphics.clear();
			graphics.lineStyle(1, __color);
			if ( __bitmapStyle) graphics.lineBitmapStyle(__bitmapStyle);
			graphics.lineTo(__destinationX, __destinationY);
			if ( Math.abs(__destinationX) >= Math.abs(__endPoint.x) && Math.abs(__destinationY) >= Math.abs(__endPoint.y) ) __holder.removeEventListener(Event.ENTER_FRAME, draw);
		}
		
	}
}