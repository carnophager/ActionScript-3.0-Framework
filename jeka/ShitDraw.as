package jeka
{
	import flash.display.*
	import flash.events.*;
	public class ShitDraw extends Sprite
	{
		var buhal:uint = Math.random() * 0xFFFFFF;
		var lineHeight:int = Math.random() * 10;
		function ShitDraw():void
		{
			graphics.moveTo(mouseX, mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, drawLine);
			stage.addEventListener(MouseEvent.CLICK, getBuh);
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, fuckOff);
			stage.doubleClickEnabled = true;
			//trace(obj);
			trace(stage);
		}
		function getBuh(evt:MouseEvent):void
		{
			buhal = Math.random() * 0xFFFFFF;
			lineHeight = Math.random() * 10;
		}
		function drawLine(evt:MouseEvent):void
		{
			graphics.lineStyle(lineHeight, buhal);
			graphics.lineTo(mouseX, mouseY);
			evt.updateAfterEvent();
		}
		function fuckOff(evt:MouseEvent):void
		{
			graphics.clear();
			graphics.moveTo(mouseX, mouseY);
		}
		public function here()
		{
			trace('here');
		}
	}
}