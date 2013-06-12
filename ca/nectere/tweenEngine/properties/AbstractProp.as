package ca.nectere.tweenEngine.properties
{

    public class AbstractProp extends Object
    {
        protected var _start:Number;
        protected var _diff:Number;
        protected var _rounded:Boolean;
        protected var _name:String;
        protected var _scope:Object;
        protected var _tmp:Number;

        public function AbstractProp()
        {
            return;
        }// end function

        public function update(param1:Number) : void
        {
            _tmp = _start + _diff * param1;
            _scope[_name] = _rounded ? (Math.round(_tmp)) : (_tmp);
            return;
        }// end function

        public function init(param1:String, param2, param3:Boolean) : void
        {
            _name = param1;
            _scope = param2;
            _rounded = param3;
            return;
        }// end function

        public function timing(param1) : void
        {
            _start = _scope[_name];
            _diff = (param1 as Number) - _start;
            return;
        }// end function

    }
}
