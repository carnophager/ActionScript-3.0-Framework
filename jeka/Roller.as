package jeka
{
	import flash.display.*;
	import flash.events.*;
	import caurina.transitions.*;
	public class Roller extends MovieClip
	{
		function Roller():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
		}
		function over(evt:MouseEvent):void
		{
			Tweener.addTween(evt.target, {alpha: .5, transition: 'easeOutCubic', time: .5});
		}
		function out(evt:MouseEvent):void
		{
			Tweener.addTween(evt.target, {alpha: 1, transition: 'easeOutCubic', time: 1});
		}
	}
}