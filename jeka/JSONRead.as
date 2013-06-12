package jeka
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.events.*;
	import com.adobe.serialization.json.JSON;
	
	public class JSONRead extends MovieClip
	{
		private var loader:URLLoader = new URLLoader();
		private var _o:Object, func:Function = new Function();
		private var alt:String;
		
		public function JSONRead(src:String, func:Function = null, alt:String = null, variables:URLVariables = null):void
		{
			this.func = func;
			this.alt = alt;
			var req:URLRequest = new URLRequest(src);
			var header:URLRequestHeader = new URLRequestHeader('pragmat', 'no-cache');
			req.requestHeaders.push(header);
			req.method = URLRequestMethod.POST;
			req.data = variables;
			loader.load(req);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, readJSON);
		}
		
		private function readJSON(e:Event):void
		{
			_o = JSON.decode(e.target.data);
			if(func != null)
				func();
		}		
		
		public function get o():Object
		{
			return _o;
		}
		
		public function set o(value:Object):void
		{
			_o = JSON.decode(value.toString());
		}
		
		private function errorHandler(e:Event):void
		{
			loader.load(new URLRequest(alt));
			dispatchEvent(new Event('ERROR'));
		}
		
		public function kill() : void
		{
			try
			{
				loader.close();
			} catch (e:Error) {
				
			}
		}
	}
}	