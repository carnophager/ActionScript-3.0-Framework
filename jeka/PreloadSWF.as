package jeka  {
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	
	public class PreloadSWF extends Sprite {
		var _loader:Loader;
		var tf:TextField;
		var bar:DisplayObjectContainer;
		var symbol:String;
		var prog:Number;
		
		public function get loader():Loader
		{
			return _loader;
		}
		
		public function PreloadSWF(swf:String, tf:TextField = null, bar:DisplayObjectContainer = null, symbol:String = '%', customProgress:Function = null, customFinish:Function = null):void
		{
		 	this.tf = tf;
			this.bar = bar;
			this.symbol = symbol;
			_loader = new Loader();
			if (customProgress != null)
			{
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, customProgress);
			} else {
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			}
			if (customFinish != null)
			{
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, customFinish);
			} else {
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			}
			_loader.load(new URLRequest(swf));
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			prog = e.bytesLoaded / e.bytesTotal;
			if (tf != null)
			{
				tf.text = Math.ceil(prog * 100).toString() + symbol;
				tf.autoSize = TextFieldAutoSize.LEFT;
			}
			
			if (bar != null)
				bar.scaleX = prog;
		}
		
		private function onComplete(e:Event):void
		{
			for (var i:uint = 0; i < this.parent.numChildren; i++)
				this.parent.removeChildAt(0);
			addChild(_loader);
		}
		
		
	}
}