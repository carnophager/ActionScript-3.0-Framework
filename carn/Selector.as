/**
 * Selector
 * Used to customize the appearance of selected text (both text color, background color, gradient background, filters and font size).
 * 
 * Usage:
 * import carn.Selector;
 * Selector.select(TextField, {color: 0xFFFFFF, bcolor: 0x000000, line: [1, 0xFF009C]}); 
 *                                                   
 * Do whatever you want with this code, just don't shit on it!
 * 
 * @author 		carnophage (carnophager@gmail.com)
 * @version 		1.0.0
 */ 

package carn
{
	import flash.display.Shape;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	//import flash.ui.Mouse;
	//import flash.ui.MouseCursor;
	import flash.system.System;
	
	public class Selector
	{
		
		public static function select(txt:TextField, o:Object= null):void
		{
			
			var _txt					:TextField;			// The modified text field
			var _o					:Object				// List of selection modifiers
			var _s					:Shape;			// Background selection
			var _initIndex		:Number;			// Init character index
			var _endIndex		:Number;			// End character index
			var _tf					:TextFormat;		// Selected text format
			var _of					:TextFormat;		// Original unselected text format
			var _lastLine			:int;		 			// Current safe line
			var _outOfX			:Boolean;			//	Checks if mouseX is off bounds
			var _posY				:Number;			// Temporary y position
			var _getBounds		:Object;			//	Used for getting last character on line x position
			var _cm				:ContextMenu; 	// The text field context menu
			
			_txt = txt;
			_o = ((o == null) ? new Object() : o);
			_o.color = (_o.color ? _o.color : 0xFFFFFF);
			_o.bcolor = (_o.bcolor ? _o.bcolor : 0xFF009C);
			_o.balpha = (isNaN(_o.balpha) ? 1 : _o.balpha);
			_o.hoffset = (isNaN(_o.hoffset) ? 5 : _o.hoffset);
			
			_tf = new TextFormat(_o.font, _o.size, _o.color, _o.bold, _o.italic, _o.underline);
			_of = _txt.getTextFormat();
			
			_s = new Shape();
			txt.parent.addChildAt(_s, txt.parent.getChildIndex(txt));
			_s.filters = _o.filters;
			
			txt.selectable = false;
			
			txt.stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			txt.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			txt.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_cm = new ContextMenu();
			_cm.addEventListener(ContextMenuEvent.MENU_SELECT, onMenu);
			setMenu(_cm, _txt).addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMenuItem);
			
			function onDown(e:MouseEvent):void
			{
				_s.graphics.clear(); _txt.setTextFormat(_of); _endIndex = _initIndex; 
				if ( _txt.stage.mouseX > _txt.x && _txt.stage.mouseX < _txt.x + _txt.width && _txt.stage.mouseY > _txt.y && _txt.stage.mouseY < _txt.y + _txt.height )
				{
					_initIndex = getIndex();
					e.target.addEventListener(Event.ENTER_FRAME, onEnter);
				}
			}
			
			function onUp(e:MouseEvent):void
			{
				_txt.removeEventListener(Event.ENTER_FRAME, onEnter);
			}
			
			function onKeyDown(e:KeyboardEvent):void
			{
				if (e.ctrlKey && e.keyCode == 67 && _initIndex != _endIndex) onMenuItem(new ContextMenuEvent(''));
				else if (e.ctrlKey && e.keyCode == 65)  { _initIndex = 0; _endIndex = _txt.text.length - 2; _outOfX = true; drawSelection(); }
			}
			
			function onEnter(e:Event):void
			{
				trace('enter');
				_endIndex = getIndex();
				drawSelection();
			}
			
			function drawSelection()
			{
				var initValue:Number = _txt.getCharBoundaries(Math.min(_initIndex, _endIndex)).x;			// Init mouse top X position
				var initValueY:Number = _txt.getCharBoundaries(Math.min(_initIndex, _endIndex)).y;		// Init mouse top Y position
				var endValue:Number =  _txt.getCharBoundaries(Math.max(_initIndex, _endIndex)).x;		// End mouse bottom X position
				
				var init:int = Math.min(_txt.getLineIndexOfChar(_initIndex), _txt.getLineIndexOfChar(_endIndex));
				var count:int = Math.max(_txt.getLineIndexOfChar(_initIndex), _txt.getLineIndexOfChar(_endIndex));
				
				if (_initIndex == _endIndex) { _s.graphics.clear(); _txt.setTextFormat(_of); _endIndex = _initIndex; return; }
				if (_outOfX && _endIndex > _initIndex) { endValue = _txt.getLineMetrics(_txt.getLineIndexOfChar(_endIndex)).width + _txt.getLineMetrics(_txt.getLineIndexOfChar(_endIndex)).x + _o.hoffset; _endIndex++; }
				else if (_outOfX) { initValue = _txt.getLineMetrics(_lastLine).x; _endIndex = _txt.getLineOffset(init); }
				var offset:Number = initValue;
				
				var l:TextLineMetrics = _txt.getLineMetrics(init);
				var prevX:Number = _txt.x + initValue + l.x;
				if (count == init) prevX -= l.x;
				var prevY:Number = _txt.y + initValueY;
				
				with (_s.graphics)
				{
					clear();
					lineStyle.apply(_s, _o.line);
					if (_o.gline) lineGradientStyle.apply(_s, _o.gline);
					if (_o.fillType == 'grad') beginGradientFill.apply(_s, _o.gradientFill);
					else if (_o.fillType == 'bitmap') beginBitmapFill.apply(_s, _o.bitmapFill);
					else beginFill(_o.bcolor, _o.balpha);
					moveTo(prevX, prevY);
					if (count > init) lineTo(prevX + l.width + _o.hoffset - initValue, prevY);
					else prevX = _txt.x + l.x;
				}
				
				for (var i:int = init; i < count; i++)
				{
					prevY += l.height;
					_s.graphics.lineTo(prevX + l.width + _o.hoffset - offset, prevY);
					l = _txt.getLineMetrics(i + 1);
					prevX = _txt.x + l.x;
					if (i < count - 1) _s.graphics.lineTo(prevX + l.width + _o.hoffset, prevY);
					offset = 0;
				}		
				
				_s.graphics.lineTo(prevX + endValue - l.x, prevY);
				_s.graphics.lineTo(prevX + endValue - l.x, prevY + l.height);
				if (count == init) prevX = _txt.x + initValue;
				_s.graphics.lineTo(prevX, prevY + l.height);
				
				for (var j:int = init; j < count; j++)
				{
					offset = ((j == count - 1) ? initValue : 0);
					_s.graphics.lineTo(prevX, prevY);
					l = _txt.getLineMetrics(count + init - j - 1);
					prevX = _txt.x + l.x + offset;
					if (j < count - 1) _s.graphics.lineTo(prevX, prevY);
					else _s.graphics.lineTo(_txt.x + offset, prevY);
					prevY -= l.height;
				}
				
				_s.graphics.lineTo(_txt.x + offset, prevY);
				_s.graphics.endFill();
				
				_txt.setTextFormat(_of);
				if (_initIndex + _endIndex > 0) _txt.setTextFormat(_tf, Math.min(_initIndex, _endIndex), Math.max(_initIndex, _endIndex));
			}
			
			function getIndex():Number
			{
				var line:int = _txt.getLineIndexAtPoint(0, _txt.mouseY);
				if (line > -1 && _txt.getLineLength(line)) _lastLine = line;
				else line = -1;
				_getBounds = _txt.getCharBoundaries(_txt.getLineOffset(_lastLine + 1) - 2) == null ? _getBounds : _txt.getCharBoundaries(_txt.getLineOffset(_lastLine + 1) - 2);
				_posY =  (line > -1 && _txt.getCharBoundaries(_txt.getLineOffset(_lastLine + 1) - 2) != null) ? _txt.mouseY : _posY;
				if (_txt.mouseY > _txt.textHeight) { _posY = _txt.textHeight; _lastLine = _txt.getLineIndexAtPoint(0, _posY); }
				else if (_txt.mouseY < 0) { _posY = 1; _lastLine = 0 };
				_outOfX = _txt.getCharIndexAtPoint(_txt.mouseX, _posY) > -1 ? false : true;
				var posX:Number = !_outOfX ? _txt.mouseX : _getBounds.x;
				if (_txt.mouseX < _txt.getLineMetrics(_lastLine).x) posX = _getBounds.x;
				while (_txt.getCharIndexAtPoint(posX, _posY) < 0) posX -= .1;
				if (_txt.mouseX < _txt.getLineMetrics(_lastLine).x && _txt.getLineIndexOfChar(_initIndex) >= _lastLine) posX = _txt.getLineMetrics(_lastLine).x;
				return _txt.getCharIndexAtPoint(posX, _posY);
			}
			
			function onMenu(e:ContextMenuEvent):void
			{
				e.target.customItems[0].enabled = _initIndex != _endIndex ? true : false;
			}
			
			function onMenuItem(e:ContextMenuEvent):void
			{
				System.setClipboard(_txt.text.slice(Math.min(_initIndex, _endIndex), Math.max(_initIndex, _endIndex)));
			}
		}
		
		private static function setMenu(cm:ContextMenu, txt:TextField):ContextMenuItem
		{
			cm.hideBuiltInItems();
			txt.contextMenu = cm;
			var cmi:ContextMenuBuiltInItems = cm.builtInItems;
			var item:ContextMenuItem = new ContextMenuItem('Copy                             Ctrl+C', true, false);
			cm.customItems.push(item);
			return item;
		}
	}
}