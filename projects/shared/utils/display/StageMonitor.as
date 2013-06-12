package projects.shared.utils.display 
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Monitors target stage resizing
	 * 
	 * @author trayko
	 */
	public class StageMonitor extends EventDispatcher
	{
		public static const STAGE_RESIZE_EVENT:String = 'stageResizeEvent';
		
		public function StageMonitor(stage_:Stage) : void
		{
			stage_.scaleMode = StageScaleMode.NO_SCALE;
			stage_.align = StageAlign.TOP_LEFT;
			
			stage_.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void
		{
			dispatchEvent(new Event(STAGE_RESIZE_EVENT));
		}
		
	}

}