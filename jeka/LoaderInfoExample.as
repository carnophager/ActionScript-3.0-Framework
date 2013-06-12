package jeka {
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.URLRequest;

    public class LoaderInfoExample extends Sprite {
        private var url:String = "Image.jpg";

        public function LoaderInfoExample() {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            var request:URLRequest = new URLRequest(url);
            loader.load(request);
            addChild(loader);
        }

        private function initHandler(event:Event):void {
            var loader:Loader = Loader(event.target.loader);
            var info:LoaderInfo = LoaderInfo(loader.contentLoaderInfo);
            trace("initHandler: loaderURL=" + info.loaderURL + " url=" + info.url);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
    }
}