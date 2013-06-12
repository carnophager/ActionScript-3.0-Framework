package ca.nectere.tweenEngine
{
    import flash.events.*;

    public class TweenObjectEvent extends Event
    {
        public var params:Array;
        public static const UPDATE:String = "tweenObjectEventUpdate";
        public static const START:String = "tweenObjectEventStart";
        public static const COMPLETE:String = "tweenObjectEventComplete";
        public static const STATE_CHANGE:String = "tweenObjectEventStateChange";

        public function TweenObjectEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false)
        {
            this.params = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new TweenObjectEvent(type, params.concat(), bubbles, cancelable);
        }// end function

    }
}
