package utils.ui
{
	import flash.text.*;
	
	public class Sentence extends TextField
	{
		
		private var __textFormat				:TextFormat;
		
		public function Sentence(width:Number, text:String, size:Number, color:uint = 0xFFFFFF, font:String = 'Times New Roman', align:String = TextFormatAlign.LEFT, bold:Boolean = false, loading:Number = 0, anti_alias:Boolean = false) : void
		{
			createTextFormat(font, size, color, align, bold, loading, anti_alias);
			setProperties(width, text);
		}
		
		private function setProperties(width:Number, text:String) : void
		{
			mouseEnabled = false;
			autoSize = TextFieldAutoSize.LEFT;
			if ( width != 0 )
			{
				wordWrap = true;
				this.width = width;
			}
			super.text = text;
			setTextFormat(__textFormat);
		}
		
		override public function set text(value:String) : void
		{
			super.text = value;
			setTextFormat(__textFormat);
		}
		
		override public function set htmlText(value:String) : void
		{
			super.htmlText = value;
			setTextFormat(__textFormat);
		}
		
		private function createTextFormat(font:String, size:Number, color:uint, align:String, bold:Boolean, leading:Number, anti_alias:Boolean) : void
		{
			__textFormat = new TextFormat(font, size, color, bold, null, null, null, null, align, null, null, null, leading);
			
			if ( anti_alias )
			{
				embedFonts = true;
				antiAliasType = AntiAliasType.NORMAL;
			}
		}
		
	}

}