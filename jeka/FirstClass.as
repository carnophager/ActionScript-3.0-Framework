package jeka {
	public class FirstClass {
		public var newProperty:String = 'oppa';
		private var newerProperty:String = 'aidee';
		
		public function FirstClass(push:String):void
		{
			trace(this.newerProperty);
			this.newProperty = push;
		}
		
		public function buhal(buuu:String):void
		{
			trace(buuu);
		}
	}
}