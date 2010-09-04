package com.beautifycode.randomibbble.mvcs.commands {
	import com.beautifycode.randomibbble.mvcs.helpers.Logger;
	import com.beautifycode.randomibbble.mvcs.services.DribbbleImageService;

	import org.robotlegs.mvcs.Command;

	import flash.events.MouseEvent;

	/**
	 * @author Marvin
	 */
	public class InitializeCommand extends Command {
		[Inject]
		public var service:DribbbleImageService;
		
		[Inject]
		public var logger:Logger;
		
		override public function execute() : void {
			logger.debug = true;
			logger.log("startApplication");
			
			contextView.addEventListener(MouseEvent.MOUSE_DOWN, moveWindow);
			
			service.init();
		}
		
		private function moveWindow(event : MouseEvent) : void {
//			NativeApplication.nativeApplication.activeWindow.startMove();
		}
	}
}
