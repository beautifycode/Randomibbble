package com.beautifycode.randomibbble.mvcs.views {
	import com.beautifycode.randomibbble.mvcs.events.DribbbleImageEvent;
	import com.beautifycode.randomibbble.mvcs.helpers.Logger;
	import com.beautifycode.randomibbble.mvcs.models.ImagesModel;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Marvin
	 */
	public class ImagesViewMediator extends Mediator {
		[Inject]
		public var imagesmodel:ImagesModel;
		[Inject]
		public var logger:Logger;
		
		[Inject]
		public var view:ImagesView;
		
		private var _addedImages:int;
		private var _addTimer:Timer;

		override public function onRegister() : void {
			addContextListener(DribbbleImageEvent.ALL_IMAGES_LOADED, onAllImagesLoaded);
			eventMap.mapListener(view, "closeClick", dispatch);
		}

		private function onAllImagesLoaded(event:DribbbleImageEvent) : void {
			_addTimer = new Timer(5000, imagesmodel.imagesArr.length);
			_addTimer.addEventListener(TimerEvent.TIMER, onTimerTick);
			_addTimer.start();	
		}

		private function onTimerTick(event:TimerEvent) : void {
			view.addImage(imagesmodel.imagesArr[_addedImages]);
			_addedImages++;
		}
	}
}
