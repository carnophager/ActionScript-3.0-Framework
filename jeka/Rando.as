//carnophage ©2008
package jeka
{
	public class Rando
	{
		public static function rando(min:Number = 0, max:Number = 9, rounded:Boolean = false):Number
		{
			if (rounded)
			{
				return (Math.round((Math.random() * (max-min)) + min));
			}
			return ((Math.random() * (max-min)) + min);
		}
	}
}