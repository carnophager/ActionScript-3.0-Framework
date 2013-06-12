package projects.shared.utils.net 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.*;
	/**
	 * Simple post request utility
	 * @author trayko
	 */
	public class PostRequest extends EventDispatcher
	{
		private var _callback:Function;
		
		public function PostRequest(url_:String, variables_:Object, callback_:Function ) : void
		{
			var url_request:URLRequest = new URLRequest(url_);
			url_request.method = URLRequestMethod.POST;
			
			var url_variables:URLVariables = new URLVariables();
			
			for (var name:String in variables_) 
			{
				url_variables[name] = variables_[name];
			}
			
			url_request.data = url_variables;
			
			var url_loader:URLLoader = new URLLoader();
			url_loader.addEventListener(Event.COMPLETE, onInfoSent);
			
			_callback = callback_;
			
			url_loader.load(url_request);
		}
		
		private function onInfoSent(e:Event):void 
		{
			_callback.apply(this, [ e.target.data ]);
		}
		
	}
}