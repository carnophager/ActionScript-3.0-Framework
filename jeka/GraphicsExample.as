package jeka {
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;

    public class GraphicsExample extends Sprite {
        private var size:uint         = 80;
        private var bgColor:uint      = 0xFFCC00;
        private var borderColor:uint  = 0x666666;
        private var borderSize:uint   = 0;
        private var cornerRadius:uint = 9;
        private var gutter:uint       = 5;

        public function GraphicsExample() {
			trace(this);
            doDrawCircle();
            doDrawRoundRect();
            doDrawRect();
            refreshLayout();
        }

        private function refreshLayout():void {

        }

        private function doDrawCircle():void {
            var child:Shape = new Shape();
            var halfSize:uint = Math.round(size / 2);
            child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawCircle(halfSize, halfSize, halfSize);
            child.graphics.endFill();
            addChild(child);
        }

        private function doDrawRoundRect():void {
            var child:Shape = new Shape();
            child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawRoundRect(0, 0, size, size, cornerRadius);
            child.graphics.endFill();
            addChild(child);
        }

        private function doDrawRect():void {
            var child:Shape = new Shape();
            child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawRect(0, 0, size, size);
            child.graphics.endFill();
            addChild(child);
        }
    }
}