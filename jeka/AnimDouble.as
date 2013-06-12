package jeka
{
	import fl.motion.Animator;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class AnimDouble extends MovieClip
	{
		public var goga_animator:Animator;
		var animXML:XML = new XML();
		function AnimDouble():void
		{
			//trace('ok');
		}
		public function doIt(xml:String):void
		{
			var XML_URL:String = xml;
			var animXMLURL:URLRequest = new URLRequest(XML_URL);
			var loader:URLLoader = new URLLoader(animXMLURL);
			loader.addEventListener("complete", xmlLoaded);
			function xmlLoaded(evt:Event):void
			{
				animXML = XML(loader.data);
				animate();
			}
		}
		function animate():void
		{
			goga_animator = new Animator(animXML, this);
			goga_animator.play();
		}
	}
}