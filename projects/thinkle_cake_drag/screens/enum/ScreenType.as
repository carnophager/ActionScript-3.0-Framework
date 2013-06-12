package projects.thinkle_cake_drag.screens.enum 
{
	import projects.shared.screens.AbstractScreen;
	import projects.shared.screens.enum.ScreenTypeBase;
	import projects.thinkle_cake_drag.screens.*;
	/**
	 * Enumaration for all screen
	 * @author trayko
	 */
	public class ScreenType extends ScreenTypeBase
	{
		public static const FAN_INFO			:ScreenType = new ScreenType( FansInfo			, 0	, null);
		public static const CARD_DECORATION		:ScreenType = new ScreenType( CardDecoration	, 1	, null);
		public static const REGISTRATION		:ScreenType = new ScreenType( Registration		, 2	, null);
		public static const SHARE_SCREEN		:ScreenType = new ScreenType( ShareScreen		, 3	, null);
		public static const GALLERY				:ScreenType = new ScreenType( Gallery			, 4	, null);
		
		public function ScreenType(type_:Class, id_:int, block:block_constructor ) : void
		{
			if ( ScreenType ) throw new Error(INSTANTIATION_ERROR);
			
			_type 	= type_;
			_id		= id_;
		}
		
	}

}

class block_constructor {}