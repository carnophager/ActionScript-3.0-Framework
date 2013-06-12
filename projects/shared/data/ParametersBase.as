package projects.shared.data 
{
	/**
	 * Various configurable parameters of the app
	 * 
	 * @author trayko
	 */
	public class ParametersBase
	{
		public static var SERVER					:String;
		public static var REGISTRATION_URL			:String;
		
		static public var APP_ID					:String;
		public static var APP_NAME					:String;
		public static var APP_URL					:String = 'https://www.facebook.com/' + APP_NAME + 'zitleapps/app_' + APP_ID;
		
		//Server errors
		static public var ERROR_MAIL				:String = 'Моля, въведете коректен e-mail адрес!';
		static public var EMAIL_IN_USE				:String = 'Въведеният e-mail адрес, вече е използван!';
		static public var PHONE_IN_USE				:String = 'Този телефон вече е използван!';
		static public var CHECK_TERMS				:String = 'Моля, съгласете се с общите условия!';
		
		//Client errors
		public static var PLEASE_FILL				:String = 'Моля, попълнете непопълнените полета!';
		static public var CHOOSE_PHOTO				:String = 'Моля, качете снимка на вашето дете!';
		
		//Application variables
		public static var server_image				:String;
	}
}