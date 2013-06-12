package projects.dojo_card
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	import com.greensock.*;
	
	import jeka.*;
	import carn.*;
	
	import projects.shared.utils.display.*;
	/**
	 * Used to preload card content
	 * @author trayko
	 */
	public class Preloader extends Sprite
	{
		protected const PIECES					:int = 17;
		
		protected var _content_url_request		:URLRequest;
		protected var _loader					:Loader;
		protected var _resizer					:Rez;
		protected var _background				:Bmp;
		
		public function Preloader() : void
		{
			_content_url_request = new URLRequest('card.swf');
			_resizer = new Rez();
			
			_loader = new Loader();
			
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS	, onProgress);
			_loader.contentLoaderInfo.addEventListener(Event.INIT				, onLoaded	);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR	, onIOError );
			
			addChild(_loader);
			
			_graphics.question.yes.addEventListener(MouseEvent.CLICK, onButtonClick);
			_graphics.question.no.addEventListener(MouseEvent.CLICK, onButtonClick);
			
			_graphics.tetris.visible = false;
			_graphics.labels.visible = false;
			
			initializeBackground();
			
			var stage_monitor:StageMonitor = new StageMonitor(stage);
			stage_monitor.addEventListener(StageMonitor.STAGE_RESIZE_EVENT	, onStageResize);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function initializeBackground():void 
		{
			_background = new Bmp(this, 'Background');
			
			addChildAt(_background, 0);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			onStageResize(null);
		}
		
		private function positionBackground():void 
		{
			_resizer.rezoWidth(_background, stage.stageWidth);
			if ( _background.height < stage.stageHeight )
				_resizer.rezoHeight(_background, stage.stageHeight);
			
			_background.x = -( _background.width - stage.stageWidth ) / 2;
			_background.y = -( _background.height - stage.stageHeight ) / 2;
		}
		
		private function onStageResize(e:Event):void 
		{
			positionElements();
		}
		
		private function positionElements():void 
		{
			if ( _graphics.parent )
			{
				_resizer.rezoHeight(_graphics, stage.stageHeight);
				_graphics.x = stage.stageWidth >> 1;
				_graphics.y = stage.stageHeight >> 1;
			}
			
			positionBackground();
		}
		
		private function onButtonClick(e:MouseEvent) : void
		{
			_graphics.question.yes.removeEventListener(MouseEvent.CLICK	, onButtonClick);
			_graphics.question.no.removeEventListener(MouseEvent.CLICK	, onButtonClick);
			
			_graphics.tetris.visible = true;
			_graphics.labels.visible = true;
			_graphics.question.visible = false;
			
			load(_content_url_request);
		}
		
		private function onIOError(e:IOErrorEvent) : void
		{
			
		}
		
		public function load(request_:URLRequest) : void
		{
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			var url_parameters:URLVariables = new URLVariables();
			url_parameters.contact = loaderInfo.parameters.contact;
			url_parameters.portfolio = loaderInfo.parameters.portfolio;
			request_.data = url_parameters;
			_loader.load(request_, context);
		}
		
		protected function onLoaded(e:Event):void 
		{
			
		}
		
		protected function onProgress(e:ProgressEvent) : void
		{
			var piece_index:int = ( e.bytesLoaded / e.bytesTotal ) * PIECES + 1;
			var piece:MovieClip = _graphics.tetris.getChildByName('piece_' + String(piece_index));
			if ( piece )
				TweenLite.to(piece, .3, { alpha: 1 } );
			
			if ( piece_index > PIECES )
			{
				removeChild(_graphics);
				
				//addChild(_loader);
			}
		}
	}
}