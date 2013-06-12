package ca.nectere.tweenEngine.properties
{
    import flash.display.*;

    public class FrameProp extends AbstractProp
    {

        public function FrameProp()
        {
            return;
        }// end function

        override public function update(param1:Number) : void
        {
            _tmp = _start + _diff * param1;
            _tmp = _rounded ? (Math.round(_tmp)) : (_tmp);
            if (_tmp >= 1 && _tmp <= (_scope as MovieClip).totalFrames)
            {
                (_scope as MovieClip).gotoAndStop(_tmp);
            }
            else
            {
                throw new Error("Frame Tween error, invalid frame value");
            }
            return;
        }// end function

        override public function timing(param1) : void
        {
            _start = (_scope as MovieClip).currentFrame;
            _diff = (param1 as Number) - _start;
            _rounded = true;
            return;
        }// end function

    }
}
