package carn
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	public class CSS 
	{
		private static var __tf:TextField;
		private static var __txt:String;
		private static var __autoSize:Boolean;
		private static var __autoSizeOffset:Number;
		
		public static function format(tf:TextField, txt:String, css:String, autoSize:Boolean = true, autoSizeOffset:Number = 7 ):void 
		{
			__tf = tf;
			__txt = txt;
			__autoSize = autoSize;
			__autoSizeOffset = autoSizeOffset;
			__tf.htmlText = __txt;
			if (__autoSize) __tf.height = __tf.textHeight + __autoSizeOffset;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, CSS.onCSS);
			loader.load(new URLRequest(css));
		}
		
		private static function onCSS(e:Event):void
		{
			var styles:StyleSheet = new StyleSheet();
			styles.parseCSS( ( e.target as URLLoader ).data );
			__tf.styleSheet = styles;
			__tf.htmlText = __txt;
			if (__autoSize) __tf.height = __tf.textHeight + __autoSizeOffset;
		}
		
	}
	
}