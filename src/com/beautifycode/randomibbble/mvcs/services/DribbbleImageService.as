package com.beautifycode.randomibbble.mvcs.services {
	import couk.markstar.starrequests.requests.IRequest;
	import couk.markstar.starrequests.stardribbblelib.requests.PlayerShotsByUsernameRequest;
	import couk.markstar.starrequests.stardribbblelib.vo.Shots;

	import com.beautifycode.randomibbble.mvcs.events.DribbbleImageEvent;
	import com.beautifycode.randomibbble.mvcs.helpers.Logger;
	import com.beautifycode.randomibbble.mvcs.models.ImagesModel;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author Marvin
	 */
	public class DribbbleImageService extends Actor {
		[Inject]
		public var imagesmodel:ImagesModel;
		[Inject]
		public var logger:Logger;
		private var _loader:Loader;
		private var _imgURLRequest:URLRequest;
		private var _loadedImagesCount:int;
		private var _request:IRequest;
		private var _shotsAmount:uint;
		private var _shotsURLArr:Array;
		private var _loadingCompleteEvent:DribbbleImageEvent;
		private var _imageLoadedEvent:DribbbleImageEvent;

		public function DribbbleImageService() {
		}

		public function init():void {
			// Security.allowDomain("*");
			// Security.loadPolicyFile(CROSSDOMAIN_URL);

			_loadingCompleteEvent = new DribbbleImageEvent(DribbbleImageEvent.ALL_IMAGES_LOADED, true, false);
			_imageLoadedEvent = new DribbbleImageEvent(DribbbleImageEvent.IMAGE_LOADED, true, false);

			_shotsURLArr = new Array();
			getShots("larissameek");
		}

		public function getShots(userName:String):void {
			_request = new PlayerShotsByUsernameRequest(userName, 1, 10);
			_request.completedSignal.add(startLoadingProcess);
			_request.send();
		}

		public function startLoadingProcess(shots:Shots):void {
			_shotsAmount = shots.numShots;
			_shotsAmount = 3;
			logger.log("_shotsAmount: " + _shotsAmount);

			for(var i:int; i < shots.numShots; i++) {
				if(shots.getShot(i).url)
					_shotsURLArr.push(shots.getShot(i).imageURL);
			}

			_imgURLRequest = new URLRequest();
			_imgURLRequest.url = _shotsURLArr[0];

			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			_loader.load(_imgURLRequest);
		}

		private function loadImage(loadedImagesCount:int) : void {
			_imgURLRequest.url = _shotsURLArr[loadedImagesCount];
			_loader.load(_imgURLRequest);
		}

		private function onImageLoaded(event:Event) : void {
			_imageLoadedEvent.data = _loader.content;
			dispatch(_imageLoadedEvent);
			logger.log("picture loaded: " + _imgURLRequest.url);

			_loadedImagesCount++;

			if(_loadedImagesCount < _shotsAmount) {
				loadImage(_loadedImagesCount);
			} else {
				logger.log("all images loaded");
				dispatch(_loadingCompleteEvent);
			}
		}
	}
}
