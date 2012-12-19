package com.tito97.pacman.utilities
{
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Diogo
	 */
	public class FPSCounter
	{
		private static const UPDATE_RATE:Number = 0.5
		static private const ORIGINAL_FRAME_RATE:Number = 60;
		
		private static var _startTime:Number;
		private static var _fpsCount:uint;
		private static var _fps:Number;
		
		public static function get fps():Number
		{
			return _fps;
		}
		
		public static function get fpsString():String
		{
			if (isNaN(_fps))
				return "Calculating... [" + Math.floor((getTimer() - _startTime) / 10 / UPDATE_RATE) + "%]";
			else
				return _fps + " FPS (" + Math.floor(fps / ORIGINAL_FRAME_RATE * 100) + "%)";
		}
		
		public function FPSCounter()
		{
			_startTime = getTimer();
		}
		
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