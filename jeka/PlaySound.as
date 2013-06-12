package jeka {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	public class PlaySound {
		
		MovieClip.prototype.Play = function(clickSound:Sound = null, overSound:Sound = null, outSound:Sound = null):void
		{
			if(clickSound != null)
			{
				this.addEventListener(MouseEvent.CLICK, playClickSound);
				function playClickSound(e:MouseEvent):void
				{
					clickSound.play();
				}
			}
			
			if (overSound != null)
			{
				this.addEventListener(MouseEvent.ROLL_OVER, playOverSound);
				function playOverSound(e:MouseEvent):void
				{
					overSound.play();
				}
			}
			
			if (outSound != null)
			{
				this.addEventListener(MouseEvent.ROLL_OUT, playOutSound);
				function playOutSound(e:MouseEvent):void
				{
					outSound.play();
				}
			}
			
		}
	}
}