package projects.shared.data 
{
	import flash.system.*;
	import flash.utils.*;
	import flash.display.*;
	/**
	 * @author trayko
	 */
	public class Library 
	{
		public static function instantiateSprite(linkage_:String) : Sprite
		{
			var sprite_class:Class = getClass(linkage_);
			
			if (!sprite_class)
				return null;
				
			var sprite:Sprite = new sprite_class() as Sprite;
			
			if ( !sprite )
			{
				trace(getQualifiedClassName(Library) + 'instantiateSprite() -> Warning class with linkage: ' + linkage_ + ' is not Sprite!');
				
				return null;
			}
			
			return sprite;
		}
		
		public static function instantiateMovieClip(linkage_:String) : MovieClip
		{
			var movie_clip:MovieClip = instantiateSprite(linkage_) as MovieClip;
			
			if ( !movie_clip )
			{
				trace(getQualifiedClassName(Library) + '.instantiateMovieClip() -> Warning class with linkage: ' + linkage_ + ' is not MovieClip!');
				
				return null;
			}
			
			return movie_clip;
		}
		
		public static function getClass(linkage_:String) : Class
		{
			if ( !linkage_ )
			{
				trace(getQualifiedClassName(Library) + '.getClasss() -> Warning linkage is either null or empty');
				
				return null;
			}
			
			if ( !ApplicationDomain.currentDomain.hasDefinition(linkage_))
			{
				trace(getQualifiedClassName(Library) + '.getClass() -> Warning class with linkage: "' + linkage_ + '" does not exist in the current application domain or at all!');
				
				return null;
			}
			
			return getDefinitionByName(linkage_) as Class;
		}
	}
}