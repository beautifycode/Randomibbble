package com.beautifycode.randomibbble.mvcs.commands {
	import com.beautifycode.randomibbble.mvcs.components.DribbbleImage;
	import com.beautifycode.randomibbble.mvcs.events.DribbbleImageEvent;
	import com.beautifycode.randomibbble.mvcs.models.ImagesModel;

	import org.robotlegs.mvcs.Command;

	import flash.display.Bitmap;

	/**
	 * @author Marvin
	 */
	public class BuildImageCommand extends Command {
		[Inject]
		public var imagesmodel:ImagesModel;
		
		[Inject]
		public var event:DribbbleImageEvent;
		
		override public function execute() : void {
			var tmpBitmap:Bitmap = event.data as Bitmap;
			var tmpImage:DribbbleImage = new DribbbleImage(tmpBitmap);
			
			imagesmodel.storeImage(tmpImage);
		}
	}
}
