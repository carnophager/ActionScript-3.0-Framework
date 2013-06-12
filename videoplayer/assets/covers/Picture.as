package videoplayer.assets.covers
{
	import caurina.transitions.Tweener;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jeka.DrawMask;
	import jeka.Rez;
	import videoplayer.events.VideoStatusEvent;
	
	public class Picture extends Sprite
	{
		
		protected var __loader				:Loader;
		protected var __w					:Number;
		protected var __h					:Number;
		
		public function Picture(pictureURL:String, w:Number, h:Number)
		{
			__w = w;
			__h = h;
			__loader = new Loader();
			__loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			__loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			__loader.load(new URLRequest(pictureURL), context);
			addChild(__loader);
			__loader.alpha = 0;
			var mask:DrawMask = new DrawMask(0, 0, w, h, __loader, this);
		}
		
		public function show() : void
		{
			visible = true;
			TweenLite.to(this, 1, { alpha: 1, ease: Expo.easeOut} );
		}
		
		public function hide() : void
		{
			TweenLite.to(this, .3, { alpha: 0, ease: Expo.easeOut, onComplete: remove } );
		}
		
		public function remove() : void
		{
			visible = false;
		}
		
		protected function onComplete(e:Event) : void
		{
			if ( __loader.width > __w || __loader.width > __h )
			{
				if ( __loader.height > __loader.width )
				{
					new Rez().rezoHeight(__loader, __h);
				} else {
					new Rez().rezoWidth(__loader, __w);
				}
			}
			__loader.x = ( __w - __loader.width ) / 2;
			__loader.y = ( __h - __loader.height ) / 2;
			Bitmap(e.target.content).smoothing = true;
			TweenLite.to(__loader, 1, { alpha: 1, ease: Expo.easeOut } );
			dispatchEvent(new VideoStatusEvent(VideoStatusEvent.COVER_LOADED));
		}
		
		protected function onError(e:IOErrorEvent) : void
		{
			trace('ioError: ' + e);
		}
		
	}

}