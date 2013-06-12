package projects.shared.utils.display 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * removes all children from DisplayObjectContainer instance
	 */
	public class ClearChildren 
	{
		public static function clear(display_object_container:DisplayObjectContainer):void
		{
			if (!display_object_container) return;
			
			var index:int;
			const LENGTH:int = display_object_container.numChildren;
			
			for (index = LENGTH - 1; index >= 0; index--) 
			{
				display_object_container.removeChildAt(index);
			}
		}
		
	}
}