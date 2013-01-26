package com.tito97.pacman 
{
	import flash.display.BitmapData;
	
	/**
	 * 
	 * @author Diogo
	 */
	public interface IRenderable 
	{
		/**
		 * 
		 */
		function Update():void;
		/**
		 * 
		 * @param	renderer
		 */
		function Render(renderer:BitmapData):void;
	}
	
}