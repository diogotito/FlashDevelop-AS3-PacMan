package com.tito97.pacman.maps.tiles 
{
	import com.tito97.pacman.Game;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Diogo
	 */
	public class Tile 
	{
		
		protected var _bitmapData:BitmapData;
		protected var _solid:Boolean;
		
		public function Tile(solid:Boolean, fillColor:uint) 
		{
			this._solid = solid;
			_bitmapData = new BitmapData(Game.GRID_SIZE, Game.GRID_SIZE, false, fillColor);
		}
		
		public function get solid():Boolean 
		{
			return _solid;
		}
		
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
	}

}