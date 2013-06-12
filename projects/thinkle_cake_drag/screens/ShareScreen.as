package projects.thinkle_cake_drag.screens 
{
	import com.adobe.images.JPGEncoder;
	import com.facebook.graph.Facebook;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import projects.shared.data.ParametersBase;
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.photo_upload.DownloadImage;
	import projects.shared.utils.photo_upload.UserPhotoBitmapData;
	import projects.shared.utils.user_interface.Button;
	/**
	 * Screen for sharing card photo
	 * @author trayko
	 */
	public class ShareScreen extends AbstractScreen
	{
		
		public function ShareScreen() 
		{
			var card_bitmap:Bitmap = new Bitmap(UserPhotoBitmapData.getData(0));
			card_bitmap.x = 12;
			card_bitmap.y = 12;
			addChild(card_bitmap);
			
			Button.initializeButton(_graphic.button_download	, onButtonDownload, null, null, 'Свали на компютъра');
			Button.initializeButton(_graphic.button_share		, onButtonShare, null, null, 'Сподели');
			Button.initializeButton(_graphic.button_gallery		, onButtonGallery, onButtonGalleryOver, onButtonGalleryOut, 'Виж всички картички');
		}
		
		private function onButtonDownload(e:MouseEvent):void 
		{
			DownloadImage.download(UserPhotoBitmapData.getData(0), 'thinkle_birthday_card.jpg');
		}
		
		private function onButtonShare(e:MouseEvent):void 
		{
			Facebook.ui('feed', { 
				link: 'http://www.facebook.com/top5.bg/app_198524703605225',
				message: 'Аз участвах в играта с колажи на Thinkle Stars!',
				picture: ParametersBase.server_image,
				name: 'Готови ли сте за училище?',
				caption: 'www.fb.com/thinklestars',
				description: 'Играй и можеш да спечелиш образователна играчка за детето си.'
			}, linkShared);
		}
		
		private static function linkShared(result:Object) : void
		{
			trace('link shared', result, JSON.stringify(result));
		}
		
		private function onButtonGallery(e:MouseEvent):void 
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN));
		}
		
		private function onButtonGalleryOver(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { alpha: .8 } );
		}
		
		private function onButtonGalleryOut(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .3, { alpha: 1 } );
		}
		
	}

}