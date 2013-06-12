package utils
{
	public class Clone
	{
		public static function object(obj:Object) : Object
		{
			var o:Object = new Object();
			
			for (var i:String in obj) 
			{
				o[i] = obj[i];
			}
			return o;
		}
	}
}