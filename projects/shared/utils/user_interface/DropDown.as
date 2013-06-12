package projects.shared.utils.user_interface
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.geom.*;
	import flash.text.*;
	import projects.shared.screens.events.ScreenEvent;
	
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author trayko
	 */
	public class DropDown extends Sprite
	{
		
		private var _graphic			:MovieClip;
		
		public var scroll_height		:int;
		
		private var _labels				:Vector.<MovieClip>;
		private var _drop_down_items	:Vector.<String>;
		private var _drop_down_height	:int;
		
		public function DropDown(graphic_:MovieClip, drop_down_items_:Vector.<String>) : void
		{
			_graphic = graphic_;
			_drop_down_items = drop_down_items_;
			
			
			scroll_height = 0;
			_drop_down_height = _graphic.drop_down.height;
			scrollDropDown();
			
			_graphic.drop_down.cacheAsBitmap = true;
			
			initializeDropDown();
			
			Button.initializeButton(_graphic.getChildByName('drop_down_button') as Sprite, null, dropDownOverHandler);
		}
		
		private function initializeDropDown():void 
		{
			var drop_down:MovieClip = _graphic.getChildByName('drop_down') as MovieClip;
			_labels = new Vector.<MovieClip>;
			
			var i		:int;
			var length	:int = _drop_down_items.length;
			var label	:MovieClip;
			for (i = 0; i < length; i++) 
			{
				label = drop_down.getChildByName('label_' + String(i + 1)) as MovieClip;
				TextField(label.getChildByName('label_name')).text = _drop_down_items[i];
				label.active = false;
				label.buttonMode = true;
				label.mouseChildren = false;
				label.addEventListener(MouseEvent.CLICK		, onLabelChosen);
				label.addEventListener(MouseEvent.ROLL_OVER	, onRollOverLabel);
				label.addEventListener(MouseEvent.ROLL_OUT	, onRollOutLabel);
				
				_labels.push(label);
			}
		}
		
		private function onLabelChosen(e:MouseEvent):void 
		{
			var label:MovieClip = e.target as MovieClip;
			
			label.active = true;
			clearLabels(label);
			
			var label_value:String = _drop_down_items[_labels.indexOf(label)];
			
			_graphic.drop_down_button.drop_down_value.text = label_value;
			
			dispatchEvent(new ScreenEvent('drop_down', label_value));
			
			closeDropDown();
		}
		
		private function clearLabels(label_to_activate_:MovieClip = null):void 
		{
			var label:MovieClip;
			for each ( label in _labels ) 
			{
				if ( label != label_to_activate_ )
				{
					label.active = false;
					deactivateLabelColor(label);
				}
			}
		}
		
		private function onRollOverLabel(e:MouseEvent):void 
		{
			var label:MovieClip = e.target as MovieClip;
			TweenMax.to(label.background_label, .5, { alpha: 1 } );
			TweenMax.to(label.label_name, .5, { tint: 0xFFFFFF } );
		}
		
		private function onRollOutLabel(e:MouseEvent):void 
		{
			var label:MovieClip = e.target as MovieClip;
			if ( label.active )
				return;
			deactivateLabelColor(label);
		}
		
		private function deactivateLabelColor(label:MovieClip):void 
		{
			TweenMax.to(label.background_label, .5, { alpha: 0 } );
			TweenMax.to(label.label_name, .5, { tint: 0xFFF5CA } );
		}
		
		private function dropDownOverHandler(e:MouseEvent):void
		{
			TweenMax.to(this, .3, { scroll_height: _drop_down_height, onUpdate: scrollDropDown } );
			TweenMax.to(e.target, .5, { colorMatrixFilter:{brightness:1.05, saturation:1.05, contrast: 1.05}});
			removeEventListener(Event.ENTER_FRAME, checkForDropDownBounds);
			addEventListener(Event.ENTER_FRAME, checkForDropDownBounds);
		}
		
		private function checkForDropDownBounds(e:Event):void 
		{
			if ( !_graphic.drop_down.hitTestPoint(mouseX, mouseY) && !_graphic.drop_down_button.hitTestPoint(mouseX, mouseY) )
			{
				closeDropDown();
			}
		}
		
		private function closeDropDown():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkForDropDownBounds);
			TweenMax.to(this, .3, { scroll_height: 0, onUpdate: scrollDropDown } );
		}
		
		private function scrollDropDown():void 
		{
			Sprite(_graphic.drop_down).scrollRect = new Rectangle(0, 0, _graphic.drop_down.width, scroll_height);
		}
		
		public function activateItem(active_item_:int):void 
		{
			TweenMax.to(_graphic.getChildByName('button_' + String(active_item_)), 0, { tint: 0xFFFFFF } );
		}
		
	}

}