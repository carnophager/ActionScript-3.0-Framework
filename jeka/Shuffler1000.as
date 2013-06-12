package jeka
{
	public class Shuffler1000
	{
		public static function shuffle(a:Object, b:Object):int
		{
			return Math.round(Math.random() * 2) - 1;
		}
	}
}