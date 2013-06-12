package projects.shared.utils.data
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	
	public class JSONRead extends MovieClip
	{
		private var loader:URLLoader = new URLLoader();
		private var _o:Object, func:Function = new Function();
		private var alt:String;
		
		public function JSONRead(src:String, func:Function = null, alt:String = null, variables:URLVariables = null) : void
		{
			this.func = func;
			this.alt = alt;
			if ( src == null ) src = alt;
			
			/*var xmlLoader:URLLoader = new URLLoader();
			var httpHeader : URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			var httpRequest : URLRequest = new URLRequest(xmlPath);
			httpRequest.requestHeaders.push(httpHeader);
			httpRequest.method = URLRequestMethod.GET;
			httpRequest.data = new URLVariables("time="+Number(new Date().getTime()))*/
			
			var req:URLRequest = new URLRequest(src);
			var req_headers:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			req.requestHeaders.push(req_headers);
			if ( !variables ) variables = new URLVariables();
			variables.nocache = new Date().getTime();
			req.data = variables;
			
			loader.load(req);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, readJSON);
		}
		
		private function readJSON(e:Event) : void
		{
			_o = JSON.parse(e.target.data);
			if(func != null)
				func();
		}		
		
		public function get o():Object
		{
			return _o;
		}
		
		public function set o(value:Object):void
		{
			_o = JSON.parse(value.toString());
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