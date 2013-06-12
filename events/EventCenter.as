package events 
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class EventCenter 
	{
		protected static var disp:EventDispatcher;
		public static var o:Object;
		
		public static function addEventListener(p_type:String, p_listener:Function, customParameters:Object = null, p_useCapture:Boolean = false, p_priority:int = 0,  p_useWeakReference:Boolean = false):void 
		{
			if (disp == null) { disp = new EventDispatcher(); }
			if (o == null) {o = new Object(); }
			o.p_type = customParameters;			
			disp.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
		}
		
		public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean = false):void
		{
			if (disp == null) { return; }
			disp.removeEventListener(p_type, p_listener, p_useCapture);
		}
		
		public static function dispatchEvent(p_event:Event, customParameters:Object = null):void
		{
			if (disp == null) { return; }
			if (o == null) { o = new Object(); }
			o[p_event.type] = customParameters;
			disp.dispatchEvent(p_event);
		}
		
  		// Public API that dispatches an event
  		public static function loadSomeData():void {
   			dispatchEvent(new Event(Event.COMPLETE));
   		}
	}
	
}

//Yeah, screw singleton