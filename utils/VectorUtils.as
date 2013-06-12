package utils
{
	/**
	 * @author trayko
	 */
	public class VectorUtils
	{
		public static function shuffleVector(vector_:Object) : void
		{
			var index		:int;
			var total_tems	:int = vector_.length;
			for ( index = 0; index < total_tems; index++)
				swapElements( vector_, index, index + int( Math.random() * (total_tems - index) ) );
		}
		
		public static function swapElements(vector_:Object, a_:uint, b_:uint) : void
		{
			var temp:Object = vector_[a_];
			vector_[a_]		= vector_[b_];
			vector_[b_]		= temp;
		}
	}
}