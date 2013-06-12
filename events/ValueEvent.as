package events
{
    import flash.events.*;

    public class ValueEvent extends Event
    {
        private var __value:Object;

        public function ValueEvent(eventType:String, param:Object)
        {
            super(eventType);
            __value = param;
            return;
        }
		
        public function get value() : Object
        {
            return __value;
        }

    }
}
