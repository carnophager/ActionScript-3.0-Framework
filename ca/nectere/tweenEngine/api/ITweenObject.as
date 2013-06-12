package ca.nectere.tweenEngine.api
{
	import flash.events.IEventDispatcher;

    public interface ITweenObject extends IEventDispatcher
    {
        public function ITweenObject();

        function isTweening() : Boolean;

        function getProgress() : Number;

        function remove() : void;

        function pause() : void;

        function isPaused() : Boolean;

        function getProps() : Array;

        function getState() : String;

        function removeProps(... args) : void;

        function resume() : void;

    }
}
