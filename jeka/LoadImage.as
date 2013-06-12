package jeka
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	public class LoadImage extends Sprite
	{
		private var _loader:Loader;
		private var _imageURL:String;
		private var request:URLRequest;
		private var tf:String, goche:String;
		private var fixed:Number;
		private var mid:Boolean = true;
		private var smoothing:Boolean;
		public var percents:Number;
		public var w:Number;
		public var h:Number;
		public var id:int;
		
		public function LoadImage(pic:String, fun:Function = null, mid:Boolean = false, smoothing:Boolean = true, bushanki:String = 'tf', symbol:String = '%', fix:Number = 1) : void
		{
			_loader = new Loader();
			this.smoothing = smoothing;
			configureListeners(_loader.contentLoaderInfo);
			request = new URLRequest(pic);
			addChild(_loader);
			tf = bushanki;
			goche = symbol;
			fixed = fix;
			_imageURL = pic;
			if(fun != null)
			{
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fun);
			} else {
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			}
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, urlNotFoundHandler);
			this.mid = mid;
			
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			_loader.load(request, context);
		}
		
		private function urlNotFoundHandler(e:IOErrorEvent) : void
		{
			trace('Image url not found:' + _imageURL);
			//throw new Error('Image url not found:' + _imageURL);
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function completeHandler(evt:Event):void
		{
			var img:Bitmap = Bitmap(evt.target.content);
			img.smoothing = smoothing;
			if (mid)
			{
				img.x -= img.width / 2;
				img.y -= img.height / 2;
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function progressHandler(evt:ProgressEvent):void
		{
			percents = evt.bytesLoaded / evt.bytesTotal;
			var benks:String = (percents * 100).toFixed(fixed);
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			//this.parent[tf].text = benks + goche;
		}
		
		public function close() : void 
		{
			_loader.close();
		}
		
		public function get loader():Loader
		{
			return _loader;
		}
	}
}