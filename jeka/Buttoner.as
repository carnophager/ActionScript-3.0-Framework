package jeka
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;

	public class Buttoner extends MovieClip
	{
		var borma:String;
		public var counter:Number;
		public function Buttoner():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.buttonMode = true;
			this.mouseChildren = false;
			trace(stage);
		}
		public function Title(tits:String, guca:String, tLabel:String):void
		{
			borma = guca;
			this[guca][tLabel].text = tits;
		}
		public function setIndex(index:Number):void
		{
			this.counter = index; 
		}
		private function over(evt:Event):void
		{
			//evt.target.gotoAndPlay('rollover');
			//var rT:Tween = new Tween(evt.target, 'rotation', Elastic.easeInOut,this.rotation,360,2,true);
			var sxT:Tween = new Tween(this[borma], 'scaleX', Elastic.easeOut,this[borma].scaleX,2,2,true);
			var syT:Tween = new Tween(this[borma], 'scaleY', Elastic.easeOut,this[borma].scaleY,2,2,true);
		}
		private function out(evt:Event):void
		{
			var sxTout:Tween = new Tween(this[borma], 'scaleX', Elastic.easeOut,this[borma].scaleX,1,2,true);
			var syTout:Tween = new Tween(this[borma], 'scaleY', Elastic.easeOut,this[borma].scaleY,1,2,true);
		}
	}
}