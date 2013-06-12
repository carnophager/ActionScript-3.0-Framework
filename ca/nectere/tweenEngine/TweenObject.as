package ca.nectere.tweenEngine
{
    import ca.nectere.time.syncEngine.*;
	import ca.nectere.tweenEngine.api.ITweenObject;
    import flash.events.*;
    import flash.utils.*;

    public class TweenObject extends EventDispatcher implements ITweenObject
    {
        private var _propList:Dictionary;
        var delay:Number = 0;
        private var onUpdate:Function;
        private var _progress:Number = 0;
        private var _isTweening:Boolean;
        var duration:Number = 0;
        private var _originalProps:Object;
        private var _propNames:Array;
        private var onStartParams:Array;
        private var rounded:Boolean = false;
        var startProps:Object;
        private var onComplete:Function;
        private var onUpdateParams:Array;
        private var onStart:Function;
        var scope:Object;
        private var _isPaused:Boolean;
        private var onCompleteParams:Array;
        var creation:Timestamp;
        private var _pauseTime:Timestamp;
        private var ease:Function;
        private static var _keywords:Array = new Array("startProps", "time", "delay", "ease", "rounded", "onStart", "onStartParams", "onUpdate", "onUpdateParams", "onComplete", "onCompleteParams");

        public function TweenObject(param1, param2:Object, param3:Timestamp)
        {
            ease = Ease.linear;
            this.scope = param1;
            this.creation = param3;
            _originalProps = param2;
            _isPaused = false;
            parseProps();
            buildPropNames();
            _isTweening = delay == 0;
            return;
        }// end function

        public function remove() : void
        {
            TweenEngine.removeByObject(this);
            return;
        }// end function

        private function parseProps() : void
        {
            if (_originalProps["startProps"])
            {
                startProps = _originalProps["startProps"];
            }
            if (_originalProps["ease"])
            {
                ease = _originalProps["ease"];
            }
            if (_originalProps["time"])
            {
                duration = _originalProps["time"] * 1000;
            }
            if (_originalProps["delay"])
            {
                delay = _originalProps["delay"] * 1000;
            }
            if (_originalProps["rounded"])
            {
                rounded = _originalProps["rounded"];
            }
            if (_originalProps["onComplete"])
            {
                onComplete = _originalProps["onComplete"];
            }
            if (_originalProps["onCompleteParams"])
            {
                onCompleteParams = _originalProps["onCompleteParams"];
            }
            if (_originalProps["onStart"])
            {
                onStart = _originalProps["onStart"];
            }
            if (_originalProps["onStartParams"])
            {
                onStartParams = _originalProps["onStartParams"];
            }
            if (_originalProps["onUpdate"])
            {
                onUpdate = _originalProps["onUpdate"];
            }
            if (_originalProps["onUpdateParams"])
            {
                onUpdateParams = _originalProps["onUpdateParams"];
            }
            return;
        }// end function

        public function getProgress() : Number
        {
            return _progress;
        }// end function

        private function buildPropList() : void
        {
            var _loc_1:String = null;
            var _loc_2:AbstractProp = null;
            _propList = new Dictionary();
            for each (_loc_1 in _propNames)
            {
                
                _loc_2 = TweenProperties.makeProp(_loc_1);
                _loc_2.init(_loc_1, scope, rounded);
                _loc_2.timing(_originalProps[_loc_1]);
                _propList[_loc_1] = _loc_2;
            }
            return;
        }// end function

        function checkOverlap(param1:TweenObject) : void
        {
            if (param1.creation.ms + param1.delay >= creation.ms + delay && param1.creation.ms + param1.delay < creation.ms + delay + duration)
            {
                removeProps.apply(null, param1.getProps());
            }
            return;
        }// end function

        public function getProps() : Array
        {
            return _propNames.concat();
        }// end function

        public function resume() : void
        {
            var _loc_1:Timestamp = null;
            if (_isPaused)
            {
                _loc_1 = Pulse.getTimestamp();
                creation.ms = creation.ms + (_loc_1.ms - _pauseTime.ms);
                _isPaused = false;
                _pauseTime = null;
            }
            return;
        }// end function

        function update(param1:Timestamp) : void
        {
            var relativeNow:uint;
            var progress:Number;
            var prop:AbstractProp;
            var now:* = param1;
            if (!_isPaused && now.ms >= creation.ms + delay)
            {
                if (!_isTweening)
                {
                    _isTweening = true;
                }
                if (!_propList)
                {
                    if (onStart != null)
                    {
                        onStart.apply(null, onStartParams);
                    }
                    if (startProps)
                    {
                        applyStartProps();
                    }
                    buildPropList();
                }
                relativeNow = now.ms - (creation.ms + delay);
                progress = relativeNow < duration ? (ease(relativeNow, 0, 1, duration)) : (1);
                var _loc_3:int = 0;
                var _loc_4:* = _propList;
                while (_loc_4 in _loc_3)
                {
                    
                    prop = _loc_4[_loc_3];
                    prop.update(progress);
                }
                if (onUpdate != null)
                {
                    onUpdate.apply(null, onUpdateParams);
                }
                if (relativeNow >= duration)
                {
                    _progress = 1;
                    try
                    {
                        if (onComplete != null)
                        {
                            onComplete.apply(null, onCompleteParams);
                        }
                        dispatchEvent(new TweenObjectEvent(TweenObjectEvent.COMPLETE, onCompleteParams));
                    }
                    catch (e:Error)
                    {
                    }
                    remove();
                }
                else
                {
                    _progress = relativeNow / duration;
                }
            }
            return;
        }// end function

        public function removeProps(... args) : void
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            for each (_loc_2 in args)
            {
                
                _loc_3 = _propNames.indexOf(_loc_2);
                if (_loc_3 != -1)
                {
                    _propNames.splice(_loc_3, 1);
                    if (_propList && _propList[_loc_2])
                    {
                        _propList[_loc_2] = null;
                        delete _propList[_loc_2];
                    }
                }
            }
            if (_propNames.length == 0)
            {
                remove();
            }
            return;
        }// end function

        public function getState() : String
        {
            var _loc_1:* = Pulse.getTimestamp();
            if (_isPaused)
            {
                return TweenObjectState.PAUSED;
            }
            if (_isTweening)
            {
                return TweenObjectState.TWEENING;
            }
            if (!_isPaused && _loc_1.ms < creation.ms + delay)
            {
                return TweenObjectState.DELAY;
            }
            return TweenObjectState.COMPLETE;
        }// end function

        public function isTweening() : Boolean
        {
            return _isTweening;
        }// end function

        private function buildPropNames() : void
        {
            var _loc_1:String = null;
            _propNames = new Array();
            for (_loc_1 in _originalProps)
            {
                
                if (_keywords.indexOf(_loc_1) == -1)
                {
                    _propNames.push(_loc_1);
                }
            }
            return;
        }// end function

        private function applyStartProps() : void
        {
            var _loc_1:String = null;
            var _loc_2:AbstractProp = null;
            for (_loc_1 in startProps)
            {
                
                _loc_2 = TweenProperties.makeProp(_loc_1);
                _loc_2.init(_loc_1, scope, false);
                _loc_2.timing(startProps[_loc_1]);
                _loc_2.update(1);
            }
            return;
        }// end function

        public function pause() : void
        {
            if (!_isPaused)
            {
                _isPaused = true;
                _pauseTime = Pulse.getTimestamp();
                _isTweening = false;
            }
            return;
        }// end function

        public function isPaused() : Boolean
        {
            return _isPaused;
        }// end function

    }
}
