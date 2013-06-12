package utils
{
    import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	import flash.net.URLRequest;

    public class Sounder
    {
        public static function play(soundName:String, volume:Number = 1, external:Boolean = true) : void
        {
            var sound				:Sound;
            var soundChannel	:SoundChannel;
			
            if (external) 
			{
				sound = new Sound();
				sound.load(new URLRequest(soundName));
				soundChannel = sound.play();
			} else {
				var cls:Class = Class(getDefinitionByName(soundName));
				sound = new cls as Sound;
			}
            if (sound) soundChannel = sound.play();
            soundChannel.soundTransform = new SoundTransform(volume);
            return;
        }
		
    }
}
