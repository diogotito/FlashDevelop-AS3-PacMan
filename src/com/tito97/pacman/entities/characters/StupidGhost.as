package com.tito97.pacman.entities.characters 
{
	import com.tito97.pacman.maps.MapHandler;
	/**
	 * ...
	 * @author Diogo
	 */
	public class StupidGhost extends Ghost 
	{
		
		public static const DEFAULT_COLOR:uint = 0x3399FF;
		
		public function StupidGhost(startingRow:Number, startingColumn:Number, map:MapHandler, direction:uint=0) 
		{
			super(startingColumn, startingRow, width, height, DEFAULT_COLOR, map, direction);
		}
		
	}

}