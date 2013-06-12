//©arnophage 2008
package jeka
{
	import flash.utils.Timer;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Tanim extends MovieClip
	{
		var letterCount:Number = 0;
		var startLocX:Number, startLocY:Number, spaceX:Number, intCaller:Number, nextX:Number, nextY:Number, inputText:String, interval1:Number, limit:Number;
		var onComplete:Function;
		var backwards:Boolean;
		public var newLetter:Letter;
		var timer:Timer;
		var color:uint;
		var textForm:TextFormat = new TextFormat();
		
		function Tanim(inputText, startLocX, startLocY, onComplete:Function, spaceX:Number = 0, intCaller:Number = 30, backwards:Boolean = true, limit:Number = 800, color:uint = 0xFFFFFF):void
		{
			this.inputText = inputText;
			this.startLocX = startLocX;
			this.startLocY = startLocY;
			this.spaceX = spaceX;
			this.limit = limit;
			this.onComplete = onComplete;
			this.intCaller = intCaller;
			this.backwards = backwards;
			this.nextX = this.startLocX;
			this.nextY = this.startLocY;
			this.color = color;
			init();
		}
		
		public function init():void
		{
			timer = new Timer(intCaller);
			timer.addEventListener(TimerEvent.TIMER, makeALetter);
			timer.start();
		}
		
		function makeALetter(e:TimerEvent):void
		{
			newLetter = new Letter();
			addChild(newLetter);
			newLetter.mcLetter.txtLetter.autoSize = TextFieldAutoSize.LEFT;
			newLetter.x = this.nextX;
			newLetter.y = this.nextY;
			if (this.backwards == true)
			{
				newLetter.mcLetter.txtLetter.text = inputText.charAt(this.letterCount);
			} else
			{
				newLetter.mcLetter.txtLetter.text = inputText;
			}
			textForm.color = color;
			newLetter.mcLetter.txtLetter.setTextFormat(textForm);
			this.nextX += newLetter.width + this.spaceX;
			
			if (newLetter.mcLetter.txtLetter.text == ' ')
			{
				var extender:uint = 0;
				for (var i:uint = 1; i < inputText.length - letterCount; i++)
				{
					if(inputText.charAt(letterCount + i) == ' ')
					{
						break;
					}
					extender++;
				}
				if (extender * 40 + nextX > limit)
				{
					newLine();
				}
			}
			
			if(nextX >= limit)
			{
				newLine();
			}
			
			this.letterCount++;
			if (this.backwards == true)
			{
				if (this.letterCount >= this.inputText.length)
				{
					timer.stop();
					onComplete();
				}
			} else
			{
				timer.stop();
				onComplete();
			}
		}
		
		function newLine():void
		{
			nextX = startLocX;
			nextY += newLetter.height + this.spaceX;
		}
	}
}