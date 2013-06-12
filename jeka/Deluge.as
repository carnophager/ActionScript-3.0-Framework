package jeka
{
	public class Deluge
	{
		public function Deluge(arButtons:Array = null, arEnabled:Array = null, arChildren:Array = null):void
		{
			setArButtons(arButtons);
			//trace(arEnabled);
			setArEnabled(arEnabled);
			setArChildren(arChildren);
		}
		
		private function setArButtons(ar:Array):void
		{
			for (var i:String in ar)
			{
				ar[i].buttonMode = true;
				ar[i].mouseChildren = false;
			}
		}
		
		private function setArEnabled(ar:Array):void
		{
			for (var i:String in ar)
			{
				ar[i].mouseEnabled = false;
				ar[i].mouseChildren = false;
			}
		}
		
		private function setArChildren(ar:Array):void
		{
			for (var i:String in ar)
			{
				ar[i].mouseChildren = false;
			}
		}
		
	}
}