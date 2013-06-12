package jeka
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.*;
	import flash.net.URLRequest;
	public class LoadImg extends Sprite
	{
		var loader:Loader = new Loader();
		var tf:String, goche:String;
		var fixed:Number;
		var fun:Function;
		var mid:Boolean = true;
		public var percents:Number;
		
		function LoadImg(pic:String, func:Function = null, mid:Boolean = true, bushanki:String = 'tf', symbol:String = '%', fix:Number = 1):void
		{
			configureListeners(loader.contentLoaderInfo);
			var request:URLRequest = new URLRequest(pic);
			loader.load(request);
			addChild(loader);
			tf = bushanki;
			goche = symbol;
			fixed = fix;
			fun = func;
			this.mid = mid;
		}
		
		function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		function completeHandler(evt:Event):void
		{
			var img:Bitmap = Bitmap(evt.target.content);
			img.smoothing = true;
			if (mid)
			{
				img.x -= img.width / 2;
				img.y -= img.height / 2;
			}
			if (fun != null)
				fun();
		}
		
		function progressHandler(evt:ProgressEvent):void
		{
			percents = evt.bytesLoaded / evt.bytesTotal;
			var benks:String = (percents * 100).toFixed(fixed);
			
			//this.parent[tf].text = benks + goche;
		}
	}
}