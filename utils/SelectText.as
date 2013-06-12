package utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	
	public class SelectText extends Sprite
	{
		private var __tf					:TextField;
		private var __color					:uint;
		private var __textColor				:uint;
		private var __offsetLine			:Number;
		
		public function SelectText(tf:TextField, color:uint = 0xFF0000, textColor:uint = 0xFFFFFF, initIndex:int = 0, offset:Number = 30, endOffset:Number = 30 ) : void
		{
			__tf = tf;
			__color = color;
			__textColor = textColor;
			__offsetLine = offset;
			drawSelection(initIndex, offset, endOffset);
		}
		
		private function drawSelection(_initIndex:int = 0, offsetLine:Number = 30, endOffset:Number = 30, _endIndex:int = 130, _outOfX:Boolean = true, _lastLine:uint = 0 )
		{
			_endIndex = __tf.length - 1;
			var initValue:Number = __tf.getCharBoundaries(Math.min(_initIndex, _endIndex)).x;
			var initValueY:Number = __tf.getCharBoundaries(Math.min(_initIndex, _endIndex)).y;
			var endValue:Number =  __tf.getCharBoundaries(Math.max(_initIndex, _endIndex)).x;
			
			var init:int = Math.min(__tf.getLineIndexOfChar(_initIndex), __tf.getLineIndexOfChar(_endIndex));
			var count:int = Math.max(__tf.getLineIndexOfChar(_initIndex), __tf.getLineIndexOfChar(_endIndex));
			
			//if (_initIndex == _endIndex) { graphics.clear(); ___tf.setTextFormat(_of); _endIndex = _initIndex; return; }
			
			//if (_outOfX && _endIndex > _initIndex) { endValue = __tf.getLineMetrics(__tf.getLineIndexOfChar(_endIndex)).width + __tf.getLineMetrics(__tf.getLineIndexOfChar(_endIndex)).x + _o.hoffset; _endIndex++; }
			if (_outOfX) { initValue = __tf.getLineMetrics(_lastLine).x; _endIndex = __tf.getLineOffset(init); }
			
			var offset:Number = initValue;
			var l:TextLineMetrics = __tf.getLineMetrics(init);
			var prevX:Number = __tf.x + initValue + l.x;
			if (count == init) prevX -= l.x;
			var prevY:Number = __tf.y + initValueY;
			
			with (graphics)
			{
				lineStyle();
				clear();
				beginFill(__color, 1);
				moveTo(prevX, prevY);
				if (count > init) lineTo(prevX + l.width + offsetLine - initValue, prevY);
				else prevX = __tf.x + l.x;
			}
			
			for (var i:int = init; i < count; i++)
			{
				prevY += l.height;
				graphics.lineTo(prevX + l.width + offsetLine - offset, prevY);
				l = __tf.getLineMetrics(i + 1);
				if ( l.width == 0 ) offsetLine = 0;
				else offsetLine = __offsetLine;
				prevX = __tf.x + l.x;
				if (i < count - 1) graphics.lineTo(prevX + l.width + offsetLine, prevY);
				offset = 0;
			}		
			
			graphics.lineTo(prevX + endValue - l.x + endOffset, prevY);
			graphics.lineTo(prevX + endValue - l.x + endOffset, prevY + l.height);
			if (count == init) prevX = __tf.x + initValue;
			graphics.lineTo(prevX, prevY + l.height);
			
			for (var j:int = init; j < count; j++)
			{
				offset = ((j == count - 1) ? initValue : 0);
				graphics.lineTo(prevX, prevY);
				l = __tf.getLineMetrics(count + init - j - 1);
				prevX = __tf.x + l.x + offset;
				if (j < count - 1) graphics.lineTo(prevX, prevY);
				else graphics.lineTo(__tf.x + offset, prevY);
				prevY -= l.height;
			}
			
			graphics.lineTo(__tf.x + offset, prevY);
			graphics.endFill();
			
			//__tf.setTextFormat(_of);
			
			//if (_initIndex + _endIndex > 0) __tf.setTextFormat(_tf, Math.min(_initIndex, _endIndex), Math.max(_initIndex, _endIndex));
		}
		
	}
}