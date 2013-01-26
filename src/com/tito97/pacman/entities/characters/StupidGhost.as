package com.tito97.pacman.entities.characters 
{
	import com.tito97.pacman.entities.Ghost;
	import com.tito97.pacman.maps.MapHandler;
	/**
	 * This class represents a stupid ghost that will try to reach Pac-Man through random ways, hoping to cause an
	 * unpleasant surprise to the player.
	 * @author Diogo
	 */
	public class StupidGhost extends Ghost 
	{
		
		/**
		 * The color of the StupidGhosts
		 */
		public static const DEFAULT_COLOR:uint = 0x3399FF;
		
		/**
		 * Constrói uma instância de StupidGhost
		 * @param	startingRow A fila inicial do fantasma
		 * @param	startingColumn A coluna inicial do fantasma
		 * @param	map O mapa que guiará o fantasma
		 * @param	direction A direção do fantasma
		 */
		/**
		 * Constructs an instance of StupidGhost
		 * @param	startingRow The starting row for this StupidGhost
		 * @param	startingColumn The starting column for this StupidGhost
		 * @param	map The map that will guide this StupidGhost.
		 * @param	direction The initial direction for this StupidGhost instance.
		 */
		public function StupidGhost(startingRow:Number, startingColumn:Number, map:MapHandler, direction:uint=0) 
		{
			super(startingColumn, startingRow, width, height, DEFAULT_COLOR, map, direction);
		}
		
	}

}