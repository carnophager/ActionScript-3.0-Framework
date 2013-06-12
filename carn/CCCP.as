package carn
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	public class CCCP
	{
		private var __tf:TextField;
		private var __txt:String;
		private var __autoSize:Boolean;
		private var __autoSizeOffset:Number;
		
		public function CCCP(tf:TextField, txt:String, css:String, autoSize:Boolean  = true, autoSizeOffset:Number = 7 ):void 
		{
			__tf = tf;
			__txt = txt;
			__autoSize = autoSize;
			__autoSizeOffset = autoSizeOffset;
			__tf.htmlText = __txt;
			if (__autoSize) __tf.height = __tf.textHeight + __autoSizeOffset;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onCSS);
			loader.load(new URLRequest(css));
		}
		
		private function onCSS(e:Event):void
		{
			var styles:StyleSheet = new StyleSheet();
			styles.parseCSS( ( e.target as URLLoader ).data );
			__tf.styleSheet = styles;
			__tf.htmlText = __txt;
			if (__autoSize) __tf.height = __tf.textHeight + __autoSizeOffset;
		}
		
	}
	
}