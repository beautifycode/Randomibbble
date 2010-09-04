package com.beautifycode.randomibbble.mvcs.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class DribbbleImageEvent extends Event {
		public static const ALL_IMAGES_LOADED:String = "ALL_IMAGES_LOADED";
		public static const IMAGE_LOADED:String = "IMAGE_LOADED";
		public var data:Object;

		public function DribbbleImageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			var clonedEvent:DribbbleImageEvent = new DribbbleImageEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.data = data;

			return clonedEvent;
		}
	}
}
