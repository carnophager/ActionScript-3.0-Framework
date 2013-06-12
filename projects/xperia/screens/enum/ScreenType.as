package projects.xperia.screens.enum 
{
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.enum.ScreenTypeBase;
	import projects.xperia.screens.*;
	/**
	 * Enumaration for all screen
	 * @author trayko
	 */
	public class ScreenType extends ScreenTypeBase
	{
		public static const START				:ScreenType = new ScreenType( StartScreen		, 0	, null);
		public static const CHOOSE_SONG			:ScreenType = new ScreenType( ChooseSongScreen	, 1	, null);
		
		public function ScreenType(type_:Class, id_:int, block:block_constructor ) : void
		{
			if ( ScreenType ) throw new Error(INSTANTIATION_ERROR);
			
			_type 	= type_;
			_id		= id_;
		}
		
	}

}

class block_constructor {}