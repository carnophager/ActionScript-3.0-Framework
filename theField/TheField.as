package  theField {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import jeka.*;
	
	public class TheField extends Sprite {
		private var t:TextField;
		private var holder:Sprite;
		private var _theField:Object = new Object();
		private var totalLength:uint = 0;
		private var gr:GetRand;
		
		public function get theField():Object
		{
			return _theField;
		}
		
		public function TheField(t:TextField):void
		{
			this.t = t;
			t.parent.addChild(this);
			holder = new Sprite();
			addChild(holder);
			holder.x = t.x;
			holder.y = t.y;
			breakField();
			gr = new GetRand(_theField);
			t.visible = false;
		}
		
		private function breakField():void
		{
			var reg:RegExp = /[\x21-\xFF-–’.‘…“”АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя]/g;
			_theField.letters = new Array();
			_theField.words = new Array();
			_theField.lines = new Array();
			var wordsLength:uint = 0;
			var progWords:uint = 0;
			var count:uint = t.numLines;
			var styleIndex:int = 0;
			
			for (var i:int = 0; i < count; i++)
			{
				var lineAr:Array = new Array();
				var wordAr:Array = new Array();
				var prevX:Number = 0;
				var nextY:Number = 0;
				var lineCount:uint = t.getLineLength(i);
				
				for (var l:uint = 0; l < lineCount; l++)
				{
					var letter:MovieClip = new MovieClip();
					holder.addChild(letter);
					
					var inLet:TextField = new TextField();
					letter.addChild(inLet);
					
					inLet.text = t.getLineText(i).charAt(l);
					
					var gf:TextFormat = t.getTextFormat(styleIndex, ++styleIndex);
					inLet.embedFonts = true;
					inLet.autoSize = TextFieldAutoSize.LEFT;
					inLet.selectable = false;
					
					inLet.setTextFormat(gf);
					
					letter.txt = inLet.text;
					letter.color = gf.color;
					letter.bold = gf.bold;
					letter.italic = gf.italic;
										
					var Symbol:Boolean  = reg.test(inLet.text);
					if (Symbol)
					{
						reg.test(inLet.text);
						_theField.letters.push(letter);
					} else if (_theField.letters.slice(progWords, styleIndex).length) {
							_theField.words.push(_theField.letters.slice(progWords, _theField.letters.length));
							progWords = _theField.letters.length;
					}
					
					nextY = inLet.textHeight * i;
					letter.x = prevX;
					letter.y = nextY;
					prevX = letter.x + inLet.textWidth;
				}
				if (_theField.letters.length != wordsLength)
				{
					_theField.lines.push(_theField.letters.slice(wordsLength, _theField.letters.length));
					wordsLength = _theField.letters.length;
				}
			}
		}
		
		private function breakWords():void
		{
			var trueWords:Object = {txt: new Array, words: new Array};
			for (var w:String in _theField.words)
			{
				var mc:MovieClip = new MovieClip();
				var wordText:String = new String();
				holder.addChild(mc);
				trueWords.words.push(mc);
				for (var i:String in _theField.words[w])
				{
					mc.addChild(_theField.words[w][i]);
					wordText += _theField.words[w][i].txt;
				}
				trueWords.txt.push(wordText);
			}
			_theField.words = trueWords;
		}
		
		private function breakLines():void
		{
			var trueLines:Array = new Array();
			for (var w:String in _theField.lines)
			{
				var mc:Sprite = new Sprite();
				holder.addChild(mc);
				trueLines.push(mc);
				for (var i:String in _theField.lines[w])
				{
					mc.addChild(_theField.lines[w][i]);
				}
			}
			_theField.lines = trueLines;
		}
		
		public function getRands(howMany:uint, whatType:String, rand:Boolean = true)
		{
			if (whatType == 'words')
			{
				breakWords();
			} else if (whatType == 'lines') {
				breakLines();
			}
			if (rand)
				return gr.getRand(howMany, whatType);
			return _theField[whatType];
		}
		
		public function blur(howMany:uint, whatType:String, blurRange:Array, timeRange:Array):void
		{
			Blur.blur(gr.getRand(howMany, whatType), blurRange, timeRange);
		}
		
		public function kill(giveMeBackMyBabe:Boolean = false):void
		{
			if (giveMeBackMyBabe)
				t.visible = true;
			if (t.parent.contains(this))
				t.parent.removeChild(this);
		}
	}
}