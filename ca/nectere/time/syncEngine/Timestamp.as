package ca.nectere.time.syncEngine
{

    public class Timestamp extends Object
    {
        public var frame:uint;
        public var ms:uint;

        public function Timestamp(param1:uint, param2:uint)
        {
            this.ms = param1;
            this.frame = param2;
            return;
        }// end function

        public function clone() : Timestamp
        {
            return new Timestamp(ms, frame);
        }// end function

    }
}
