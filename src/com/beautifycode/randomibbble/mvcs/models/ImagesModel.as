package com.beautifycode.randomibbble.mvcs.models {
	import com.adobe.webapis.flickr.PagedPhotoList;
	import com.beautifycode.randomibbble.mvcs.components.DribbbleImage;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Marvin
	 */
	public class ImagesModel extends Actor {
		private var _imagesArr:Array;
		private var _photoList:PagedPhotoList;
		
		
		public function ImagesModel() {
			_imagesArr = new Array();
		}
		
		public function storeImage(img:DribbbleImage):void {
			_imagesArr.push(img);
		}

		public function get imagesArr() : Array {
			return _imagesArr;
		}

		public function get photoList() : PagedPhotoList {
			return _photoList;
		}

		public function set photoList(photoList:PagedPhotoList) : void {
			_photoList = photoList;
		}
	}
}
