package jeka
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.*;
	
	public class MovAnim
	{
		
		MovieClip.prototype.overOut = function():void
		{
			this.stop();
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		static public function onOver(e:MouseEvent):void
		{
			e.target.removeEventListener(Event.ENTER_FRAME, enterOnOut);
			e.target.play();
			e.target.addEventListener(Event.ENTER_FRAME, enterOnOver);
		}
		
		static public function onOut(e:MouseEvent):void
		{		
			e.target.removeEventListener(Event.ENTER_FRAME, enterOnOver);
			e.target.addEventListener(Event.ENTER_FRAME, enterOnOut);
		}
		
		MovieClip.prototype.over = function():void
		{
			this.play();
			this.removeEventListener(Event.ENTER_FRAME, enterOnOut);
			this.removeEventListener(Event.ENTER_FRAME, enterOnOver);
			this.addEventListener(Event.ENTER_FRAME, enterOnOver);
		}
		
		MovieClip.prototype.out = function():void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterOnOver);
			this.removeEventListener(Event.ENTER_FRAME, enterOnOut);
			this.addEventListener(Event.ENTER_FRAME, enterOnOut);
		}
		
		static function enterOnOver(e:Event):void
		{
			if (e.target.currentFrame == e.target.totalFrames)
			{
				e.target.stop();
				e.target.removeEventListener(Event.ENTER_FRAME, enterOnOver);
			}
		}
		
		static function enterOnOut(e:Event):void
		{
			e.target.gotoAndStop(e.target.currentFrame - 1);
			if (e.target.currentFrame == 1)
			{
				e.target.removeEventListener(Event.ENTER_FRAME, enterOnOut);
			}
		}
	}
}