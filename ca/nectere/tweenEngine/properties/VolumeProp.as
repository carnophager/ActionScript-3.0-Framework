package ca.nectere.tweenEngine.properties
{
    import flash.media.*;

    public class VolumeProp extends AbstractProp
    {

        public function VolumeProp()
        {
            return;
        }// end function

        override public function update(param1:Number) : void
        {
            var _loc_2:SoundTransform = null;
            _loc_2 = _scope["soundTransform"];
            _tmp = _start + _diff * param1;
            _loc_2.volume = _rounded ? (Math.round(_tmp)) : (_tmp);
            _scope["soundTransform"] = _loc_2;
            return;
        }// end function

        override public function timing(param1) : void
        {
            _start = (_scope["soundTransform"] as SoundTransform).volume;
            _diff = (param1 as Number) - _start;
            return;
        }// end function

    }
}
