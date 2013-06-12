package projects.thinkle_cake_drag.data 
{
	import projects.shared.data.ParametersBase;
	/**
	 * Parameters for the application
	 * 
	 * @author trayko
	 */
	public class Parameters extends ParametersBase
	{
		public static const REGISTRATION_VARIABLES	:Vector.<String> = Vector.<String>(['name', 'address', 'phone', 'email', 'kid_age']);
		public static var GALLERY_PHOTOS_URL		:String = SERVER;
		
		public static function overrideParameters() : void
		{
			APP_ID = '198524703605225';
			
			SERVER = 'https://top5.bg/fb/thinkle/birthday2/';
			REGISTRATION_URL = SERVER + 'post.php';
			GALLERY_PHOTOS_URL = SERVER + 'gallery.php';
			
			PLEASE_FILL = 'Моля, попълнете всички полета коректно!';
		}
		
	}

}