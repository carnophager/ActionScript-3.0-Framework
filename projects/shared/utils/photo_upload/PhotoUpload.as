package projects.shared.utils.photo_upload
{
	import flash.net.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	
	import com.adobe.images.*;
	import com.greensock.*
	import jeka.*;
	
	import projects.shared.data.ParametersBase;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.user_interface.Button;
	import projects.shared.utils.photo_upload.UploadPostHelper
	import projects.shared.utils.photo_upload.UserPhotoBitmapData;
	
	/**
	 * @author trayko
	 */
	public class PhotoUpload extends EventDispatcher
	{
		protected var _graphics				:MovieClip;
		
		protected var _photo					:MovieClip;
		protected var _photo_uploaded			:Boolean;
		protected var _image_name				:String;
		
		public function PhotoUpload() : void
		{
			
		}
		
		public function uploadPhoto(id_:int) : void
		{
			//UPLOAD TO SERVER
			var encoder:JPGEncoder = new JPGEncoder(100);
			var byte_array:ByteArray = encoder.encode(UserPhotoBitmapData.getData(id_));
			
			trace(UserPhotoBitmapData.getData(id_));
			
			var date:Date = new Date();
			_image_name = date.getMonth() + 1 + '' + date.getDate() + '' + date.getHours() + '' + date.getMinutes() + '' + date.getMilliseconds() + '.jpg';
			ParametersBase.server_image = ParametersBase.SERVER + 'uploadtest/output/' + _image_name;
			
			var url_request:URLRequest = new URLRequest(ParametersBase.SERVER + 'uploadtest/image.php?path=output/');
			url_request.contentType = 'multipart/form-data; boundary=' + UploadPostHelper.getBoundary();
			url_request.method = URLRequestMethod.POST;
			url_request.data = UploadPostHelper.getPostData( _image_name, byte_array );
			url_request.requestHeaders.push ( new URLRequestHeader( 'Cache-Control', 'no-cache' ) );
			
			var url_loader:URLLoader = new URLLoader();
			url_loader.dataFormat = URLLoaderDataFormat.BINARY;
			url_loader.addEventListener(Event.COMPLETE, imageUploadedHandler);
			url_loader.load( url_request);
		}
		
		protected function imageUploadedHandler(e:Event) : void
		{
			trace('image uploaded', URLLoader(e.target).data);
			_photo_uploaded = true;
			dispatchEvent(new ScreenEvent(ScreenEvent.PHOTO_SAVED));
		}
		
		public function get photo_uploaded():Boolean 
		{
			return _photo_uploaded;
		}
		
		public function get image_name():String 
		{
			return _image_name;
		}
		
		public function dispose() : void
		{
			//super.dispose();
		}
	}
}