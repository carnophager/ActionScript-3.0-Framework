package projects.shared.utils.photo_upload
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import projects.shared.utils.photo_upload.UserPhotoBitmapData;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.user_interface.Button;
	import jeka.Rez;
	
	public class CameraUpload extends EventDispatcher
	{
		protected var _graphics			:MovieClip;
		
		protected var _camera			:Camera;
		protected var _video			:Video;
		protected var _muted			:Boolean;
		protected var _photo_captured	:Boolean;
		protected var _id				:int;
		
		public function CameraUpload(graphics_:MovieClip, id_:int) : void
		{
			_graphics = graphics_;
			_id = id_;
			_graphics.visible = true;
			_photo_captured = false;
			
			Button.initializeButton(_graphics.ok_button, onOkButton);
		}
		
		public function initializeCamera() : void
		{
			_camera = Camera.getCamera();
			
			if ( _muted ) Security.showSettings(SecurityPanel.PRIVACY);
			
			if ( _camera )
			{
				_camera.setMode(237, 178, 25);
				_camera.addEventListener(StatusEvent.STATUS, statusHandler);
				connectCamera();
			}
		}
		
		protected function connectCamera() : void
		{
			_video = new Video(_camera.width, _camera.height);
			_video.x = _graphics.face.x;
			_video.y = _graphics.face.y + ( _graphics.face.height - _video.height ) / 2;
			_video.attachCamera(_camera);
			_graphics.addChild(_video);
			
			if ( !_camera.muted )
				changeElementsVisibility();
		}
		
		protected function statusHandler(e:StatusEvent) : void
		{
			if ( e.code == 'Camera.Unmuted' )
			{
				changeElementsVisibility();
				trace(_graphics.visible);
				_muted = false;
			} else if ( e.code == 'Camera.Muted' ) {
				_muted = true;
				stopVideo();
			}
		}
		
		protected function changeElementsVisibility():void
		{
			_graphics.face.visible = false;
			_graphics.visible = true;
			
			dispatchEvent(new Event('camera_working'));
		}
		
		protected function onOkButton(e:MouseEvent) : void
		{
			_graphics.ok_button.visible = false;
			takeVideoSnapshot();
		}
		
		public function takeVideoSnapshot() : void
		{
			var bitmap_data:BitmapData = new BitmapData(_graphics.face.width, _graphics.face.height, false, 0x000000);
			bitmap_data.draw(_video);
			var bitmap:Bitmap = new Bitmap(bitmap_data);
			
			UserPhotoBitmapData.writeData(bitmap_data, _id);
			UserPhotoBitmapData.width = bitmap_data.width
			UserPhotoBitmapData.height = bitmap_data.height
			
			bitmap.x = _video.x;
			bitmap.y = _video.y;
			_graphics.addChild(bitmap);
			
			stopVideo();
			
			dispatchEvent(new ScreenEvent(ScreenEvent.PHOTO_LOADED));
		}
		
		protected function stopVideo() : void
		{
			if ( _video )
			{
				_video.attachCamera(null);
				_graphics.removeChild(_video);
				_video = null;
				_camera = null;
				
				_graphics.face.visible = true;
				_photo_captured = true;
			}
		}
		
		public function get photo_captured():Boolean
		{
			return _photo_captured;
		}
	}
}