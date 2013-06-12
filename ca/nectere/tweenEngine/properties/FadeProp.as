package ca.nectere.tweenEngine.properties
{
    import flash.display.*;

    public class FadeProp extends AbstractProp
    {

        public function FadeProp()
        {
            return;
        }// end function

        override public function update(param1:Number) : void
        {
            _tmp = _start + _diff * param1;
            (_scope as DisplayObject).alpha = _rounded ? (Math.round(_tmp)) : (_tmp);
            (_scope as DisplayObject).visible = (_scope as DisplayObject).alpha > 0;
            return;
        }// end function

        override public function timing(param1) : void
        {
            _start = (_scope as DisplayObject).alpha;
            _diff = (param1 as Number) - _start;
            return;
        }// end function

    }
}
