package projects.shared.facebook 
{
	import com.facebook.graph.Facebook;
	import flash.events.EventDispatcher;
	import flash.system.Security;
	import projects.shared.data.ParametersBase;
	/**
	 * Data and methods for working with facebook
	 * @author trayko
	 */
	public class FacebookDataBase extends EventDispatcher
	{
		static private var _login_callback						:Function;
		static private var _permissions_callback				:Function;
		static private var _check_permissions_soft_callback		:Function;
		
		public function FacebookDataBase() : void
		{
			initializeFacebook();
			initializePolicies();
		}
		
		protected function initializeFacebook():void 
		{
			Facebook.init(ParametersBase.APP_ID, onFacebookInit);
		}
		
		protected function onFacebookInit(result:Object, fail:Object):void
		{
			trace('init');
			
			if (result) //already logged in because of existing session
			{
				trace('already logged in');
			} else {
				trace('not logged in');
			}
		}
		
		public static function logIn(callback_:Function = null) : void
		{
			_login_callback = callback_;
			Facebook.login(handleLogin, { scope: 'publish_stream, user_photos' } );
		}
		
		private static function handleLogin(result:Object, fail:Object ) : void
		{
			trace('result: ' + JSON.stringify(result), 'fail: ' + JSON.stringify(fail));
			
			if ( fail )
				return;
			
			if ( Boolean(_login_callback) )
				_login_callback(Boolean(result));
		}
		
		public static function checkPermissions(callback_:Function = null) : void
		{
			_permissions_callback = callback_;
			Facebook.api('me/permissions', permissionsCallback);
		}
		
		protected static function permissionsCallback(result:Object, fail:Object) : void
		{
			if ( fail )
			{
				trace('no permissions', JSON.stringify(fail));
				_permissions_callback( false );
				return;
			}
			
			trace('permissions:', JSON.stringify(result));
			
			var permissions:Object = (result as Array)[0][0];
 			_permissions_callback( permissions.publish_stream );
		}
		
		protected function initializePolicies():void 
		{
			Security.loadPolicyFile('http://profile.ak.fbcdn.net/crossdomain.xml');
		}
		
	}

}