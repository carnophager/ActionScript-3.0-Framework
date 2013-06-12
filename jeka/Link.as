package com
{
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	public class Link extends MovieClip
	{
		public function link(address:String, window:String)
		{
			var link:URLRequest = new URLRequest(address);
			navigateToURL(link, window);
		}
	}
}