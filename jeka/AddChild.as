package jeka
{
	import flash.display.MovieClip;
	public class AddChild extends MovieClip
	{
		var children:Array = new Array();
		var holder:MovieClip = new MovieClip();
		
		public function AddChilds(holders:MovieClip, childrens:Array):void
		{
			holder = holders;
			children = childrens;
			children.forEach(addChildren);
		}
		
		function addChildren(e:*, i:int, a:Array):void
		{
			holder.addChild(e);
		}
	}
}