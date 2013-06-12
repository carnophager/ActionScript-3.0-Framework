package ca.nectere.tweenEngine.properties
{
    import flash.display.*;
    import flash.filters.*;

    public class BlurProp extends AbstractProp
    {
        private var _blurDiff:Array;
        private var _blurStart:Array;
        private static var ARGS:Array = new Array("blurX", "blurY", "quality");

        public function BlurProp()
        {
            return;
        }// end function

        override public function update(param1:Number) : void
        {
            var _loc_4:String = null;
            var _loc_2:* = (_scope as DisplayObject).filters;
            var _loc_3:uint = 0;
            while (_loc_3++ < _loc_2.length)
            {
                
                if (_loc_2[_loc_3] is BlurFilter)
                {
                    for each (_loc_4 in ARGS)
                    {
                        
                        if (_blurStart[_loc_4] != null)
                        {
                            _tmp = _blurStart[_loc_4] + _blurDiff[_loc_4] * param1;
                            _loc_2[_loc_3][_loc_4] = _rounded ? (Math.round(_tmp)) : (_tmp);
                        }
                    }
                    break;
                }
            }
            (_scope as DisplayObject).filters = _loc_2;
            return;
        }// end function

        override public function timing(param1) : void
        {
            var _loc_6:String = null;
            var _loc_2:int = -1;
            var _loc_3:* = (_scope as DisplayObject).filters;
            var _loc_4:uint = 0;
            while (_loc_4++ < _loc_3.length)
            {
                
                if (_loc_3[_loc_4] is BlurFilter)
                {
                    _loc_2 = _loc_4;
                    break;
                }
            }
            var _loc_5:* = _loc_2 > -1 ? (_loc_3[_loc_2]) : (new BlurFilter(0, 0));
            _blurStart = new Array();
            _blurDiff = new Array();
            for each (_loc_6 in ARGS)
            {
                
                if (param1[_loc_6] != null)
                {
                    _blurStart[_loc_6] = _loc_5[_loc_6];
                    _blurDiff[_loc_6] = param1[_loc_6] - _blurStart[_loc_6];
                }
            }
            if (_loc_2 == -1)
            {
                _loc_3.push(_loc_5);
                (_scope as DisplayObject).filters = _loc_3;
            }
            return;
        }// end function

    }
}
