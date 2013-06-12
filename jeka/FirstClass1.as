package jeka
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class FirstClass1 extends MovieClip
	{
		private var aContent:Array;
		private var aButtons:Array;
		private var aLabels:Array;
		public function FirstClass1():void
		{
			trace('Document Class');
		}
		public function setUpContent(aContentList:Array):void
		{
			aContent = aContentList;
		}
		public function setUpButtons(aButtonList:Array, aLabelList:Array, goshe:String, lambo:String):void
		{
			aButtons = aButtonList;
			aLabels = aLabelList;
			var count:Number = aButtonList.length;
			for (var i:Number = 0; i < count; i++)
			{
				this.aButtons[i].Title(aLabels[i], goshe, lambo);
				this.aButtons[i].addEventListener(MouseEvent.CLICK, btnClick);
				this.aButtons[i].setIndex(i);
			}
		}
		public function clearCunt():void
		{
			var count:Number = aContent.length;
			for (var i:Number = 0; i < count; i++)
			{
				this.aContent[i].visible = false;
			}
		}
	 	function btnClick(evt:Event):void
		{
			trace(this);
			clearCunt();
			this.aContent[evt.target.counter].visible = true;
		}
	}
}