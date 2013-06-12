package projects.thinkle_cake_drag.screens
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.display.ItemsGrid;
	import projects.shared.utils.display.SnapShot;
	import projects.shared.data.Library;
	import projects.shared.utils.photo_upload.UserPhotoBitmapData;
	import projects.shared.utils.text.InputDispatcher;
	import projects.shared.utils.text.TypeWriter;
	import projects.shared.utils.user_interface.Button;
	import projects.shared.utils.user_interface.DragAndDropItemsPanel;
	/**
	 * ...
	 * @author trayko
	 */
	public class CardDecoration extends AbstractScreen
	{
		private var _type_writer			:TypeWriter;
		private var _pattern_string			:String;
		private var _grid					:ItemsGrid;
		private var _drag_and_drop_panel	:DragAndDropItemsPanel;
		
		public function CardDecoration() : void
		{
			Button.initializeButton(_graphic.back_button		, onBackButton		, onColoredButtonRollOver, onColoredButtonRollOut, 'Върни се обратно!');
			Button.initializeButton(_graphic.restart_button		, onRestartButton	, onColoredButtonRollOver, onColoredButtonRollOut, 'Започни отначало');
			
			Button.initializeButton(_graphic.purple_button, onPurpleButton);
			Button.initializeButton(_graphic.blue_button, onBlueButton);
			
			_pattern_string = _graphic.text_info_kid.text;
			InputDispatcher.registerField(_graphic.input_wish	, onInputWish);
			InputDispatcher.registerField(_graphic.input_name	, onInputText);
			InputDispatcher.registerField(_graphic.input_age	, onInputText);
			_graphic.input_age.restrict = '0-9';
			
			_graphic.error_message.visible = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			initializeAnimations();
			
			initializeContinueButton();
		}
		
		private function onColoredButtonRollOver(e:MouseEvent):void
		{
			TweenMax.to(e.target, .5, { alpha: .8 } );
		}
		
		private function onColoredButtonRollOut(e:MouseEvent):void 
		{
			TweenMax.to(e.target, .5, { alpha: 1 } );
		}
		
		private function onBackButton(e:MouseEvent):void
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN, 'back'));
		}
		
		private function onRestartButton(e:MouseEvent):void
		{
			_drag_and_drop_panel.clearDuplicates();
		}
		
		private function onContinueButton(e:MouseEvent):void
		{
			if ( _graphic.input_name.length > 1 && _graphic.input_age.length > 0 )
			{
				createCardSnapshot();
				dispatchEvent(new ScreenEvent(ScreenEvent.CLOSE_SCREEN));
			} else {
				_graphic.error_message.visible = true;
			}
		}
		
		private function createCardSnapshot():void
		{
			var snap_shot:SnapShot = new SnapShot(_graphic, new Rectangle(12, _graphic.purple_background.y, _graphic.purple_background.width, _graphic.purple_background.height));
			UserPhotoBitmapData.writeData(snap_shot.bitmap_data, 0);
			snap_shot.x = 12;
			snap_shot.y = 12;
			_graphic.addChild(snap_shot);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			_grid = new ItemsGrid('item_', 4, 5, 75, 75, _graphic, onItemCreated, 530, 185 );
			_drag_and_drop_panel = new DragAndDropItemsPanel(_grid.items, _graphic, _graphic.purple_background);
		}
		
		private function onItemCreated(item_:Sprite, id_:int):void
		{
			var item_background:Sprite = Library.instantiateSprite('item_background');
			item_background.name = 'background';
			item_.addChildAt(item_background, 0);
			
			Button.initializeButton(item_);
		}
		
		private function onInputText(text_:String):void
		{
			var name_string:String = _graphic.input_name.length > 0 ? _pattern_string.replace('Име', _graphic.input_name.text) : _pattern_string;
			
			_graphic.text_info_kid.text = name_string.replace('г.', _graphic.input_age.text + 'г.');
		}
		
		private function onInputWish(text_:String):void
		{
			_graphic.text_info.text = text_;
		}
		
		private function initializeAnimations():void 
		{
			_graphic.text_info.alpha = 0;
			_graphic.text_info_kid.alpha = 0;
			
			_type_writer = new TypeWriter(_graphic.text_wish, _graphic.text_wish.text, 70);
			_type_writer.pause();
			_type_writer.addEventListener(TypeWriter.DONE_EVENT, onTypeWriterDone);
			
			TweenMax.from(_graphic.star, .4, { alpha: 0, y: _graphic.star.y + 15, delay: 1, onComplete: _type_writer.resume } );
		}
		
		private function onTypeWriterDone(e:Event):void 
		{
			TweenMax.to(_graphic.text_info		, .4, { alpha: 1 } );
			TweenMax.to(_graphic.text_info_kid	, .4, { alpha: 1, delay: .7, onComplete: initializeContinueButton } );
			
			_type_writer = null;
		}
		
		private function initializeContinueButton():void 
		{
			trace('init');
			Button.initializeButton(_graphic.continue_button	, onContinueButton);
		}
		
		private function onPurpleButton(e:MouseEvent):void 
		{
			animatePurpleBackground(1);
		}
		
		private function onBlueButton(e:MouseEvent):void 
		{
			animatePurpleBackground(0);
		}
		
		private function animatePurpleBackground(alpha_:Number):void 
		{
			TweenMax.to(_graphic.purple_background, .3, { alpha: alpha_ } );
		}
		
		override public function dispose():void 
		{
			TweenMax.killChildTweensOf(_graphic);
			
			if ( _type_writer )
				_type_writer.dispose();
			_grid.dispose();
			_drag_and_drop_panel.dispose();
			
			super.dispose();
		}
	}

}