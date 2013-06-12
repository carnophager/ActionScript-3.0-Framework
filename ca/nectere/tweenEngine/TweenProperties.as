package ca.nectere.tweenEngine
{
    import ca.nectere.tweenEngine.properties.*;
    import flash.utils.*;

    public class TweenProperties extends Object
    {
        private static var props:Dictionary;
        static var initProps:Boolean = init();

        public function TweenProperties()
        {
            return;
        }// end function

        static function makeProp(param1:String) : AbstractProp
        {
            if (isSpecialProp(param1))
            {
                return new props[param1] as Class;
            }
            return new AbstractProp();
        }// end function

        private static function init() : Boolean
        {
            props = new Dictionary();
            props["_frame"] = FrameProp;
            props["_color"] = ColorProp;
            props["_colorTransform"] = ColorTransformProp;
            props["_fade"] = FadeProp;
            props["_volume"] = VolumeProp;
            props["_blur"] = BlurProp;
            props["_brightness"] = BrightnessProp;
            return true;
        }// end function

        public static function isSpecialProp(param1:String) : Boolean
        {
            return props[param1] != null;
        }// end function

    }
}
