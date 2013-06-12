package jeka
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import caurina.transitions.*;
	
	public class PosContents extends Sprite
	{
		private var mov:DisplayObject;
		private var st:Object;
		private var animated:Boolean;
		private var posFunc:Function;
		private var X:Boolean, Y:Boolean;
		
		public function PosContents(mov:DisplayObject, st:Object, animated:Boolean = false, posFunc:Function = null, X:Boolean = true, Y:Boolean = true):void
		{
			this.mov = mov;
			this.st = st;
			this.X = X;
			this.Y = Y;
			st.align = StageAlign.TOP_LEFT;
			st.scaleMode = StageScaleMode.NO_SCALE;
			st.addEventListener(Event.RESIZE, posElement);
			this.posFunc = posFunc;
			posElement(new Event(''));
			this.animated = animated;
		}
		
		private function posElement(e:Event):void
		{
			if(animated)
			{
				Tweener.updateTime();
				if (X)
					Tweener.addTween(mov, {x: Math.round(st.stageWidth / 2), time: 1});
				if (Y)
					Tweener.addTween(mov, {y: Math.round(st.stageHeight / 2), time: 1});
			} else {
				if (X)
					mov.x = Math.round(st.stageWidth / 2);
				if (Y)
				mov.y = Math.round(st.stageHeight / 2);				
			}
			if (posFunc != null)
				posFunc();
		}
	}
}