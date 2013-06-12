package jeka
{
	import flash.display.*
	import jeka.ShitDraw;
	public class AllDraw extends MovieClip
	{
		function AllDraw():void
		{
			var bob:ShitDraw = new ShitDraw(stage);
			bob.here();
			trace(stage);
		}
		public function mengeme(op:String)
		{
			trace(op);
		}
	}
}