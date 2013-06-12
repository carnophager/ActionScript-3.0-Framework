package ca.nectere.tweenEngine
{
    import ca.nectere.time.syncEngine.*;
    import ca.nectere.tweenEngine.api.*;
    import flash.utils.*;

    public class TweenEngine extends Object implements IPulseObserver
    {
        private static var _pendingRemoveByObj:Array = [];
        private static var _tweens:Dictionary = new Dictionary();
        private static var _tweensLen:Dictionary = new Dictionary(true);
        private static var _tweensCount:int = 0;
        private static var _locked:Boolean;
        private static var _pendingAdd:Array = [];
        private static var _instance:TweenEngine;

        public function TweenEngine()
        {
            return;
        }// end function

        public function onPulse(param1:Timestamp) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Dictionary = null;
            var _loc_5:* = undefined;
            _locked = false;
            if (_pendingAdd.length > 0)
            {
                _loc_3 = _pendingAdd.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _add(_pendingAdd[_loc_2] as TweenObject);
                    _loc_2++;
                }
                _pendingAdd = [];
            }
            if (_pendingRemoveByObj.length > 0)
            {
                _loc_3 = _pendingRemoveByObj.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _removeByObject(_pendingRemoveByObj[_loc_2] as TweenObject);
                    _loc_2++;
                }
                _pendingRemoveByObj = [];
            }
            _locked = true;
            for each (_loc_4 in _tweens)
            {
                
                for (_loc_5 in _loc_4)
                {
                    
                    (_loc_5 as TweenObject).update(param1);
                }
            }
            _locked = false;
            return;
        }// end function

        public static function forceCompile() : void
        {
            return;
        }// end function

        public static function remove(param1, ... args) : void
        {
            var _loc_3:Dictionary = null;
            var _loc_4:* = undefined;
            if (_tweens[param1])
            {
                if (args.length > 0)
                {
                    _loc_3 = _tweens[param1];
                    for (_loc_4 in _loc_3)
                    {
                        
                        (_loc_4 as TweenObject).removeProps.apply(null, args);
                    }
                }
                else
                {
                    _tweensCount = _tweensCount - _tweensLen[param1];
                    delete _tweens[param1];
                    delete _tweensLen[param1];
                }
            }
            return;
        }// end function

        public static function removeAllButObjectOnScope(param1:ITweenObject, param2, ... args) : void
        {
            return;
        }// end function

        public static function getTweenObjectsOnScope(param1) : Array
        {
            var _loc_3:Dictionary = null;
            var _loc_4:* = undefined;
            var _loc_2:* = new Array();
            if (_tweens[param1])
            {
                _loc_3 = _tweens[param1];
                for (_loc_4 in _loc_3)
                {
                    
                    _loc_2.push(_loc_4);
                }
            }
            return _loc_2;
        }// end function

        static function removeByObject(param1:TweenObject) : void
        {
            if (_locked)
            {
                _pendingRemoveByObj.push(param1);
            }
            else
            {
                _removeByObject(param1);
            }
            return;
        }// end function

        public static function add(param1, param2:Object) : ITweenObject
        {
            if (param1 == null)
            {
                return null;
            }
            if (!_instance)
            {
                boot();
            }
            _tweensCount++;
            var _loc_3:* = new TweenObject(param1, param2, Pulse.getTimestamp());
            if (_locked)
            {
                _pendingAdd.push(_loc_3);
            }
            else
            {
                _add(_loc_3);
            }
            return _loc_3;
        }// end function

        private static function removeOverlap(param1:TweenObject) : void
        {
            var _loc_3:* = undefined;
            var _loc_2:* = _tweens[param1.scope];
            for (_loc_3 in _loc_2)
            {
                
                (_loc_3 as TweenObject).checkOverlap(param1);
            }
            return;
        }// end function

        public static function resume(param1) : void
        {
            var _loc_2:Dictionary = null;
            var _loc_3:* = undefined;
            if (_tweens[param1])
            {
                _loc_2 = _tweens[param1];
                for (_loc_3 in _loc_2)
                {
                    
                    (_loc_3 as TweenObject).resume();
                }
            }
            return;
        }// end function

        private static function _add(param1:TweenObject) : void
        {
            var _loc_2:* = param1.scope;
            if (_tweens[_loc_2])
            {
                removeOverlap(param1);
            }
            if (!_tweens[_loc_2])
            {
                _tweens[_loc_2] = new Dictionary();
            }
            _tweens[_loc_2][param1] = true;
            if (_tweensLen[_loc_2])
            {
                var _loc_3:* = _tweensLen;
                var _loc_4:* = _loc_2;
                _loc_3[_loc_4] = _tweensLen[_loc_2]++;
            }
            else
            {
                _tweensLen[_loc_2] = 1;
            }
            param1.update(Pulse.getTimestamp());
            return;
        }// end function

        private static function boot() : void
        {
            _instance = new TweenEngine;
            Pulse.addObserver(_instance);
            return;
        }// end function

        public static function pause(param1) : void
        {
            var _loc_2:Dictionary = null;
            var _loc_3:* = undefined;
            if (_tweens[param1])
            {
                _loc_2 = _tweens[param1];
                for (_loc_3 in _loc_2)
                {
                    
                    (_loc_3 as TweenObject).pause();
                }
            }
            return;
        }// end function

        private static function _removeByObject(param1:TweenObject) : void
        {
            if (_tweens[param1.scope])
            {
                _tweensCount--;
                delete _tweens[param1.scope][param1];
                if (_tweensLen[param1.scope] <= 1)
                {
                    delete _tweens[param1.scope];
                    delete _tweensLen[param1.scope];
                }
                else
                {
                    var _loc_2:* = _tweensLen;
                    var _loc_3:* = param1.scope;
                    _loc_2[_loc_3] = _tweensLen[param1.scope]--;
                }
            }
            return;
        }// end function

        public static function hasTweens(param1) : Boolean
        {
            return _tweens[param1];
        }// end function

    }
}
