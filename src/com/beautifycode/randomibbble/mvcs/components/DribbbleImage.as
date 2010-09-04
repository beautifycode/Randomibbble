package com.beautifycode.randomibbble.mvcs.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author Marvin
	 */
	public class DribbbleImage extends Sprite {
		
		public function DribbbleImage(bitmap:Bitmap) {
			bitmap.smoothing = true;
			addChild(bitmap);

			this.width = 165;
			this.height = 135;
			this.x = 30;
			this.y = 15;			
		}
		
		public function setBitmapData(bitmapData:BitmapData):void {
			//
		}
	}
}
