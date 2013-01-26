package com.tito97.pacman.maps.tiles 
{
	/**
	 * A simple subclass of Tile, that will represent a free tile, where the  MovingCharacters of this game
	 * will be able to move on, because its "solid" property is set to "true"
	 * @author Diogo
	 */
	public class OpenTile extends Tile 
	{
		
		public const TILE_COLOR:uint = 0;
		
		/**
		 * Constructs an OpenTile instance to take place in the encapsulated map's data array
		 */
		public function OpenTile() 
		{
			super(false, TILE_COLOR);
		}
		
	}

}