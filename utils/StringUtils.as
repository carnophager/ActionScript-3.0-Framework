package utils
{
	public class StringUtils
	{
		public static function firstLetterToUpperCase ( str : String ) : String
		{
			return str.charAt( 0 ).toUpperCase() + str.substr( 1 ).toLowerCase();
		}
		
		public static function stripHTML( str:String ) : String
		{
			return str.replace(/<[^>]*>/gi, "");
		}
	}
}