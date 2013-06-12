package ca.nectere.time.syncEngine
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Pulse extends Object
    {
        private static var _running:Boolean = false;
        private static var _dispatcher:Shape = new Shape();
        private static var _frame:Number = 0;
        private static var _now:Timestamp;
        private static var _observers:Array = new Array();

        public function Pulse()
        {
            return;
        }// end function

        public static function removeObserver(param1:IPulseObserver) : void
        {
            var _loc_2:* = _observers.indexOf(param1);
            if (_loc_2 > -1)
            {
                _observers.splice(_loc_2, 1);
                if (_observers.length == 0)
                {
                    shutdown();
                }
            }
            return;
        }// end function

        private static function updateTimestamp() : void
        {
            _now = new Timestamp(getTimer(), ++_frame);
            return;
        }// end function

        public static function addObserver(param1:IPulseObserver) : void
        {
            var _loc_2:* = _observers.indexOf(param1);
            if (_loc_2 == -1)
            {
                _observers.push(param1);
                if (!_running)
                {
                    boot();
                }
            }
            return;
        }// end function

        public static function hasObserver(param1:IPulseObserver) : Boolean
        {
            return _observers.indexOf(param1) > -1;
        }// end function

        private static function boot() : void
        {
            _running = true;
            updateTimestamp();
            _dispatcher.addEventListener(Event.ENTER_FRAME, onPulse);
            return;
        }// end function

        private static function shutdown() : void
        {
            _running = false;
            _observers = new Array();
            _dispatcher.removeEventListener(Event.ENTER_FRAME, onPulse);
            return;
        }// end function

        public static function removeAllObservers() : void
        {
            shutdown();
            return;
        }// end function

        public static function getTimestamp() : Timestamp
        {
            return _now;
        }// end function

        private static function onPulse(event:Event) : void
        {
            var _loc_2:IPulseObserver = null;
            updateTimestamp();
            for each (_loc_2 in _observers)
            {
                
                _loc_2.onPulse(_now);
            }
            return;
        }// end function

    }
}
