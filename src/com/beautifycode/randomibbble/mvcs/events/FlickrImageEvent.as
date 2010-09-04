package com.beautifycode.randomibbble.mvcs.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class FlickrImageEvent extends Event {
		public static const ALL_IMAGES_LOADED:String = "ALL_IMAGES_LOADED";
		private var data:Object;
		
		public function FlickrImageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			data = {};
			super(type, bubbles, cancelable);
		}
	}
}
