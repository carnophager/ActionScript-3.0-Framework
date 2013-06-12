package utils
{
	import flash.utils.Timer;
	
	public class DataTimer extends Timer
	{
		private var __data				:Object;
		
		public function DataTimer(delay:Number, repeatCount:int = 0) : void 
		{
			super(delay, repeatCount);
			__data = { };
		}
		
		public function get data() : Object
		{
			return __data;
		}
		
		public function set data(value:Object) : void 
		{
			__data = data;
		}
	}
}