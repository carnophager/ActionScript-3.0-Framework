package fx 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	
	public class Pixelate extends EventDispatcher
	{
		private var __src						:Sprite;
		private var __holder					:Sprite;
		private var __bitmap					:Bitmap;
		private var __bitmapProcess		:BitmapData;
		private var __scaleMatrix			:Matrix;
		private var __pixelSize				:Number;
		private var __outMod					:Number;
		private var __end						:Number;
		private var __out						:Boolean;
		
		public function get holder() { return __holder; }
		
		public function Pixelate( src:Sprite, pixelSize:Number = 1.4, outMod:Number = 1.05, end:Number = 17, centered:Boolean = true, out:Boolean = true ):void 
		{
			__src = src;
			__bitmap = new Bitmap(__bitmapProcess);
			__holder = new Sprite();
			if (centered)
			{
				__holder.x = __src.x + __src.width / 2;
				__holder.y = __src.y + __src.height / 2;
			} else {
				__holder.x = __src.x;
				__holder.y = __src.y;
			}
			src.parent.addChildAt(__holder, src.parent.getChildIndex(src));
			__holder.addChild(__bitmap);
			__bitmap.x -= __src.width / 2;
			__bitmap.y -= __src.height / 2;
			src.parent.removeChild(src);
			
			__pixelSize = pixelSize;
			__outMod = outMod;	
			__end = end;
			__out = out;
		}
		
		public function startPixelation():void
		{
			pixelateOut(null);
			__src.addEventListener(Event.ENTER_FRAME, pixelateOut);
		}
		
		private function pixelateOut(e:Event):void 
		{
			__bitmapProcess = new BitmapData(__src.width / Number(__pixelSize.toFixed(3)), __src.height / Number(__pixelSize.toFixed(3)), true, 0);
			__scaleMatrix = new Matrix();
			__scaleMatrix.scale(1 / Number(__pixelSize.toFixed(3)), 1 / Number(__pixelSize.toFixed(3)));
			trace(__pixelSize);
			__bitmapProcess.draw(__src, __scaleMatrix, null, null, null, true);
			__bitmap.bitmapData = __bitmapProcess;
			__bitmap.width = __src.width;
			__bitmap.height = __src.height;
			__pixelSize *= __outMod;
			
			if ( (__pixelSize >= __end && __out) || (__pixelSize <= __end && !__out) )
			{
				dispatchEvent(new Event(Event.COMPLETE));
				__src.removeEventListener(Event.ENTER_FRAME, pixelateOut);
			}
		}
		
		public function pixelateTo(pixelSize:Number):void
		{
			__bitmapProcess = new BitmapData(__src.width / pixelSize, __src.height /pixelSize, true, 0);
			__scaleMatrix = new Matrix();
			__scaleMatrix.scale(1 / pixelSize, 1 / pixelSize);
			__bitmapProcess.draw(__src, __scaleMatrix);
			__bitmap.bitmapData = __bitmapProcess;
			__bitmap.width = __src.width;
			__bitmap.height = __src.height;
		}
	}
	
}