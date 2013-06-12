package jeka
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class RollOne extends MovieClip
	{
			function RollOne():void
			{
				this.addEventListener(MouseEvent.ROLL_OVER, goOver);
				this.addEventListener(MouseEvent.ROLL_OUT, goOut);
				this.buttonMode = true;
				this.mouseChildren = false;
			}
			function goOver(evt:MouseEvent):void
			{
				evt.target.gotoAndStop(2);
			}
			function goOut(evt:MouseEvent):void
			{
				evt.target.gotoAndStop(1);
			}
	}
}