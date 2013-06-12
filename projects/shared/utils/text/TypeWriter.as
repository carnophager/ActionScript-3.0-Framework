package projects.shared.utils.text 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author trayko
	 */
	public class TypeWriter extends EventDispatcher
	{
		public static const DONE_EVENT	:String = 'DONE';
		
		private var _text_field			:TextField;
		private var _text				:String;
		private var _timer				:Timer;
		
		/**
		 * Static method for creating typewriting effect on text field.
		 
		 * @param	text_field_ Text Field object that will be filled with typewritten text.
		 * @param	text_ Text string to typewrite.
		 * @param	speed_ Typerwiting speed in miliseconds.
		 */
		public function TypeWriter(text_field_:TextField, text_:String, speed_:int = 30) : void
		{
			_text_field = text_field_;
			_text = text_;
			
			_text_field.text = '';
			
			_timer = new Timer(speed_, _text.length);
			_timer.addEventListener(TimerEvent.TIMER			, onTimerTick);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE	, onTimerComplete);
			
			_timer.start();
		}
		
		public function pause() : void
		{
			_timer.stop();
		}
		
		public function resume() : void
		{
			_timer.start();
		}
		
		private function onTimerTick(e:TimerEvent):void 
		{
			_text_field.appendText(_text.charAt(_timer.currentCount - 1));
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			dispose();
			
			dispatchEvent(new Event(DONE_EVENT));
		}
		
		public function dispose() : void
		{
			if ( _timer )
			{
				_timer.removeEventListener(TimerEvent.TIMER				, onTimerTick);
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE	, onTimerComplete);
				
				_timer = null;
			}
		}
		
	}

}