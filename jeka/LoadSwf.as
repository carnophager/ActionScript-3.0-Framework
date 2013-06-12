package jeka
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequest;
	
	public class LoadSwf extends MovieClip
	{
		var fun:Function, progFun:Function;
		var mid:Boolean = true;
		var percents:Number;
		var _loader:Loader;
		
		public function get loader():Loader
		{
			return _loader;
		}
		
		function LoadSwf(swf:String, fun:Function = null, mid:Boolean = true, progFun:Function = null):void
		{
			this.fun = fun;
			this.mid = mid;
			_loader = new Loader();
			var request:URLRequest = new URLRequest(swf);
			_loader.load(request);
			addChild(_loader);
			configureListeners(_loader.contentLoaderInfo);
		}
		
		function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		function completeHandler(evt:Event):void
		{
			if(fun != null)
				fun();
			var swf = evt.target;
			if (mid)
			{
				_loader.x -= swf.width / 2;
				_loader.y -= swf.height / 2;
			}
		}
		
		function progressHandler(evt:ProgressEvent):void
		{
			if(progFun != null)
				progFun();
		}
	}
}