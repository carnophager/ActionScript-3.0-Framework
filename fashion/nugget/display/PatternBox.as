package fashion.nugget.display
{

	import flash.display.BitmapData;
	
	/**
	 * @author Lucas Motta - http://lucasmotta.com
	 * 
	 * Same thing as the Box, but instead of using a color, you use bitmapData as a pattern.
	 */
	public class PatternBox extends Box
	{
		
		// ----------------------------------------------------
		// PUBLIC VARIABLES
		// ----------------------------------------------------
		
		// ----------------------------------------------------
		// PRIVATE AND PROTECTED VARIABLES
		// ----------------------------------------------------
		protected var _bitmapData : BitmapData;
		
		// ----------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------
		/**
		 * @constructor
		 * 
		 * @param bitmapData	Pattern
		 * @param width			Box Width
		 * @param height		Box Height
		 */
		public function PatternBox(bitmapData : BitmapData, width : Number, height : Number)
		{
			_bitmapData = bitmapData;
			
			super(0, width, height);
		}
		
		// ----------------------------------------------------
		// PRIVATE AND PROTECTED METHODS
		// ----------------------------------------------------
		override protected function redraw() : void
		{
			this.graphics.clear();
			this.graphics.beginBitmapFill(_bitmapData);
			_roundness == 0 ? this.graphics.drawRect(0, 0, _width, _height) : this.graphics.drawRoundRect(0, 0, _width, _height, _roundness);
			this.graphics.endFill();
		}
		
		// ----------------------------------------------------
		// EVENT HANDLERS
		// ----------------------------------------------------
		
		// ----------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------
		
		// ----------------------------------------------------
		// GETTERS AND SETTERS
		// ----------------------------------------------------
	}
}
