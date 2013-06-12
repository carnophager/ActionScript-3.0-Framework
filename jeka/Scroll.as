//by carnophage & videotutorials-bg.com ©2008
package jeka
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.*;
	
	public class Scroll extends MovieClip
	{
		private var cont:DisplayObject, masker:DisplayObject, mScroll:MovieClip, track:DisplayObject;
		private var lock:Boolean, local:Boolean = false;
		private var ratioSpeed:uint, wheelSpeed:uint;
		private var cInit:int, sInit:int;
		private var top:Number, limit:Number, bottom:Number, newPos:Number, oldPos:Number, goThere:Number, ratioMaster:Number;
		
		public function Scroll(cont:DisplayObject, masker:DisplayObject, mScroll:MovieClip, track:DisplayObject = null, lock:Boolean = false, ratioSpeed:uint = 7, wheelSpeed:uint = 3, local:Boolean = false):void
		{
			this.cont = cont;
			this.masker = masker;
			this.mScroll = mScroll;
			if ( track ) this.track = track;
			this.lock = lock;
			this.ratioSpeed = ratioSpeed;
			this.wheelSpeed = wheelSpeed;
			this.local = local;
			mScroll.buttonMode = true;
			mScroll.mouseChildren = false;
			cInit = cont.y;
			sInit = mScroll.y;
		}
		
		public function scrollInit():void
		{
			cont.y = cInit;
			mScroll.y = sInit;
			cont.mask = masker;
			top = mScroll.y;
			limit = masker.y + masker.height - mScroll.height - sInit;
			bottom = top + limit;
			
			newPos = oldPos = mScroll.y;
			goThere = cont.y;
			ratioMaster = (cont.height - masker.height) / limit + .01;
			
			if (cont.height <= masker.height)
			{
				stopScroll(true);
			} else {
				mScroll.visible = true;
				if ( track ) track.visible = true;
				scrolling();
			}
		}
		
		private function scrolling():void
		{
			mScroll.addEventListener(MouseEvent.MOUSE_DOWN, dragging);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			if(!local)
			{
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheel);
			} else {
				this.parent.addEventListener(MouseEvent.ROLL_OVER, localWheel);
				this.parent.addEventListener(MouseEvent.ROLL_OUT, localWheelOUT);
			}
			masker.addEventListener(Event.ENTER_FRAME, scrollIt);
		}
		
		public function stopScroll(hide:Boolean = false):void
		{
			mScroll.removeEventListener(MouseEvent.MOUSE_DOWN, dragging);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
			if(!local)
			{
				stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheel);
			} else {
				this.parent.removeEventListener(MouseEvent.ROLL_OVER, localWheel);
				this.parent.removeEventListener(MouseEvent.ROLL_OUT, localWheelOUT);
			}
			masker.removeEventListener(Event.ENTER_FRAME, scrollIt);
			cont.y = cInit;
			mScroll.y = sInit;
			if ( hide )
			{
				mScroll.visible = false;
				if ( track ) track.visible = false;
			}
		}
		
		private function localWheel(e:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheel);
			if(this.parent.hitTestPoint(mouseX, mouseY))
			{
				//stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheel);
			} else {
				//stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheel);
			}
		}
		
		private function localWheelOUT(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheel);
		}
		
		private function dragging(e:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(e.target.x, top, 0, limit);
			e.target.startDrag(lock, rect);
		}
		
		private function stopDragging(e:MouseEvent):void
		{
			mScroll.stopDrag();
		}
		
		private function scrollIt(e:Event):void
		{
			newPos = mScroll.y;
			goThere += (oldPos - newPos) * ratioMaster;
			cont.y -= (cont.y - goThere) / ratioSpeed;
			oldPos = newPos;
		}
		
		public function wheel(e:MouseEvent):void
		{
			if (newPos >= top && newPos <= bottom)
			{
				newPos -= e.delta * wheelSpeed;
				if (newPos < top)
				{
					newPos = top;
				} else if (newPos > bottom)
				{
					newPos = bottom;
				}
				mScroll.y = newPos;
			}
		}
		
		public function get drag() : MovieClip
		{
			return mScroll;
		}
		
		public function get initPos() : int
		{
			return cInit;
		}
		
		public function get container() : DisplayObject
		{
			return cont;
		}
		
	}	
}