package com.tito97.pacman.maps.tiles 
{
	import com.tito97.pacman.Game;
	import flash.display.BitmapData;
	/**
	 * This will be the base class of all tiles displayed on the game.
	 * Each tile will ocupy one "cell" in the game "grid".
	 * These tiles will also determine the places where the MovingCharacters of this game can move through or not.
	 * @author Diogo
	 */
	public class Tile 
	{
		
		protected var _bitmapData:BitmapData;
		protected var _solid:Boolean;
		
		/**
		 * Constructs a Tile instance
		 * @param	solid Determines whether the MovingObjects of this game can move through this Tile or not
		 * @param	fillColor The fill color for this tile
		 */
		public function Tile(solid:Boolean, fillColor:uint) 
		{
			this._solid = solid;
			_bitmapData = new BitmapData(Game.GRID_SIZE, Game.GRID_SIZE, false, fillColor);
		}
		
		/**
		 * Determines whether the MovingObjects of this game can move through this Tile or not
		 */
		public function get solid():Boolean 
		{
			return _solid;
		}
		
		/**
		 * The BitmapData of this Tile that should be copied to the game renderer
		 */
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
	}

}