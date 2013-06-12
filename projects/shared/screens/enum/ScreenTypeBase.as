package projects.shared.screens.enum 
{
	import flash.utils.getQualifiedClassName;
	import projects.shared.screens.AbstractScreen;
	/**
	 * @author trayko
	 */
	public class ScreenTypeBase
	{
		//STATIC
		//public static const FAN_INFO		:ScreenType = new ScreenType( FansInfo			, 0	, null);
		
		protected const INSTANTIATION_ERROR		:String = 'You cant instantiate ' + getQualifiedClassName(this) + ' it is Enumeration !!!';
		
		//INSTANCE
		protected var _type						:Class;
		protected var _id						:int;
		
		public function get type() : Class
		{
			return _type;
		}
		
		public function get id() : int
		{
			return _id;
		}
	}
}

class block_constructor {}