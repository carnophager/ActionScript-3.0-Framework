package projects.shared.utils.display 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import projects.shared.data.Library;
	/**
	 * Displays a range of items ordered into grid
	 * 
	 * @author trayko
	 */
	public class ItemsGrid extends EventDispatcher
	{
		//STATIC
		public static const GRID_BY_CLASS			:String = 'GRID_BY_CLASS';
		public static const GRID_BY_NAME			:String = 'GRID_BY_NAME';
		
		public static const ORDER_METHOD_HORIZONTAL	:String = 'HORIZONTAL';
		public static const ORDER_METHOD_VERTICAL	:String = 'VERTICAL';
		
		//INSTANCE
		private var _items							:Vector.<Sprite>;
		
		/**
		 * 
		 * @param	name_prefix_ What will the name of the item start with.
		 * Created items names consists of this prefix + a number according to their order in the grid.
		 * Also if a GRID_BY_CLASS type is used items will have to be exported with the corresponding name_prefix class. For Exmaple - 'item_object_3'
		 * @param	items_per_row_ Number of items per row on the grid.
		 * @param	items_per_column_ Number of items per column on the grid.
		 * @param	distance_x_ The horizontal distance between individual items.
		 * @param	distance_y_ The vertical distance between individual items.
		 * @param	holder_ Holder that will, or already contains the individual items.
		 * @param	item_creation_callback_ A callback that is called upon each item's creation.
		 * @param	type_ Grid type.
		 * Currently supported types are GRID_BY_CLASS and GRID_BY_NAME. 
		 * GRID_BY_CLASS tries to instantiate items that are exported with corresponding class name to the 'name_prefix' parameter.
		 * GRID_BY_NAME tries to get items named with item_prefix + id from the holder movie clip. If they don't exists the items are created.
		 * @param	order_method_ Sets the order method to horizontal - items are added one row at a time. Or Vertical - items are added one column at a time.
		 */
		
		public function ItemsGrid(name_prefix_:String, items_per_row_:int, items_per_column_:int, distance_x_:Number, distance_y_:Number, holder_:DisplayObjectContainer, item_creation_callback_:Function = null, offset_x_:Number = 0, offset_y_:Number = 0, type_:String = GRID_BY_CLASS, order_method_:String = ORDER_METHOD_HORIZONTAL) : void
		{			
			_items = new Vector.<Sprite>;
			
			var i		:int;
			var length	:int = items_per_row_ * items_per_column_;
			var item	:Sprite;
			
			for (i = 0; i < length; i++) 
			{
				if ( type_ == GRID_BY_CLASS )
					item = Library.instantiateSprite(name_prefix_ + String(i));
				else {
					item = holder_.getChildByName(name_prefix_ + String(i)) as Sprite;
					if ( !item )
						item = new Sprite();
				}
				
				if ( !item )
					break
				
				item.name = name_prefix_ + String(i);
				
				if ( order_method_ == ORDER_METHOD_HORIZONTAL )
				{
					item.x = ( i % items_per_row_ ) * distance_x_ + offset_x_;
					item.y = Math.floor( i / items_per_row_ ) * distance_y_ + offset_y_;
				} else {
					item.x = Math.floor( i / items_per_column_ ) * distance_x_ + offset_x_;
					item.y = ( i % items_per_column_ ) * distance_y_ + offset_y_;
				}
				
				holder_.addChild(item);
				
				_items.push(item);
				
				if ( Boolean(item_creation_callback_) )
					item_creation_callback_.apply(this, [ item, i ] );
			}
		}
		
		public function get items():Vector.<Sprite> 
		{
			return _items;
		}
		
		public function dispose():void 
		{
			_items = null;
		}
		
	}

}