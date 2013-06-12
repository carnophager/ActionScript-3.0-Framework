/**
* GTweener by Joshua Granick. Jan 21, 2009
* Visit code.google.com/p/gtweener for more information.
*
* Copyright (c) 2009 Joshua Granick
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
**/

package com.eclecticdesignstudio.utils.tween {
	
	
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweenFilter;
	import com.gskinner.motion.GTweenTimeline;
	import flash.utils.Dictionary;
	
	
	/**
	 * Manages Grant Skinner's GTween class to provide global-level functionality similar to Tweener
	 * @author Joshua Granick
	 * @version 1.0
	 */
	public class GTweener {
		
		
		private static var initialized:Boolean;
		private static var tweens:Dictionary = new Dictionary (true);
		
		
		/**
		* Constructs a new managed GTween instance.
		* @param	target		The object whose properties will be tweened. Defaults to null.
		* @param	duration		The length of the tween in frames or seconds depending on the timingMode. Defaults to 10.
		* @param	properties		An object containing end property values. For example, to tween to x=100, y=100, you could pass {x:100, y:100} as the props object.
		* @param	tweenProperties		An object containing properties to set on this tween. For example, you could pass {ease:myEase} to set the ease property of the new instance. This also provides a shortcut for setting up event listeners. See .setTweenProperties() for more information.
		**/
		public static function addTween (target:Object, duration:Number = 10, properties:Object = null, tweenProperties:Object = null):GTween {
			
			var tween:GTween = new GTween (target, duration, properties, tweenProperties);
			setTween (tween, properties);
			
			return tween;
			
		}
		
		
		/**
		* Constructs a new managed GTweenFilter instance.
		* @param	target		The object whose properties will be tweened. Defaults to null.
		* @param	duration		The length of the tween in frames or seconds depending on the timingMode. Defaults to 10.
		* @param	properties		An object containing end property values. For example, to tween to x=100, y=100, you could pass {x:100, y:100} as the props object.
		* @param	tweenProperties		An object containing properties to set on this tween. For example, you could pass {ease:myEase} to set the ease property of the new instance. This also provides a shortcut for setting up event listeners. See .setTweenProperties() for more information.
		**/
		public static function addTweenFilter (target:Object, duration:Number = 10, properties:Object = null, tweenProperties:Object = null):GTweenFilter {
			
			var tween:GTweenFilter = new GTweenFilter (target, duration, properties, tweenProperties);
			setTween (tween, properties);
			
			return tween;
			
		}
		
		
		/**
		* Constructs a new managed GTweenTimeline instance.
		* @param	target		The object whose properties will be tweened. Defaults to null.
		* @param	duration		The length of the tween in frames or seconds depending on the timingMode. Defaults to 10.
		* @param	properties		An object containing destination property values. For example, to tween to x=100, y=100, you could pass <code>{x:100, y:100}</code> as the props object.
		* @param	tweenProperties		An object containing properties to set on this tween. For example, you could pass <code>{ease:myEase}</code> to set the ease property of the new instance. This also provides a shortcut for setting up event listeners. See GTweenTimeline.setTweenProperties() for more information.
		* @param	tweens		An array of alternating start positions and tween instances. For example, the following array would add 3 tweens starting at positions 2, 6, and 8: <code>[2, tween1, 6, tween2, 8, tween3]</code>
		**/
		public static function addTweenTimeline (target:Object, duration:Number = 10, properties:Object = null, tweenProperties:Object = null, tweens:Array = null):GTweenTimeline {
			
			var tween:GTweenTimeline = new GTweenTimeline (target, duration, properties, tweenProperties, tweens);
			setTween (tween, properties);
			
			return tween;
			
		}
		
		
		private static function getDictionary (target:Object):Dictionary {
			
			if (tweens[target] == null) {
				
				tweens[target] = new Dictionary (true);
				
			}
			
			return tweens[target];
			
		}
		
		
		/**
		 * Get a managed GTween object by target and property name
		 * @param	target		The object whose properties are being tweened
		 * @param	propertyName			The property which is being tweened
		 * @return		A GTween object, or null if no matching tween is found
		 */
		public static function getTween (target:Object, propertyName:String):GTween {
			
			var dictionary:Dictionary = getDictionary (target);
			
			if (dictionary != null && dictionary[propertyName] != null) {
				
				return dictionary[propertyName] as GTween;
				
			}
			
			return null;
			
		}
		
		
		/**
		 * Get a collection of managed GTween objects by target
		 * @param	target		The object whose properties are being tweened
		 * @param	propertyName			The property which is being tweened
		 * @return		An array of GTween objects, or null if no matching tween is found
		 */
		public static function getTweens (target:Object):Dictionary {
			
			var dictionary:Dictionary = getDictionary (target);
			
			if (dictionary != null) {
				
				return dictionary;
				
			}
			
			return null;
			
		}
		
		
		private static function initialize ():void {
			
			if (!initialized) {
				
				GTween.defaultEase = Equations.easeOutExpo;
				
				initialized = true;
				
			}
			
		}
		
		
		/**
		 * Pauses any managed GTween objects associated with the specified target
		 * @param	... targets		Objects whose properties are being tweened
		 */
		public static function pauseTweens (... targets:Array):void {
			
			for each (var target:Object in targets) {
				
				var dictionary:Dictionary = getDictionary (target);
				
				if (dictionary != null) {
					
					for each (var tween:GTween in dictionary) {
						
						tween.pause ();
						
					}
					
				}
				
			}
			
		}
		
		
		/**
		 * Manages an existing GTween object
		 * @param	tween		A GTween object
		 */
		public static function registerTween (tween:GTween):void {
			
			var properties:Object = tween.getProperties ();
			setTween (tween, properties);
			
		}
		
		
		/**
		 * Removes all managed GTween objects
		 */
		public static function removeAllTweens ():void {
			
			for each (var dictionary:Dictionary in tweens) {
				
				for (var propertyName:String in dictionary) {
					
					(dictionary[propertyName] as GTween).pause ();
					delete dictionary[propertyName];
					
				}
				
			}
			
		}
		
		
		/**
		 * Removes any managed GTween objects associated with the specified target
		 * @param	... targets		Objects whose properties are being tweened
		 */
		public static function removeTweens (... targets:Array):void {
			
			for each (var target:Object in targets) {
				
				var dictionary:Dictionary = getDictionary (target);
				
				if (dictionary != null) {
					
					for each (var tween:GTween in dictionary) {
						
						tween.pause ();
						
					}
					
				}
				
				tweens[target] = null;
				
			}
			
		}
		
		
		/**
		 * Resumes any managed GTween objects associated with the specified target
		 * @param	... targets		Objects whose properties are being tweened
		 */
		public static function resumeTweens (... targets:Array):void {
			
			for each (var target:Object in targets) {
				
				var dictionary:Dictionary = getDictionary (target);
				
				if (dictionary != null) {
					
					for each (var tween:GTween in dictionary) {
						
						tween.play ();
						
					}
					
				}
				
			}
			
		}
		
		
		private static function setTween (tween:GTween, properties:Object):void {
			
			initialize ();
			
			for (var propertyName:String in properties) {
				
				var dictionary:Dictionary = getDictionary (tween.target);
				
				if (dictionary[propertyName] != null) {
					
					(dictionary[propertyName] as GTween).deleteProperty (propertyName);
					
				}
				
				dictionary[propertyName] = tween;
				
			}
			
		}
		
		
	}
	
	
}