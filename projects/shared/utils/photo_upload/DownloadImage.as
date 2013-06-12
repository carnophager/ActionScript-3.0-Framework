package projects.shared.utils.photo_upload 
{
	import com.adobe.images.JPGEncoder;
	import flash.display.BitmapData;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	/**
	 * Useful for downloading bitmap to disk
	 * @author 
	 */
	public class DownloadImage 
	{
		
		public static function download(bitmap_data_:BitmapData, image_name_on_disk_:String, quality_:int = 100 )
		{
			var bitmap_encoder:JPGEncoder = new JPGEncoder(quality_);
			var byte_array:ByteArray = bitmap_encoder.encode(bitmap_data_);
			
			var file_reference:FileReference = new FileReference();
			file_reference.save(byte_array, image_name_on_disk_);
		}
	}
}