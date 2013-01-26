package com.tito97.pacman.maps.tiles 
{
	/**
	 * A simple subclass of Tile, that will represent an occupied "wall" tile, where the several
	 * MovingCharacter instances wont be able to pass through, because its "solid" property is set
	 * to "true"
	 * @author Diogo
	 */
	public class FilledTile extends Tile 
	{
		
		public const TILE_COLOR:uint = 255;
		
		/**
		 * Constructs a FilledTile instance to take place in the encapsulated map's data array
		 */
		public function FilledTile() 
		{
			super(true, TILE_COLOR);
		}
		
	}

}