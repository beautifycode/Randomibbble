package com.beautifycode.randomibbble.mvcs.views {
	import com.beautifycode.randomibbble.mvcs.components.DribbbleImage;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Marvin
	 */
	public class ImagesView extends Sprite {
		private var _closeBtn:CloseBtn;
		private var _overlayDesign:OverlayAsset;
		private var _imgContainer:Sprite;
		private var _startAnimation:StartAnimation;

		public function ImagesView() {
			_imgContainer = new Sprite();
			_startAnimation = new StartAnimation();
			
			_startAnimation.x = 25;
			_startAnimation.y = 15;
			
			addChild(_startAnimation);
			
			addChild(_imgContainer);
			
			_closeBtn = new CloseBtn();
			_closeBtn.buttonMode = true;
			_closeBtn.x = 190;
			_closeBtn.y = 5;

			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseClick);

			_overlayDesign = new OverlayAsset();

			addChild(_overlayDesign);
			addChild(_closeBtn);
		}

		private function onCloseClick(event:MouseEvent) : void {
			dispatchEvent(new Event("closeClick", true, false));
		}

		public function addImage(image:DribbbleImage) : void {
			if(_startAnimation) removeChild(_startAnimation);
			_imgContainer.addChild(image);
		}
	}
}
