package com.beautifycode.randomibbble.mvcs.services {
	import com.adobe.webapis.flickr.*;
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.beautifycode.randomibbble.mvcs.events.FlickrImageEvent;
	import com.beautifycode.randomibbble.mvcs.helpers.Logger;
	import com.beautifycode.randomibbble.mvcs.models.ImagesModel;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;

	public class FlickrImageService extends Actor {
		[Inject]
		public var imagesmodel:ImagesModel;
		
		[Inject]
		public var logger:Logger;
		
		private var loadingCompleteEvent:FlickrImageEvent;
		private const USER_KEY:String = "2bbe8ce5dbdd2d1d9c7f64d869a77457";
		private const SECRET_KEY:String = "43fb960162c42983";
		private const FLICKR_URL:String = "flickr.com";
		private const CROSSDOMAIN_URL:String = "http://api.flickr.com/crossdomain.xml";
		private var imageLoader:Loader;
		private var service:FlickrService;
		private var constrainWidth:Number = 640;
		private var constainHeight:Number = 480;
		private var flickrSource:String = "cute illustration";
		private var userData:User;
		private var activePhoto:Photo;
		private var activePicID:int;
		private var _loadedImagesCount:int;

		public function FlickrImageService() {
			loadingCompleteEvent = new FlickrImageEvent(FlickrImageEvent.ALL_IMAGES_LOADED, true, false);

			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
		}

		public function auth() : void {
			Security.loadPolicyFile(CROSSDOMAIN_URL);

			service = new FlickrService(USER_KEY);

			service.addEventListener(FlickrResultEvent.AUTH_GET_FROB, onAuthResponse);
			service.addEventListener(FlickrResultEvent.PHOTOS_SEARCH, storePhotoList);
			service.addEventListener(FlickrResultEvent.PHOTOS_GET_SIZES, handleSize);

			 service.addEventListener(FlickrResultEvent.PEOPLE_GET_INFO, handleInfo);
			service.secret = SECRET_KEY;

			service.auth.getFrob();
		}

		private function handleInfo(event:FlickrResultEvent) : void {
			trace(event.data);
		}

		private function onAuthResponse(evt:FlickrResultEvent):void {
			logger.log("flickr auth success");
			initSearch(flickrSource);
		}

		private function initSearch(string:String):void {
			service.photos.search("", "", 5, "all", string, null, null, null, null, -1, "", 100, 1, "interestingness-desc");
		}

		private function storePhotoList(event:FlickrResultEvent):void {
			imagesmodel.photoList = event.data.photos as PagedPhotoList;
			logger.log("photoList count: " + imagesmodel.photoList.total);

			getImageSizes(_loadedImagesCount);
		}

		private function getImageSizes(count:int):void {
			activePhoto = imagesmodel.photoList.photos[count];
			service.photos.getSizes(activePhoto.id);
			service.people.getInfo(activePhoto.id);

			_loadedImagesCount++;
		}

		private function handleSize(evt:FlickrResultEvent):void {
			if (evt.success) {
				var sizeArr:Array = evt.data.photoSizes;
				var sizeObject:PhotoSize = sizeArr[i];

				for (var i:int = activePicID; i < sizeArr.length; i++) {
					sizeObject = sizeArr[i];
					activePicID = i;

					if (sizeObject.width > constrainWidth || sizeObject.height > constainHeight) {
						break;
					}
				}

				loadImage(sizeObject.source);
			}
		}

		private function loadImage(source:String) : void {
			logger.log("loading img: " + source);
			var urlReq:URLRequest = new URLRequest(source);
			imageLoader.load(urlReq);
		}

		private function onImageLoaded(evt:Event):void {
//			imagesmodel.storeImage(imageLoader.content as Bitmap);

			if(_loadedImagesCount < 2) {
				getImageSizes(_loadedImagesCount);
			} else {
				logger.log("all images loaded.");
				dispatch(loadingCompleteEvent);
			}
		}

		public function get imageTitle():String {
			return activePhoto.title;
		}

		public function get imageAuthor():String {
			return userData.fullname;
		}
	}
}