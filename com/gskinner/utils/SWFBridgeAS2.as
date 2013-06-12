﻿/**
* SWFBridgeAS2 by Grant Skinner. March 11, 2007
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* You may distribute this class freely, provided it is not modified in any way (including
* removing this header or changing the package path).
*
* Please contact info@gskinner.com prior to distributing modified versions of this class.
*/

import mx.events.EventDispatcher;

class com.gskinner.utils.SWFBridgeAS2 {
	private var baseID:String;
	private var myID:String;
	private var extID:String;
	private var lc:LocalConnection;
	private var host:Boolean;
	private var clientObj:Object;
	private var _connected:Boolean=false;
	
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	
	public function SWFBridgeAS2(p_id:String,p_clientObj:Object) {
		EventDispatcher.initialize(this);
		
		baseID = p_id.split(":").join("");
		
		lc = new LocalConnection();
		var _this:Object = this;
		lc.com_gskinner_utils_SWFBridge_init = function() {
			_this.com_gskinner_utils_SWFBridge_init();
		}
		lc.com_gskinner_utils_SWFBridge_receive = function() {
			_this.com_gskinner_utils_SWFBridge_receive.apply(_this,arguments);
		}
		
		clientObj = p_clientObj;
		
		host = lc.connect(baseID+"_host");
			
		myID = baseID+((host)?"_host":"_guest");
		extID = baseID+((host)?"_guest":"_host");
		
		if (!host) {
			lc.connect(myID);
			lc.send(extID,"com_gskinner_utils_SWFBridge_init");
		}
	}
	
	public function close():Void {
		lc.close();
		delete(clientObj);
		delete(lc);
		_connected = false;
	}
	
	public function send():Void {
		if (!_connected) { return; }
		var args:Array = arguments.slice(0);
		args.unshift("com_gskinner_utils_SWFBridge_receive");
		args.unshift(extID);
		lc.send.apply(lc,args);
	}
	
	public function get id():String {
		return baseID;
	}
	
	public function get connected():Boolean {
		return _connected;
	}
	
	public function com_gskinner_utils_SWFBridge_receive():Void {
		var args:Array = arguments.slice(0);
		var method:String = String(args.shift());
		clientObj[method].apply(clientObj,args);
	}
	
	public function com_gskinner_utils_SWFBridge_init():Void {
		trace("SWFBridge (AS2) connected as "+(host?"host":"client"));
		if (host) {
			lc.send(extID,"com_gskinner_utils_SWFBridge_init");
		}
		_connected = true;
		dispatchEvent({type:"connect"});
	}
}