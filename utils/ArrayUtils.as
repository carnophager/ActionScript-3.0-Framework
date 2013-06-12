package utils
{
	public class ArrayUtils
	{
		private static var prop:*;
		private static var elmnt:*;
		
		public static function extract(array:Array, property:Object) : Object
		{
			elmnt = null;
			prop = property;
			array.forEach(findProperty);
			return elmnt;
		}
		
		private static function findProperty(element:*, index:int, arr:Array) : void
		{
			for (var i:String in element) 
			{
				if ( element[i] == prop )
				{
					elmnt = element;
					return;
				}
			}
		}
	}
}