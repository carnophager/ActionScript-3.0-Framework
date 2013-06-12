package jeka
{	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import caurina.transitions.*;
	
	public class NavigateMov
	{
		MovieClip.prototype.fade = function(min:Number = .5, time:Number = 1, mouseChildrenEnabled:Boolean = true):void
		{
			var mov:MovieClip = this;
			mov.mouseChildren = mouseChildrenEnabled;
			
			addFade();
			function addFade():void
			{
				mov.addEventListener(MouseEvent.ROLL_OVER, onOver);
				mov.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}

			function onOver(e:MouseEvent):void
			{
				Tweener.addTween(e.target, {alpha: min, time: time});
			}
			
			function onOut(e:MouseEvent):void
			{
				Tweener.addTween(e.target, {alpha: 1, time: time});
			}
			
			MovieClip.prototype.removeFade = function():void
			{
				this.removeEventListener(MouseEvent.ROLL_OVER, onOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}
			
		}		
	}
}