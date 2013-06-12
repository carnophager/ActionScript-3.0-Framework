package ca.nectere.tweenEngine
{

    public class Ease extends Object
    {

        public function Ease()
        {
            return;
        }// end function

        public static function outInSine(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outSine(param1 * 2, param2, param3 / 2, param4);
            }
            return inSine(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function outSine(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 * Math.sin(param1 / param4 * (Math.PI / 2)) + param2;
        }// end function

        public static function inBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (Boolean(param5))
            {
            }
            var _loc_6:* = isNaN(param5.overshoot) ? (1.70158) : (param5.overshoot);
            var _loc_7:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_7 * param1 * ((_loc_6 + 1) * param1 - _loc_6) + param2;
        }// end function

        public static function outCirc(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 * Math.sqrt(1 - --param1 / param4 * --param1 / param4) + param2;
        }// end function

        public static function outInElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return outElastic(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return inElastic(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function outInCirc(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outCirc(param1 * 2, param2, param3 / 2, param4);
            }
            return inCirc(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function inQuad(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_5 * param1 + param2;
        }// end function

        public static function inBounce(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 - outBounce(param4 - param1, 0, param3, param4) + param2;
        }// end function

        public static function inOutQuad(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_5 < 1)
            {
                return param3 / 2 * param1 * param1 + param2;
            }
            return (-param3) / 2 * (--param1 * (--param1 - 2))-- + param2;
        }// end function

        public static function outQuart(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return (-param3) * (--param1 / param4 * --param1 / param4 * _loc_1 * _loc_1)-- + param2;
        }// end function

        public static function inSine(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return (-param3) * Math.cos(param1 / param4 * (Math.PI / 2)) + param3 + param2;
        }// end function

        public static function outInBounce(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outBounce(param1 * 2, param2, param3 / 2, param4);
            }
            return inBounce(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function outBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (Boolean(param5))
            {
            }
            var _loc_6:* = isNaN(param5.overshoot) ? (1.70158) : (param5.overshoot);
            return param3 * (--param1 / param4 * --param1 / param4 * ((_loc_6 + 1) * _loc_1 + _loc_6) + 1) + param2;
        }// end function

        public static function inOutSine(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return (-param3) / 2 * Math.cos(Math.PI * param1 / param4)-- + param2;
        }// end function

        public static function inOutBounce(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return inBounce(param1 * 2, 0, param3, param4) * 0.5 + param2;
            }
            return outBounce(param1 * 2 - param4, 0, param3, param4) * 0.5 + param3 * 0.5 + param2;
        }// end function

        public static function inQuart(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_5 * param1 * param1 * param1 + param2;
        }// end function

        public static function outCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 * (--param1 / param4 * --param1 / param4 * _loc_1 + 1) + param2;
        }// end function

        public static function inOutQuart(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_5 < 1)
            {
                return param3 / 2 * param1 * param1 * param1 * param1 + param2;
            }
            var _loc_5:* = param1 - 2;
            param1 = param1 - 2;
            return (-param3) / 2 * (_loc_5 * param1 * param1 * param1 - 2) + param2;
        }// end function

        public static function outExpo(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param1 == param4 ? (param2 + param3) : (param3 * 1.001 * (-Math.pow(2, -10 * param1 / param4) + 1) + param2);
        }// end function

        public static function inOutCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_5 < 1)
            {
                return param3 / 2 * param1 * param1 * param1 + param2;
            }
            var _loc_5:* = param1 - 2;
            param1 = param1 - 2;
            return param3 / 2 * (_loc_5 * param1 * param1 + 2) + param2;
        }// end function

        public static function inCirc(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * Math.sqrt(1 - _loc_5 * param1)-- + param2;
        }// end function

        public static function outQuint(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 * (--param1 / param4 * --param1 / param4 * _loc_1 * _loc_1 * _loc_1 + 1) + param2;
        }// end function

        public static function linear(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 * param1 / param4 + param2;
        }// end function

        public static function inQuint(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_5 * param1 * param1 * param1 * param1 + param2;
        }// end function

        public static function inOutCirc(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_5 < 1)
            {
                return (-param3) / 2 * Math.sqrt(1 - param1 * param1)-- + param2;
            }
            var _loc_5:* = param1 - 2;
            param1 = param1 - 2;
            return param3 / 2 * (Math.sqrt(1 - _loc_5 * param1) + 1) + param2;
        }// end function

        public static function inOutQuint(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_5 < 1)
            {
                return param3 / 2 * param1 * param1 * param1 * param1 * param1 + param2;
            }
            var _loc_5:* = param1 - 2;
            param1 = param1 - 2;
            return param3 / 2 * (_loc_5 * param1 * param1 * param1 * param1 + 2) + param2;
        }// end function

        public static function outInQuart(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outQuart(param1 * 2, param2, param3 / 2, param4);
            }
            return inQuart(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function outElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_7:Number = NaN;
            if (param1 == 0)
            {
                return param2;
            }
            var _loc_9:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_9 == 1)
            {
                return param2 + param3;
            }
            if (Boolean(param5))
            {
            }
            var _loc_6:* = isNaN(param5.period) ? (param4 * 0.3) : (param5.period);
            if (Boolean(param5))
            {
            }
            var _loc_8:* = isNaN(param5.amplitude) ? (0) : (param5.amplitude);
            if (!Boolean(_loc_8) || _loc_8 < Math.abs(param3))
            {
                _loc_8 = param3;
                _loc_7 = _loc_6 / 4;
            }
            else
            {
                _loc_7 = _loc_6 / (2 * Math.PI) * Math.asin(param3 / _loc_8);
            }
            return _loc_8 * Math.pow(2, -10 * param1) * Math.sin((param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6) + param3 + param2;
        }// end function

        public static function inElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_7:Number = NaN;
            if (param1 == 0)
            {
                return param2;
            }
            var _loc_9:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_9 == 1)
            {
                return param2 + param3;
            }
            if (Boolean(param5))
            {
            }
            var _loc_6:* = isNaN(param5.period) ? (param4 * 0.3) : (param5.period);
            if (Boolean(param5))
            {
            }
            var _loc_8:* = isNaN(param5.amplitude) ? (0) : (param5.amplitude);
            if (!Boolean(_loc_8) || _loc_8 < Math.abs(param3))
            {
                _loc_8 = param3;
                _loc_7 = _loc_6 / 4;
            }
            else
            {
                _loc_7 = _loc_6 / (2 * Math.PI) * Math.asin(param3 / _loc_8);
            }
            return -_loc_8 * Math.pow(2, 10 * --param1) * Math.sin((--param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6) + param2;
        }// end function

        public static function outInBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return outBack(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return inBack(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function inOutElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_7:Number = NaN;
            if (param1 == 0)
            {
                return param2;
            }
            var _loc_9:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_9 == 2)
            {
                return param2 + param3;
            }
            if (Boolean(param5))
            {
            }
            var _loc_6:* = isNaN(param5.period) ? (param4 * (0.3 * 1.5)) : (param5.period);
            if (Boolean(param5))
            {
            }
            var _loc_8:* = isNaN(param5.amplitude) ? (0) : (param5.amplitude);
            if (!Boolean(_loc_8) || _loc_8 < Math.abs(param3))
            {
                _loc_8 = param3;
                _loc_7 = _loc_6 / 4;
            }
            else
            {
                _loc_7 = _loc_6 / (2 * Math.PI) * Math.asin(param3 / _loc_8);
            }
            if (param1 < 1)
            {
                return -0.5 * (_loc_8 * Math.pow(2, 10 * --param1) * Math.sin((--param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6)) + param2;
            }
            return _loc_8 * Math.pow(2, -10 * --_loc_1) * Math.sin((--_loc_1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6) * 0.5 + param3 + param2;
        }// end function

        public static function inCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_5 * param1 * param1 + param2;
        }// end function

        public static function outQuad(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * _loc_5 * (param1 - 2) + param2;
        }// end function

        public static function outBounce(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_5 < 1 / 2.75)
            {
                return param3 * (7.5625 * param1 * param1) + param2;
            }
            if (param1 < 2 / 2.75)
            {
                var _loc_5:* = param1 - 1.5 / 2.75;
                param1 = param1 - 1.5 / 2.75;
                return param3 * (7.5625 * _loc_5 * param1 + 0.75) + param2;
            }
            if (param1 < 2.5 / 2.75)
            {
                var _loc_5:* = param1 - 2.25 / 2.75;
                param1 = param1 - 2.25 / 2.75;
                return param3 * (7.5625 * _loc_5 * param1 + 0.9375) + param2;
            }
            var _loc_5:* = param1 - 2.625 / 2.75;
            param1 = param1 - 2.625 / 2.75;
            return param3 * (7.5625 * _loc_5 * param1 + 0.984375) + param2;
        }// end function

        public static function outInCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outCubic(param1 * 2, param2, param3 / 2, param4);
            }
            return inCubic(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function outInQuint(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outQuint(param1 * 2, param2, param3 / 2, param4);
            }
            return inQuint(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function outInQuad(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outQuad(param1 * 2, param2, param3 / 2, param4);
            }
            return inQuad(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function inOutExpo(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 == 0)
            {
                return param2;
            }
            if (param1 == param4)
            {
                return param2 + param3;
            }
            var _loc_5:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_5 < 1)
            {
                return param3 / 2 * Math.pow(2, 10 * param1--) + param2 - param3 * 0.0005;
            }
            return param3 / 2 * 1.0005 * (-Math.pow(2, -10 * --param1) + 2) + param2;
        }// end function

        public static function outInExpo(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param1 < param4 / 2)
            {
                return outExpo(param1 * 2, param2, param3 / 2, param4);
            }
            return inExpo(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4);
        }// end function

        public static function inExpo(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param1 == 0 ? (param2) : (param3 * Math.pow(2, 10 * (param1 / param4)--) + param2 - param3 * 0.001);
        }// end function

        public static function inOutBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (Boolean(param5))
            {
            }
            var _loc_6:* = isNaN(param5.overshoot) ? (1.70158) : (param5.overshoot);
            var _loc_7:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_7 < 1)
            {
                var _loc_7:* = _loc_6 * 1.525;
                _loc_6 = _loc_6 * 1.525;
                return param3 / 2 * (param1 * param1 * ((_loc_7 + 1) * param1 - _loc_6)) + param2;
            }
            var _loc_7:* = param1 - 2;
            param1 = param1 - 2;
            var _loc_7:* = _loc_6 * 1.525;
            _loc_6 = _loc_6 * 1.525;
            return param3 / 2 * (_loc_7 * param1 * ((_loc_7 + 1) * param1 + _loc_6) + 2) + param2;
        }// end function

    }
}
