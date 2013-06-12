package projects.dojo_card
{
	import carn.Bmp;
	import com.greensock.TweenMax;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Responsible for showing different slogans
	 * @author trayko
	 */
	public class Slogans extends EventDispatcher
	{
		private var _graphic			:DisplayObjectContainer;
		private var _pieces				:int;
		private var _current_slogan_id	:int = 0;
		private var _current_slogan		:Bmp;
		private var _old_slogan			:Bmp;
		private var _stage				:Stage;
		
		public function Slogans(graphic_:DisplayObjectContainer, pieces_:int) : void
		{
			_graphic = graphic_;
			_pieces = pieces_;
		}
		
		public function set current_slogan_id(value:int):void 
		{
			_current_slogan_id = value;
		}
		
		public function checkForChange(id_:int) : void
		{
			if ( _current_slogan_id != id_ && id_ < HandScroller.PIECES - 1 )
			{
				_current_slogan_id = id_;
				
				hideCurrentSlogan();
				
				dispatchEvent(new Event('TIME_FOR_CHANGE'));
			} else if ( id_ >= HandScroller.PIECES - 1 ) {
				hideCurrentSlogan();
			}
		}
		
		private function changeSlogans():void 
		{
			hideCurrentSlogan();
			addNewSlogan();
		}
		
		public function hideCurrentSlogan():void
		{
			if ( !_current_slogan )
				return;
				
			_old_slogan = _current_slogan;
			TweenMax.to(_old_slogan, .3, { alpha: 0, y: _current_slogan.y + 100, onComplete: clearOldSlogan, onCompleteParams: [ _old_slogan ] } );
		}
		
		public function addNewSlogan() : void
		{
			_current_slogan = new Bmp(_graphic, 'Class' + String(_current_slogan_id + 2)); // Class names in library start from 2
			_graphic.addChild(_current_slogan);
			
			reposition();
			
			TweenMax.from(_current_slogan, .3, { alpha: 0, y: _current_slogan.y + 100 } );
		}
		
		private function clearOldSlogan(old_slogan_:Bmp):void 
		{
			if ( _graphic.contains(old_slogan_) )
				_graphic.removeChild(old_slogan_);
		}
		
		public function reposition() : void
		{
			if ( !_current_slogan || !_current_slogan.stage )
				return;
				
			_current_slogan.x = _current_slogan.stage.stageWidth - _current_slogan.width;
			_current_slogan.y = _current_slogan.stage.stageHeight - _current_slogan.height - 30;
		}
	}
}