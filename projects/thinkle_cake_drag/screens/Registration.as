package projects.thinkle_cake_drag.screens 
{
	import com.facebook.graph.Facebook;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequestMethod;
	import projects.shared.data.ParametersBase;
	import projects.shared.facebook.FacebookDataBase;
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.photo_upload.PhotoUpload;
	import projects.shared.utils.photo_upload.UserPhotoBitmapData;
	import projects.shared.utils.user_interface.Button;
	import projects.shared.utils.user_interface.SimpleCheckbox;
	import projects.thinkle_cake_drag.data.Parameters;
	import projects.shared.utils.data.Registration;
	/**
	 * Registration screen

	 * @author trayko
	 */
	public class Registration extends AbstractScreen
	{
		private var _registration	:projects.shared.utils.data.Registration;
		private var _photo_upload	:PhotoUpload;
		
		public function Registration() : void
		{
			SimpleCheckbox.initialize(_graphic.button_terms);
			Button.initializeButton(_graphic.register_button	, onRegisterButton, null, null, 'Регистрирай!');
			Button.initializeButton(_graphic.share_button	, onShareButton);
			
			_graphic.share_button.visible = false;
			
			var bitmap:Bitmap = new Bitmap(UserPhotoBitmapData.getData(0));
			bitmap.x = 12;
			bitmap.y = 12;
			_graphic.addChild(bitmap);
			
			_photo_upload = new PhotoUpload();
			_photo_upload.addEventListener(ScreenEvent.PHOTO_SAVED, onPhotoLoaded);
			
			_registration = new projects.shared.utils.data.Registration(ParametersBase.REGISTRATION_URL);
			
			_registration.addField(_graphic.input_name		, projects.shared.utils.data.Registration.INPUT_TEXT, Parameters.REGISTRATION_VARIABLES[0], true);
			_registration.addField(_graphic.input_address	, projects.shared.utils.data.Registration.INPUT_TEXT, Parameters.REGISTRATION_VARIABLES[1], true);
			_registration.addField(_graphic.input_phone		, projects.shared.utils.data.Registration.INPUT_TEXT, Parameters.REGISTRATION_VARIABLES[2], true);
			_registration.addField(_graphic.input_mail		, projects.shared.utils.data.Registration.INPUT_TEXT, Parameters.REGISTRATION_VARIABLES[3], true);
			_registration.addField(_graphic.input_age		, projects.shared.utils.data.Registration.INPUT_TEXT, Parameters.REGISTRATION_VARIABLES[4], true);
			
			_registration.addCheckboxGroup('terms', Vector.<Object>([ { checkbox: _graphic.button_terms, id: 'terms' } ]), true);
			
			_registration.addEventListener(projects.shared.utils.data.Registration.UNFILLED_DATA_EVENT	, onUnfilledData);
			_registration.addEventListener(projects.shared.utils.data.Registration.INFO_SENT_EVENT		, onInfoSent);
		}
		
		private function onRegisterButton(e:MouseEvent):void
		{
			//submitRegistration();
			//FacebookDataBase.logIn(onLogin);
			
			if ( !_photo_upload.photo_uploaded )
			{
				trace('upload photo');
				_photo_upload.uploadPhoto(0);
				_registration.addData('photo_url', ParametersBase.server_image);
			} else {
				Facebook.api('me/permissions', checkPermissions);
			}
		}
		
		private function onPhotoLoaded(e:ScreenEvent):void 
		{
			trace('on photo uploaded');
			Facebook.api('me/permissions', checkPermissions);
		}
		
		private function checkPermissions(result:Object, fail:Object) : void
		{
			if ( fail )
			{
				logIn();
				return;
			}
			
			var permissions:Object = Array(result)[0][0];
			//trace('permissions', JSON.encode(permissions));
			if ( !permissions.publish_stream )
				logIn();
			else
				submitRegistration();
		}
		
		private function logIn() : void
		{
			Facebook.login(handleLogin, { scope: 'publish_stream, user_photos' } );
		}
		
		private function handleLogin(result:Object, fail:Object ) : void
		{
			//trace('login response', JSON.encode(result_), JSON.encode(fail_), result_, fail_);
			trace(result, fail);
			
			Facebook.api('me/permissions', checkPermissionsSoft);
		}
		
		private function checkPermissionsSoft(result:Object, fail:Object) : void
		{
			if ( fail ) return;
			
			var permissions:Object = Array(result)[0][0];
			if ( !permissions.publish_stream )
				return
				
			submitRegistration();
		}
		
		private function onShareButton(e:MouseEvent):void 
		{
			_graphic.share_button.alpha = .5;
			_graphic.share_button.mouseEnabled = false;
			_graphic.share_button.mouseChildren = false;
			_graphic.share_button.gotoAndStop(2);
			
			uploadPhotoToFacebook();
		}
		
		private function uploadPhotoToFacebook():void 
		{
			Facebook.api('/me/photos', handlePhotoUploaded, { meessage: 'Thinkle Stars става на 2г.!', source: new Bitmap(UserPhotoBitmapData.getData(0)), fileName: 'FILE_NAME' }, URLRequestMethod.POST);
		}
		
		private function handlePhotoUploaded(result:Object, fail:Object) : void
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN));
			trace('photo uploaded', JSON.stringify(result), JSON.stringify(fail));
		}
		
		private function submitRegistration() : void
		{
			_registration.submitRegistration();
		}
		
		private function onInfoSent(e:Event):void 
		{
			var result:String = _registration.url_loader.data
			trace(result);
			
			clearPreviousErrors();
			
			if ( result.indexOf('SUCCESS') != -1 )
			{
				_graphic.register_button.visible = false;
				_graphic.share_button.visible = true;
				//uploadPhotoToFacebook();
			} else if ( result.indexOf('ERROR_MAIL') != -1) {
				showErrorMessage(ParametersBase.ERROR_MAIL);
			} else if ( result.indexOf('EMAIL_IN_USE') != -1 ) {
				showErrorMessage(ParametersBase.EMAIL_IN_USE);
			} else if ( result.indexOf('PHONE_IN_USE') != -1 ) {
				showErrorMessage(ParametersBase.PHONE_IN_USE);
			}
		}
		
		private function onUnfilledData(e:Event):void 
		{
			clearPreviousErrors();
			
			showErrorMessage(ParametersBase.PLEASE_FILL);
			
			if ( _registration.unchecked_mandatory_checkboxes.length && !_registration.unfilled_mandatory_fields.length )
				_graphic.checkbox_error.alpha = 1;
		}
		
		private function showErrorMessage(error_:String):void 
		{
			_graphic.error_field.status_field.text = error_;
		}
		
		private function clearPreviousErrors():void 
		{
			showErrorMessage('');
			_graphic.checkbox_error.alpha = 0;
		}
		
		
	}

}