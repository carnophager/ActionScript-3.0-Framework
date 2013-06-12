package jeka
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.events.*;
	import com.adobe.serialization.json.JSON;
	
	public class JSONRead extends MovieClip
	{
		private  var loader:URLLoader = new URLLoader();
		private var _o:Object, func:Function = new Function();
		
		function JSONRead(src:String, func:Function = null):void
		{
			this.func = func;
			loader.load(new URLRequest(src));
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
	}
}	