package com
{
	import fl.motion.Animator;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.*;
	public class TimeAnim extends MovieClip
	{
		var this_xml:XML = new XML();
		var this_animator:Animator
		function TimeAnim():void
		{
			trace('ok');
		}
		public function PlayIt(xml:String):void
		{
				var XML_URL:String = xml;
				var myXMLURL:URLRequest = new URLRequest(XML_URL);
				var myLoader:URLLoader = new URLLoader(myXMLURL);
				myLoader.addEventListener("complete", xmlLoaded);

				function xmlLoaded(event:Event):void
				{
					this_xml = XML(myLoader.data);
					doIt();
				}
		}
		function doIt():void
		{
				this_animator = new Animator(this_xml, this);
				this_animator.play();
		}
	}
}

