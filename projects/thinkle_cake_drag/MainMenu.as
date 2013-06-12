package projects.thinkle_cake_drag 
{
	import flash.core.ISprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import projects.shared.data.ParametersBase;
	import projects.shared.main_menu.MainMenuBase;
	import projects.shared.screens.events.ScreenEvent;
	import projects.shared.utils.user_interface.Button;
	import projects.thinkle_cake_drag.screens.CardDecoration;
	import projects.thinkle_cake_drag.screens.Gallery;
	/**
	 * Main Menu for the app
	 * @author Trayko
	 */
	public class MainMenu extends MainMenuBase
	{
		
		public function MainMenu() : void
		{
			addButton(menu_button_0, BUTTON_TYPE_NAVIGATION, CardDecoration);
			addButton(menu_button_1, BUTTON_TYPE_NAVIGATION, Gallery);
			
			addButton(menu_button_2, BUTTON_TYPE_LINK, ParametersBase.SERVER + 'thinkle_stars_game_rules.pdf');
			addButton(menu_button_3, BUTTON_TYPE_LINK, ParametersBase.SERVER + 'thinkle_stars_winners.pdf');
		}
		
	}

}