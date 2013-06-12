package utils {
	
	import flash.display.DisplayObjectContainer;

	public class Cleaner {
		
		public static function clean( container:DisplayObjectContainer ):void {
			var children:int = container.numChildren;
			for ( var i:int = 0; i < children; i++ ) container.removeChildAt( 0 );
		}
		
	}
}