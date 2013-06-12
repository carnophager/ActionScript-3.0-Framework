package ca.nectere.tweenEngine.properties
{
    import flash.display.*;
    import flash.geom.*;

    public class BrightnessProp extends AbstractProp
    {

        public function BrightnessProp()
        {
            return;
        }// end function

        override public function update(param1:Number) : void
        {
            _tmp = _start + _diff * param1;
            var _loc_2:* = 1 - Math.abs(_tmp);
            var _loc_3:* = _tmp > 0 ? (Math.round(_tmp * 255)) : (0);
            var _loc_4:* = new ColorTransform(_loc_2, _loc_2, _loc_2, 1, _loc_3, _loc_3, _loc_3, 0);
            (_scope as DisplayObject).transform.colorTransform = _loc_4;
            return;
        }// end function

        override public function timing(param1) : void
        {
            var _loc_2:* = (_scope as DisplayObject).transform.colorTransform;
            var _loc_3:* = 1 - (_loc_2.redMultiplier + _loc_2.greenMultiplier + _loc_2.blueMultiplier) / 3;
            var _loc_4:* = (_loc_2.redOffset + _loc_2.greenOffset + _loc_2.blueOffset) / 3;
            _start = _loc_4 > 0 ? (_loc_4 / 255) : (-_loc_3);
            _diff = (param1 as Number) - _start;
            return;
        }// end function

    }
}
