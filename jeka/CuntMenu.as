package jeka 
{
	import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	public class CuntMenu
	{
		var myContextMenu:ContextMenu;
		var menuLabel:String, address:String;
		function CuntMenu(item:String, adr:String, stg:Object):void
		{
			menuLabel = item;
			address = adr;
			myContextMenu = new ContextMenu();
			removeDefaultItems();
			addCustomMenuItems();
			stg.contextMenu = myContextMenu;
		}
		
		function removeDefaultItems():void 
		{
			myContextMenu.hideBuiltInItems();
			var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
			defaultItems.print = true;
			//defaultItems.zoom = true;
		}

		function addCustomMenuItems():void 
		{
			var item:ContextMenuItem = new ContextMenuItem(menuLabel);
			myContextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		}
		
		function menuItemSelectHandler(evt:ContextMenuEvent):void
		{
			var author:URLRequest = new URLRequest(address);
			navigateToURL(author, '_blank');
		}
	}
}