package projects.shared.utils.user_interface
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import projects.shared.utils.display.ClearChildren;
	/**
	 * Drag and drop items from one panel to target container
	 * 
	 * @author trayko
	 */
	public class DragAndDropItemsPanel
	{
		private var _items					:Vector.<Sprite>;
		private var _duplicated_items		:Vector.<Sprite>;
		private var _drop_target_container	:DisplayObjectContainer;
		private var _items_holder			:DisplayObjectContainer;
		private var _dragged_item			:Sprite;
		
		
		public function DragAndDropItemsPanel(items_:Vector.<Sprite>, items_holder_:DisplayObjectContainer, drop_target_container_:DisplayObjectContainer = null) : void
		{
			_items_holder = items_holder_;
			_drop_target_container = drop_target_container_;
			_items = items_;
			_items_holder = items_holder_;
			
			_duplicated_items = new Vector.<Sprite>;
			
			initializeItems();
		}
		
		private function initializeItems():void
		{
			var i		:int;
			var length	:int = _items.length;
			var item	:Sprite;
			
			_items_holder.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			for (i = 0; i < length; i++) 
			{
				item = _items[i];
				item.buttonMode = true;
				item.mouseChildren = false;
				item.addEventListener(MouseEvent.MOUSE_DOWN	, onOriginalItemMouseDown);
			}
		}
		
		private function onOriginalItemMouseDown(e:MouseEvent):void 
		{
			var item:Sprite = e.target as Sprite;
			
			startDragItem(duplicateItem(item));
		}
		
		private function onDuplicatedItemMouseDown(e:MouseEvent):void 
		{
			startDragItem(e.target as Sprite);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stopDrag();
		}
		
		private function startDragItem(item_:Sprite):void 
		{
			_dragged_item = item_;
			_items_holder.setChildIndex(_dragged_item, _items_holder.numChildren - 1);
			_dragged_item.startDrag();
		}
		
		private function stopDrag():void 
		{
			if ( !_dragged_item )
				return;
				
			_dragged_item.stopDrag();
			
			if ( _drop_target_container && !_drop_target_container.hitTestObject(_dragged_item ) )
			{
				clearItem(_dragged_item);
				_dragged_item = null;
			}
		}
		
		private function duplicateItem(item_:Sprite) : Sprite
		{
			var item_class:Class = Object(item_).constructor;
			var item:Sprite = new item_class();
			
			item.x = item_.x;
			item.y = item_.y;
			
			if ( item.getChildByName('background') )
				item.removeChild(item.getChildByName('background'));
			
			item.buttonMode = true;
			item.addEventListener(MouseEvent.MOUSE_DOWN, onDuplicatedItemMouseDown);
			
			_items_holder.addChild(item);
			
			_duplicated_items.push(item);
			
			return item;
		}
		
		public function clearDuplicates():void
		{
			for (var name:String in _duplicated_items) 
				clearItem(_duplicated_items[name], false);
			
			_duplicated_items = new Vector.<Sprite>;
		}
		
		private function clearItem(item_:Sprite, remove_from_vector_:Boolean = true) : void
		{
			item_.removeEventListener(MouseEvent.MOUSE_DOWN, onDuplicatedItemMouseDown);
			_items_holder.removeChild(item_);
			
			
			if ( remove_from_vector_ )
			{
				var duplicated_item_index:int = _duplicated_items.indexOf(item_);
				
				if ( duplicated_item_index != -1 )
					_duplicated_items.splice(duplicated_item_index, 1)
			}
			
			item_ = null;
		}
		
		public function dispose() : void
		{
			_items				= null;
			_duplicated_items	= null;
			_dragged_item		= null;
			
			ClearChildren.clear(_items_holder);
		}
		
		
	}

}