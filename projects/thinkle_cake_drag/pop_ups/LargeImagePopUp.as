package projects.thinkle_cake_drag.pop_ups
{
	import projects.thinkle_cake_drag.data.Parameters
	import projects.shared.utils.photo_upload.UserPhotoBitmapData
	import com.facebook.graph.Facebook;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import jeka.LoadImage;
	import jeka.Rez;
	import projects.shared.pop_ups.AbstractPopUp;
	import projects.shared.pop_ups.events.PopUpEvent;
	import projects.shared.utils.user_interface.Button;
	/**
	 * Pop up used for displayig larger images
	 * @author trayko
	 */
	public class LargeImagePopUp extends AbstractPopUp
	{
		
		private var _image			:Bitmap;
		private var _photos_info	:Array;
		private var _photo_id		:int;
		
		public function LargeImagePopUp(graphics_class_:Class, image_:Bitmap = null, photos_info_:Array = null, id_:int = 0, image_url_:String = null) : void
		{
			super(graphics_class_);
			
			_photos_info	= photos_info_;
			_photo_id		= id_;
			_image			= image_;
			
			Button.initializeButton(_graphic.getChildByName('button_close') as Sprite		, closeHandler);
			Button.initializeButton(_graphic.getChildByName('button_arrow_left') as Sprite	, arrowClickHandler);
			Button.initializeButton(_graphic.getChildByName('button_arrow_right') as Sprite	, arrowClickHandler);
			
			if ( image_ )
				addImage();
			else if ( image_url_ )
				loadImage(image_url_);
		}
		
		private function arrowClickHandler(e:MouseEvent) : void
		{
			if ( e.target.name == 'button_arrow_right' )
			{
				_photo_id++;
			} else {
				_photo_id--;
			}
			
			if ( _photo_id > -1 && _photo_id < _photos_info.length )
			{
				_graphic.image_box.removeChildAt(_graphic.image_box.num_children - 1)
				loadImage(_photos_info[_photo_id].photo_url);
			} else if ( _photo_id < 0 ) {
				_photo_id = 0;
			} else {
				_photo_id = _photos_info.length - 1;
			}
		}
		
		private function loadImage(image_url_:String):void
		{
			var load_image:LoadImage = new LoadImage(image_url_, imageLoadedHandler);
		}
		
		private function imageLoadedHandler(e:Event):void 
		{
			_image = Bitmap(e.target.content);
			addImage();
			_image.alpha = 0;
			TweenMax.to(_image, .3, { alpha: 1 } );
		}
		
		protected function addImage():void 
		{
			if ( _image )
			{
				_image.scaleX = 1;
				_image.scaleY = 1;
				
				if ( _image.width > UserPhotoBitmapData.MAX_WIDTH || _image.height > UserPhotoBitmapData.MAX_HEIGHT )
				{
					new Rez().rezoWidth(_image, UserPhotoBitmapData.MAX_WIDTH);
					if ( _image.height > UserPhotoBitmapData.MAX_HEIGHT )
						new Rez().rezoHeight(_image, UserPhotoBitmapData.MAX_HEIGHT);
				}
				
				_image.x = UserPhotoBitmapData.MAX_WIDTH - _image.width  >> 1;
				_image.y = UserPhotoBitmapData.MAX_HEIGHT - _image.height >> 1;
				
				if ( _graphic )
					Sprite(_graphic.getChildByName('image_box')).addChild(_image);
			} else {
				trace('No image data provided!!!');
			}
		}
		
		private function closeHandler(e:MouseEvent):void 
		{
			_graphic.button_arrow_left.visible = _graphic.button_arrow_right.visible = false;
			animateOut();
		}
		
		override public function animateOutHandler():void 
		{
			dispatchEvent(new PopUpEvent(PopUpEvent.CLOSE));
		}
	}
}