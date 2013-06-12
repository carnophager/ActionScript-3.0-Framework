package com{
    import flash.display.Stage;
    public class RootClass {
        var stage:Stage;
        public function RootClass(theStage:Stage) {
			stage = theStage;
			trace(stage);
        }
    }
}