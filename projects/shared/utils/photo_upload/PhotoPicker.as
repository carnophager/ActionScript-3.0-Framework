package projects.shared.utils.photo_upload
{
	import flash.net.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.display.*;
	
	import com.greensock.*
	import com.facebook.graph.Facebook;
	
	import jeka.*;
	
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.data.UserPhotoBitmapData;
	
	
	/**
	 * @author trayko
	 */
	public class PhotoPicker extends EventDispatcher
	{
		protected var _graphic						:DisplayObjectContainer;
		protected var _id							:int;
		
		protected var _file_reference				:FileReference;
		protected var _photo_chosen					:Boolean;
		protected var _loader						:Loader;
		
		public function PhotoPicker(graphic_:DisplayObjectContainer, id_:int) : void
		{
			_graphic = graphic_;
			_id = id_;
		}
		
		public function onUploadButton() : void
		{
			createFileReference();
			_file_reference.browse([new FileFilter("Images", "*.jpg;*.jpeg;*.gif;*.png")]);
		}
		
		protected function createFileReference() : void
		{
			if ( _file_reference  ) return;
			
			_file_reference = new FileReference();
			_file_reference.addEventListener(Event.SELECT	, imageSelectedHandler);
			_file_reference.addEventListener(Event.COMPLETE	, onImageLoaded);
		}
		
		protected function imageSelectedHandler(e:Event) : void
		{
			_file_reference.load();
		}
		
		protected function onImageLoaded(e:Event) : void
		{
			if ( _loader )
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderComplete);
				
				if ( _loader.parent )
					_loader.parent.removeChild(_loader);
				_loader = null;
			}
			
			_loader = new Loader();
			
			_loader.loadBytes(e.target.data);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		
		protected function loaderComplete(e:Event) : void
		{
			createUserPhoto(LoaderInfo(e.target).loader);
			_photo_chosen = true;
			
			dispatchEvent(new ScreenEvent(ScreenEvent.PHOTO_LOADED));
		}
		
		protected function createUserPhoto(loader_:Loader) : void
		{
			var bitmap:Bitmap = loader_.content as Bitmap;
			bitmap.smoothing = true;
			
			var resizer:Rez = new Rez();
			resizer.rezoWidth(loader_, UserPhotoBitmapData.MAX_WIDTH);
			if ( loader_.height > UserPhotoBitmapData.MAX_HEIGHT)
				resizer.rezoHeight(loader_, UserPhotoBitmapData.MAX_HEIGHT);
			
			bitmap.width = loader_.width;
			bitmap.height = loader_.height;
			bitmap.x = UserPhotoBitmapData.MAX_WIDTH - bitmap.width >> 1;
			bitmap.y = UserPhotoBitmapData.MAX_HEIGHT - bitmap.height >> 1;
			
			if ( _graphic.numChildren )
				_graphic.removeChildAt(0);
			_graphic.addChild(bitmap);
			
			
			UserPhotoBitmapData.writeData(bitmap.bitmapData, _id);
			UserPhotoBitmapData.width = loader_.width;
			UserPhotoBitmapData.height = loader_.height;
		}
		
		public function get photo_chosen():Boolean 
		{
			return _photo_chosen;
		}
	}
}