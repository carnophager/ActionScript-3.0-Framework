package utils
{
	public class Slicer
	{
		public static function slice(num:Number, symbol:String = ' ') : String
		{
			var str:String = num.toString();
			var length:int = str.length;
			if ( length < 4 ) return str;
			var count:int = Math.floor(length / 3) + ( length % 3 == 0 ? 0 : 1 );
			var aug:int;
			
			for (var i:int = 1; i < count; i++)
			{
				aug = i * 3;
				str = str.slice(0, length - aug) + symbol + str.slice(length - aug);
			}
			
			return str;
		}
	}
}