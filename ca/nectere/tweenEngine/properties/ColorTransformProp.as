package ca.nectere.tweenEngine.properties
{
    import flash.display.*;
    import flash.geom.*;

    public class ColorTransformProp extends AbstractProp
    {
        private var _colorDiff:Array;
        private var _colorStart:Array;
        private static var ARGS:Array = new Array("redMultiplier", "greenMultiplier", "blueMultiplier", "redOffset", "greenOffset", "blueOffset");

        public function ColorTransformProp()
        {
            return;
        }// end function

        override public function update(param1:Number) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = (_scope as DisplayObject).transform.colorTransform;
            for each (_loc_3 in ARGS)
            {
                
                _tmp = _colorStart[_loc_3] + _colorDiff[_loc_3] * param1;
                _loc_2[_loc_3] = _rounded ? (Math.round(_tmp)) : (_tmp);
            }
            (_scope as DisplayObject).transform.colorTransform = _loc_2;
            return;
        }// end function

        override public function timing(param1) : void
        {
            var _loc_4:String = null;
            _colorStart = new Array();
            _colorDiff = new Array();
            var _loc_2:* = (_scope as DisplayObject).transform.colorTransform;
            var _loc_3:* = param1 == null ? (new ColorTransform()) : (param1);
            for each (_loc_4 in ARGS)
            {
                
                _colorStart[_loc_4] = _loc_2[_loc_4];
                _colorDiff[_loc_4] = _loc_3[_loc_4] - _colorStart[_loc_4];
            }
            return;
        }// end function

    }
}
