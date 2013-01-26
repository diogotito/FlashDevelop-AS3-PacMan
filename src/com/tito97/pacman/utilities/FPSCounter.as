package com.tito97.pacman.utilities
{
	import flash.utils.getTimer;
	
	/**
	 * This class will be in charge of calculating the number of FPS processed in the game
	 * @author Diogo
	 */
	public class FPSCounter
	{
		/**
		 * Indicates the rate at which the _fps field is updated
		 */
		private static const UPDATE_RATE:Number = 0.5
		/**
		 * ATTENTION: This should be equal to the project's frameRate in order to make a good comparison with it [100%=OK]
		 */
		static private const ORIGINAL_FRAME_RATE:Number = 30;
		
		private static var _startTime:Number;
		private static var _fpsCount:uint;
		private static var _fps:Number;
		
		/**
		 * The calculated FPS number, which is updated according to the UPDATE_RATE
		 */
		public static function get fps():Number
		{
			return _fps;
		}
		
		/**
		 * Returns a String that informs about the FPS and tha calculating status.
		 * Very useful to be showed in debug fields
		 */
		public static function get fpsString():String
		{
			// If the FPS wasn't calculated for the first time (accordring to the UPDATE_RATE)
			if (isNaN(_fps))
				// Then show a message about its calculating status
				return "Calculating... [" + Math.floor((getTimer() - _startTime) / 10 / UPDATE_RATE) + "%]";
			else
				// Show th FPS and compares it with the project's frameRate
				return _fps + " FPS (" + Math.floor(fps / ORIGINAL_FRAME_RATE * 100) + "%)";
		}
		
		/**
		 * Initializes the FPS counter
		 */
		public function FPSCounter()
		{
			_startTime = getTimer();
		}
		
		/**
		 * Updates the FPS counter. This should be called on every frame, so it may not work in certain debug modes,
		 * like the CONFIG::keyboard_loop one.
		 */
		public static function Update():void
		{
			if (isNaN(_startTime))
				_startTime = getTimer();
			var currentTime:Number = (getTimer() - _startTime) / 1000;
			_fpsCount++;
			if (currentTime > UPDATE_RATE)
			{
				_fps = Math.floor((_fpsCount / currentTime) * 10.0) / 10.0;
				_fpsCount = 0;
				_startTime = getTimer();
			}
		}
	
	}

}