package projects.shared.main_menu
{
	import flash.core.ISprite;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import projects.shared.main_menu.events.MainMenuEvent;
	import projects.shared.utils.net.OpenURL;
	import projects.shared.utils.user_interface.Button;
	/**
	 * @author Trayko
	 */
	public class MainMenuBase extends Sprite
	{
		
		protected static const BUTTON_TYPE_NAVIGATION	:String = 'buttonTypeNavigation';
		protected static const BUTTON_TYPE_LINK			:String = 'buttonTypeLink';
		
		protected var _buttons							:Dictionary = new Dictionary();
		
		protected function addButton(button_:Sprite, type_:String, data_:Object):void 
		{
			Button.initializeButton(button_, type_ == BUTTON_TYPE_NAVIGATION ? onButtonNavigation : onButtonLink);
			
			_buttons[button_] = data_;
		}
		
		private function onButtonNavigation(e:MouseEvent):void
		{
			dispatchEvent(new MainMenuEvent(MainMenuEvent.NAVIGATE, _buttons[e.target], true));
		}
		
		private function onButtonLink(e:MouseEvent):void
		{
			trace(_buttons[e.target]);
			OpenURL.open(_buttons[e.target] as String);
		}
		
	}

}