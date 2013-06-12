//©arnophage 2008
package jeka
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ContextMenuEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.system.System;
	
	public class SelectText extends Sprite
	{
		var txt:TextField;
		var sl:Sprite;
		var item:ContextMenuItem;
		var initPos:Number, initPosLet:Number, let:Number, initChar:Number, char:Number;
		var m:Matrix;
		var tf:TextFormat, tfOriginal:TextFormat;
		var color:*, colorAlpha:*;
		var radius:uint, txtColor:uint;
		var yAdjustment:Number = 0;
		
		public function SelectText(txt:TextField, color:* = null, colorAlpha:* = null, radius:uint = 0, txtColor:uint = 0xFFFFFF, filth:Array = null, yAdjustment:Number = 0):void
		{
			addEventListener(Event.ADDED, onAdd);
			if (color is uint)
				color = [color, color];
			else if (color == null)
				color = [0xFFFFFF, 0xE6E6E6]
			if (colorAlpha is Number)
				colorAlpha = [colorAlpha, colorAlpha];
			else if (colorAlpha == null)
				colorAlpha = [1, 1];
			this.colorAlpha = colorAlpha;
			this.color = color;
			this.radius = radius;
			this.txtColor = txtColor;
			this.yAdjustment = yAdjustment;
			this.txt = txt;
			txt.selectable = false;
			sl = new Sprite();
			tf = new TextFormat();
			tfOriginal = txt.getTextFormat(0, 1);
			if (filth != null)
				sl.filters = filth;
			m = new Matrix();
			m.createGradientBox(100, txt.textHeight, (Math.PI / 180) * 90, txt.x, txt.y);

			MovieClip(txt.parent).addChildAt(this, MovieClip(txt.parent).getChildIndex(txt));	
			setContextMenu();
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED, onAdd);		
			addChildAt(sl, 0);
			setEventDispatchers();
		}
		
		private function setEventDispatchers():void
		{
			txt.addEventListener(MouseEvent.ROLL_OVER, onOver);
			txt.addEventListener(MouseEvent.ROLL_OUT, onOut);
			txt.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			txt.addEventListener(MouseEvent.DOUBLE_CLICK, onDouble);
			txt.doubleClickEnabled = true;
		}
		
		private function onDown(e:MouseEvent):void
		{
			initPos = mouseX;
			
			if (txt.mouseX > txt.getCharBoundaries(txt.length - 1).x) {
				initPosLet = txt.getCharBoundaries(txt.length - 1).x + txt.getCharBoundaries(txt.length - 1).width + 3;
				initChar = txt.length;
			} else if (txt.mouseX < txt.getCharBoundaries(0).x){
				initPosLet = txt.getCharBoundaries(0).x - txt.getCharBoundaries(0).width;
				initChar = 0;
			} else{
				initPosLet = txt.getCharBoundaries(txt.getCharIndexAtPoint(txt.mouseX - 27, 10)).x;
				initChar = txt.getCharIndexAtPoint(txt.mouseX - 27, 10);
			}
			
			txt.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageDown);
			txt.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onDouble(e:MouseEvent):void
		{
			tf.color = 0xFFFFFF;
			txt.setTextFormat(tf);
			with(sl.graphics)
			{
				clear();
				lineStyle(3, 0xFFFF00);
				beginFill(0xFF0000, 1);
				drawRoundRect(txt.x-3, txt.y + 1, txt.width, txt.height, 0);
				endFill();
			}
		}
		
		private function onUp(e:MouseEvent):void
		{
			if (!txt.hitTestPoint(mouseX, mouseY))
				Mouse.cursor = MouseCursor.AUTO;
			txt.removeEventListener(Event.ENTER_FRAME, onEnter);
			txt.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
				
		private function onEnter(e:Event):void
		{
			if (txt.mouseX > txt.getCharBoundaries(txt.length - 1).x) {
				let = txt.getCharBoundaries(txt.length - 1).x + txt.getCharBoundaries(txt.length - 1).width + 3;
				char = txt.length;
			} else if (txt.mouseX < txt.getCharBoundaries(0).x){
				let = txt.getCharBoundaries(0).x - txt.getCharBoundaries(0).width;
				char = 0;
			} else{
				let = txt.getCharBoundaries(txt.getCharIndexAtPoint(txt.mouseX - 27, 10)).x + 3;
				char = txt.getCharIndexAtPoint(txt.mouseX - 27, 10);
			}
				
			txt.setTextFormat(tfOriginal);
			
			with(sl.graphics)
			{
				clear();
				//lineStyle(1, 0xCCCCCC);
				beginGradientFill(GradientType.LINEAR, color, colorAlpha, [0, 255], m);
				
				var initPosRect:Number = txt.x + initPosLet - 28;
				var widthRect:Number = let - initPosLet;
				
				//trace(txt.y, txt.getCharBoundaries(0).y);
				
				if (widthRect > 0)
					drawRoundRect(initPosRect, txt.y + txt.getCharBoundaries(0).y + yAdjustment, widthRect, txt.getLineMetrics(0).height, radius);
				else
					drawRoundRect(initPosRect + widthRect, txt.y + txt.getCharBoundaries(0).y + yAdjustment, -widthRect, txt.getLineMetrics(0).height, radius);
				
				if (Math.abs(mouseX - initPos) < 5)
				{
					clear();
					item.enabled = false;
				} else {
					item.enabled = true;
		
					tf.color = txtColor;
					if (char > initChar)
						txt.setTextFormat(tf, initChar, char);
					else
						txt.setTextFormat(tf, char, initChar);
				}
				endFill();
			}
		}
		
		private function onOver(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.IBEAM;
		}
		
		private function onOut(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onStageDown(e:MouseEvent):void
		{
			if (!txt.hitTestPoint(mouseX, mouseY))
			{
				txt.setTextFormat(tfOriginal);
				sl.graphics.clear();
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageDown);
			}
		}
		
		private function setContextMenu():void
		{
			var cm:ContextMenu = new ContextMenu(); 
			cm.hideBuiltInItems(); 
			txt.contextMenu = cm;
			var di:ContextMenuBuiltInItems = cm.builtInItems; 
			item = new ContextMenuItem('Copy text', true, false);
			cm.customItems.push(item); 
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			
			function menuItemSelectHandler(e:ContextMenuEvent):void 
			{ 
				if (initChar < char)
					System.setClipboard(txt.text.slice(initChar, char));
				else 
					System.setClipboard(txt.text.slice(char, initChar));
			}
		}
	}	
}

