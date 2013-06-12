package  theField {
	
	public class GetRand {
		private var howMany:uint;
		private var all:Object;
		var cop:Array;
		var ta:Array;
		
		public function GetRand(theField:Object):void
		{
			this.all = theField;
		}
		
		public function getRand(howMany:uint = 5, whatType:String = 'letters'):Array
		{
			this.howMany = howMany;
			cop = new Array();
			ta = new Array();
			if (whatType == 'letters')
			{
				cop = cop.concat(all.letters);
			} else if (whatType == 'words') {
				cop = cop.concat(all.words);
			} else if (whatType == 'lines') {
				cop = cop.concat(all.lines);
			}
			return getRandom();
		}
		
		private function getRandom():Array
		{
			for (var i:int = 0; i < howMany; i++)
			{
				var el:int = Math.round(Math.random() * (cop.length - 1));
				ta.push(cop[el]);
				cop.splice(el, 1);
			}
		
			return ta;			
		}
	}
}
