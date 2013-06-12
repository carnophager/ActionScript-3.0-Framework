package utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class Rotate3D
	{
		private static var __object				:DisplayObject;
		private static var __offset				:int;
		private static var __easing				:int;
		private static var __rotateX			:Boolean;
		private static var __rotateY			:Boolean;
		
		public static function rotate(object:DisplayObject, offset:int = 20, easing:int = 15, rotateY:Boolean = true, rotateX:Boolean = true) : void
		{
			__object = object;
			__offset = offset;
			__easing = easing;
			__rotateX = rotateX;
			__rotateY = rotateY;
			object.addEventListener(Event.ENTER_FRAME, rotateObject);
		}
		
		private static function rotateObject(e:Event) : void
		{
			var centerX:Number = __object.stage.stageWidth / 2;
			var centerY:Number = __object.stage.stageHeight / 2;
			if ( __rotateY ) __object.rotationY -= ( __object.rotationY - ( __object.stage.mouseX - centerX ) / centerX * __offset ) / __easing;
			if ( __rotateX ) __object.rotationX -= ( __object.rotationX - ( __object.stage.mouseY - centerY ) / centerY * __offset ) / __easing;
		}
		
		public static function kill() : void 
		{
			__object.removeEventListener(Event.ENTER_FRAME, rotateObject);
		}
	}
}