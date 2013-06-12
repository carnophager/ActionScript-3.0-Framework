package projects.dojo_card
{
	import carn.Bmp;
	import flash.events.Event;
	import projects.shared.MainBase;
	/**
	 * DOJO company card
	 * @author trayko
	 */
	public class Main extends MainBase
	{
		private var _hand_scroller	:HandScroller;
		private var _background		:Bmp;
		
		public function Main() : void
		{
			//initialize();
		}
		
		override public function initialize() : void
		{
			super.initialize();
			
			initializeStageMonitor();
			initializeHandScroller();
		}
		
		private function initializeHandScroller():void 
		{
			_hand_scroller = new HandScroller();
			addChild(_hand_scroller);
		}
		
		override protected function onStageResize(e:Event):void 
		{
			_hand_scroller.resize();
		}
		
	}

}