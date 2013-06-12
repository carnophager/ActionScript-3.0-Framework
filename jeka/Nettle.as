package jeka
{
	import jeka.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	public class Nettle extends MovieClip
	{
		var li:LoadImg;
		var back:Sprite = new Sprite();
		var bitmap:BitmapData;
		var sw:Number, sh:Number;

		public function fillStage(pic:String):void
		{
			li = new LoadImg(pic, fillTheStage, false);
		}
		
		function fillTheStage():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			sw = stage.stageWidth;
			sh = stage.stageHeight;
			stage.addEventListener(Event.RESIZE, repos);
			var src:MovieClip = new MovieClip();
			addChildAt(src, 0);
			src.addChild(li);
			bitmap = new BitmapData(src.width, src.height, false, 0x474747);
			bitmap.draw(src, new Matrix());
			addChild(back);
			fill();
		}
		
		function repos(e:Event):void
		{
			sw = stage.stageWidth;
			sh = stage.stageHeight;
			fill();
		}

		function fill():void
		{
			back.graphics.clear();
			back.graphics.beginBitmapFill(bitmap, new Matrix(), true);
			back.graphics.drawRect(0, 0, sw, sh);
			back.graphics.endFill();
		}
	}
}