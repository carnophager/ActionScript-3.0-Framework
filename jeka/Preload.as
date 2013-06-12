package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	import flash.utils.Timer;
	
	public class Preload extends MovieClip
	{
		var btl:Number, bld:Number, func:Function, mov:MovieClip;
		var time:Timer = new Timer(10, 1);
		
		public function startPreload(func:Function, mov:MovieClip):void
		{
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;
			this.func = func;
			this.mov = mov;
			btl = stage.loaderInfo.bytesTotal;
			stage.addEventListener(Event.ENTER_FRAME, checkLoaded);	
		}
		
		function checkLoaded(e:Event):void
		{
			bld = stage.loaderInfo.bytesLoaded;
			loader.text = Math.round((bld / btl) * 100).toString() + '%';
			if (bld == btl)
			{
				this.visible = false;
				time.addEventListener(TimerEvent.TIMER, switchFrame);
				time.start();
				mov.gotoAndStop(2);
				stage.removeEventListener(Event.ENTER_FRAME, checkLoaded);	
			}
		}
		
		function switchFrame(e:TimerEvent):void
		{
			func();
		}
		
	}
}