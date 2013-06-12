package projects.thinkle_cake_drag.screens
{
	import com.facebook.graph.Facebook;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import projects.shared.utils.data.JSONRead;
	import jeka.LoadImage;
	import jeka.Rez;
	import projects.shared.screens.AbstractScreen;
	import projects.shared.utils.display.ClearChildren;
	import projects.shared.utils.display.ItemsGrid;
	
	import projects.thinkle_cake_drag.data.Parameters;
	import projects.shared.pop_ups.events.PopUpEvent;
	import projects.thinkle_cake_drag.pop_ups.LargeImagePopUp;
	
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.user_interface.Button;
	/**
	 * ...
	 * @author trayko
	 */
	public class Gallery extends AbstractScreen
	{
		private const ITEMS_PER_ROW			:int = 4;
		private const ITEMS_PER_COL			:int = 2;
		private const PHOTOS_PER_PAGE		:int = ITEMS_PER_ROW * ITEMS_PER_COL;
		
		private var _thumb_infos			:Array;
		
		private var _json_read				:JSONRead;
		private var _json_data				:Array;
		
		private var _thumbnails_holder		:Sprite;
		
		private var _page_id				:int = 0;
		private var _maximum_pages_allowed	:int;
		
		private var _large_image_pop_up		:LargeImagePopUp;
		private var _large_image_thumbnail	:MovieClip;
		private var _grid					:ItemsGrid;
		
		
		public function Gallery() : void
		{
			_json_read = new JSONRead(Parameters.GALLERY_PHOTOS_URL, onJsonLoaded);
			
			Button.initializeButton(_graphic.back_button, onBackButton, null, null, 'Върни се обратно!', true);
		}
		
		private function onBackButton(e:MouseEvent):void
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN));
		}
		
		private function onJsonLoaded():void
		{
			initialize();
		}
		
		private function initialize() : void
		{
			_json_data = _json_read.o as Array;
			if ( !_json_data )
				return;
				
				
			initializeGallery();
			showThumbnails();
			
			Button.initializeButton(_graphic.button_arrow_left, arrowClickHandler, arrowOverHandler, arrowOutHandler);
			Button.initializeButton(_graphic.button_arrow_right, arrowClickHandler, arrowOverHandler, arrowOutHandler);
		}
		
		private function initializeGallery():void
		{
			_thumbnails_holder = new Sprite();
			_graphic.addChild(_thumbnails_holder);
			
			_maximum_pages_allowed = Math.ceil(_json_data.length / PHOTOS_PER_PAGE);
		}
		
		private function showThumbnails():void
		{
			clearPrevious();
			
			_grid = new ItemsGrid('thumbnail_', ITEMS_PER_ROW, ITEMS_PER_COL, 155, 241, _thumbnails_holder, onThumbnailCreated, 116, 152, ItemsGrid.GRID_BY_NAME);
		}
		
		private function onThumbnailCreated(thumbnail_:Sprite, id_:int):void 
		{
			var init_data:int = _page_id * PHOTOS_PER_PAGE;
			var info:Object = _json_data[init_data + id_];
			
			if ( !info )
				return;
			
			var load_image:LoadImage = new LoadImage(info.photo_url, imageLoadedHandler);
			load_image.name = 'image_' + String(id_);
			load_image.buttonMode = true;
			load_image.mouseChildren = false;
			
			Button.initializeButton(load_image, thumbnailClickHandler);
			
			thumbnail_.addChild(load_image);
			
			_thumb_infos[init_data + id_] = thumbnail_;
		}
		
		private function clearPrevious():void 
		{
			if ( _grid )
				_grid.dispose();
			
			ClearChildren.clear(_thumbnails_holder);
			_thumb_infos = [];
		}
		
		private function imageLoadedHandler(complete_event_:Event) : void
		{
			var img:Bitmap = Bitmap(complete_event_.target.content);
			
			img.smoothing = true;
			
			var maximum_width	:int = 117;
			var maximum_height	:int = 171;
			
			if ( img.width > maximum_width || img.height > maximum_height )
			{
				new Rez().rezoWidth(img, maximum_width);
				
				if ( img.height > maximum_height )
					new Rez().rezoHeight(img, maximum_height);
			}
			
			var thumbnail:DisplayObjectContainer = img.parent.parent.parent as DisplayObjectContainer;
			TweenMax.from(thumbnail, Math.random() * .3 + .05, { alpha: 0, y: thumbnail.y + 25 } );
			
			img.x = ( maximum_width - img.width >> 1 );
			img.y = ( maximum_height - img.height >> 1 );
		}
		
		private function thumbnailClickHandler(e:MouseEvent):void
		{
			var load_image:LoadImage = e.target as LoadImage;
			_large_image_thumbnail = load_image.parent.getChildByName('thumbnail_background') as MovieClip
			showLargeImage(_thumb_infos.indexOf(e.target.parent), new Bitmap(Bitmap(load_image.loader.contentLoaderInfo.content).bitmapData, PixelSnapping.AUTO, true));
		}
		
		private function showLargeImage(id_:int, bitmap_:Bitmap = null, image_url_:String = null) : void
		{
			TweenMax.allTo([ _thumbnails_holder, _graphic.back_button ], .3, { autoAlpha: 0 } );
			_large_image_pop_up = new LargeImagePopUp(pop_up_image, bitmap_, _json_data, id_, image_url_ );
			
			_large_image_pop_up.addEventListener(PopUpEvent.CLOSE, closeLargeImagePopUp);
			_large_image_pop_up.addEventListener(PopUpEvent.ANIMATE_OUT, onlargeImagePopUpAnimateOut);
			
			addChild(_large_image_pop_up);
		}
		
		private function onlargeImagePopUpAnimateOut(e:PopUpEvent):void 
		{
			TweenMax.allTo([ _thumbnails_holder, _graphic.back_button ], .3, { autoAlpha: 1 } );
		}
		
		private function closeLargeImagePopUp(e:PopUpEvent):void
		{
			if ( _large_image_pop_up )
			{
				_large_image_pop_up.removeEventListener(PopUpEvent.ANIMATE_OUT, onlargeImagePopUpAnimateOut);
				_large_image_pop_up.removeEventListener(PopUpEvent.CLOSE, closeLargeImagePopUp);
				
				_large_image_pop_up.dispose();
				
				if ( _large_image_pop_up.parent )
					_large_image_pop_up.parent.removeChild(_large_image_pop_up);
					
				_large_image_pop_up = null;
			}
		}
		
		private function arrowClickHandler(e:MouseEvent) : void
		{
			if ( e.target.name == 'button_arrow_right' )
			{
				_page_id++;
			} else {
				_page_id--;
			}
			
			if ( _page_id > -1 && _page_id < _maximum_pages_allowed )
			{
				showThumbnails();
			} else if ( _page_id < 0 ) {
				_page_id = 0;
			} else {
				_page_id = _maximum_pages_allowed - 1;
			}
		}
		
		private function arrowOverHandler(e:MouseEvent) : void
		{
			MovieClip(e.target).gotoAndStop('HOVER');
		}
		
		private function arrowOutHandler(e:MouseEvent):void
		{
			MovieClip(e.target).gotoAndStop('IDLE');
		}
	}
}