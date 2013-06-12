package jeka {
    import flash.display.Sprite;

    public class MouseEventExample extends Sprite {
        private var size:uint = 100;
        private var bgColor:uint = 0xFFCC00;

        public function MouseEventExample() {
            var child:ChildSprite = new ChildSprite();
            addChild(child);
        }
    }
}

import flash.display.Sprite;
import flash.events.MouseEvent;

class ChildSprite extends Sprite {
    private var size:uint = 50;
    private var overSize:uint = 60;
    private var backgroundColor:uint = 0xFFCC00;
    private var overColor:uint = 0xCCFF00;
    private var downColor:uint = 0x00CCFF;

    public function ChildSprite() {
        draw(size, size, backgroundColor);
        addEventListener(MouseEvent.CLICK, clickHandler);
        addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
        addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
        addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
    }

    private function draw(w:uint, h:uint, bgColor:uint):void {
        graphics.clear();
        graphics.beginFill(bgColor);
        graphics.drawRect(0, 0, w, h);
        graphics.endFill();
    }

    private function clickHandler(event:MouseEvent):void {
        trace("clickHandler");
    }

    private function doubleClickHandler(event:MouseEvent):void {
        trace("doubleClickHandler");
    }

    private function mouseDownHandler(event:MouseEvent):void {
        trace("mouseDownHandler");
        draw(overSize, overSize, downColor);

        var sprite:Sprite = Sprite(event.target);
        sprite.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        sprite.startDrag();
    }

    private function mouseMoveHandler(event:MouseEvent):void {
        trace("mouseMoveHandler");
        event.updateAfterEvent();
    }

    private function mouseOutHandler(event:MouseEvent):void {
        trace("mouseOutHandler");
        draw(size, size, backgroundColor);
    }

    private function mouseOverHandler(event:MouseEvent):void {
        trace("mouseOverHandler");
        draw(overSize, overSize, overColor);
    }

    private function mouseWheelHandler(event:MouseEvent):void {
        trace("mouseWheelHandler delta: " + event.delta);
    }

    private function mouseUpHandler(event:MouseEvent):void {
        trace("mouseUpHandler");
        var sprite:Sprite = Sprite(event.target);
        sprite.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        sprite.stopDrag();
        draw(overSize, overSize, overColor);
    }
}
