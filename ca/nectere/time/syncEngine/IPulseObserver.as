package ca.nectere.time.syncEngine
{

    public interface IPulseObserver
    {

        public function IPulseObserver();

        function onPulse(param1:Timestamp) : void;

    }
}
