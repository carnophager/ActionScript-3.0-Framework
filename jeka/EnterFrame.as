package jeka
{		
	import flash.display.Sprite;
	import flash.events.Event;
	public class EnterFrame extends Sprite
	{
		var alph:Number = .01;
		var speed:Number = 10;
		function EnterFrame(side:int):void
		{
			with (graphics)
			{
				beginFill(0xFFB509);
				drawRect(-side/2, -side/2, side, side);
			}
			alpha = 0;
			addEventListener(Event.ENTER_FRAME, bounce);
		}
		function bounce(evt:Event):void
		{
			evt.target.x += speed;
			evt.target.y += speed;
			evt.target.rotation += speed;
			if (evt.target.alpha > 1 || evt.target.alpha < 0)
			{
				alph = -alph;
			}
			evt.target.alpha += alph;
			if (evt.target.x > stage.stageWidth-100 || evt.target.x < 0 || evt.target.y > stage.stageHeight-100 || evt.target.y < -50)
			{
				speed = -speed;
			}
		}
	}
}