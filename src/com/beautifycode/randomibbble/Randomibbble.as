package com.beautifycode.randomibbble {
	import com.beautifycode.randomibbble.mvcs.RandomibbbleContext;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Marvin
	 */
	[SWF(width="240", height="220", backgroundColor="#FFFFFF", frameRate="40")]
	public class Randomibbble extends MovieClip {
		public function Randomibbble() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			new RandomibbbleContext(this);
		}
	}
}