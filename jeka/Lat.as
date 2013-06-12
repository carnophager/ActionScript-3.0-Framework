package jeka
{
	public class Lat
	{
		public static function lat(test:String = 'тест'):void
		{
			//var test:String = 'Свиленград';
			var bgAlphabet:String = 'а б в г д е ж з и й к л м н о п р с т у ф х ц ч ш щ ь ъ ю я';
			bgAlphabet += ' ' + bgAlphabet.toUpperCase();
			var bgAr:Array = bgAlphabet.split(' ');
			var alphabet:String = 'а,a б,b в,v г,g д,d е,e ж,j з,z и,i й,y к,k л,l м,m н,n о,o п,p р,r с,s т,t у,u ф,f х,h ц,c ч,ch ш,sh щ,sht ь,yo ъ,u ю,iu я,ia';
			alphabet += ' ' + alphabet.toUpperCase();
			var arLetBig:Array = alphabet.split(' ');
			var arLet:Array = new Array();
			for (var z:uint = 0; z < arLetBig.length; z++)
			{
				arLet[z] = arLetBig[z].split(',');
			}
			var word:String = new String();
			for (var i:uint = 0; i < test.length; i++)
			{
				var letter:String = test.substr(i, 1);
				if (letter != ' ')
				{
					letter = arLet[bgAr.indexOf(letter)][1];
				} else {
					letter = ' ';
				}
				word += letter;
			}
			trace(word);
		}
	}
}