package utils
{
	import flash.utils.ByteArray;
	
	public class ByteCopy
	{
		
		public static function cloneObject(o:Object) : Object
		{
		   var bytes:ByteArray = new ByteArray();
		   bytes.writeObject(o);
		   bytes.position = 0;
		   return bytes.readObject();
		}
	}
}
