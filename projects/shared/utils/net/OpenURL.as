package projects.shared.utils.net 
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * Opens a url address in browser window
	 * @author 
	 */
	public class OpenURL 
	{
		
		public static function open(url_address_:String, target_:String = '_blank'):void
		{
			navigateToURL(new URLRequest(url_address_), target_);
		}
	}

}