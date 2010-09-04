package com.beautifycode.randomibbble.mvcs.helpers {
	import flash.display.Sprite;
	import flash.utils.getTimer;

	/**
	 * @author Marvin
	 */
	public class Logger extends Sprite {
		private var _debug:Boolean;
		
		public function Logger():void {
			
		}
		
		public function log(msg:String):void {
			if(_debug) trace(Math.floor(getTimer()) + "ms - " + msg);
		}

		public function get debug() : Boolean {
			return _debug;
		}

		public function set debug(debug:Boolean) : void {
			_debug = debug;
		}
		
		
	}
}
