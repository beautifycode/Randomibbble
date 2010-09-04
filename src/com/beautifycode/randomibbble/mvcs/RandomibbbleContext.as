package com.beautifycode.randomibbble.mvcs {
	import com.beautifycode.randomibbble.mvcs.commands.BuildImageCommand;
	import com.beautifycode.randomibbble.mvcs.commands.CloseApplicationCommand;
	import com.beautifycode.randomibbble.mvcs.commands.InitializeCommand;
	import com.beautifycode.randomibbble.mvcs.events.DribbbleImageEvent;
	import com.beautifycode.randomibbble.mvcs.helpers.Logger;
	import com.beautifycode.randomibbble.mvcs.models.ImagesModel;
	import com.beautifycode.randomibbble.mvcs.services.DribbbleImageService;
	import com.beautifycode.randomibbble.mvcs.services.FlickrImageService;
	import com.beautifycode.randomibbble.mvcs.views.ImagesView;
	import com.beautifycode.randomibbble.mvcs.views.ImagesViewMediator;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class RandomibbbleContext extends Context {
		public function RandomibbbleContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup():void {
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitializeCommand, ContextEvent, true);
			commandMap.mapEvent(DribbbleImageEvent.IMAGE_LOADED, BuildImageCommand, DribbbleImageEvent, false);
			
			commandMap.mapEvent("closeClick", CloseApplicationCommand, Event, true);
			
			mediatorMap.mapView(ImagesView, ImagesViewMediator);
			
			injector.mapSingleton(FlickrImageService);
			injector.mapSingleton(DribbbleImageService);
			injector.mapSingleton(ImagesModel);
			injector.mapSingleton(Logger);
			
			contextView.addChild(new ImagesView());
			
			super.startup();
		}
	}
}
