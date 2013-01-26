package com.tito97.pacman.maps 
{
	import com.tito97.pacman.IRenderable;
	import com.tito97.pacman.maps.Maps;
	import com.tito97.pacman.Game;
	import com.tito97.pacman.maps.tiles.Tile;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * This class will deal with the level data treatment, encapsulating it in a Vector made up
	 * with the several Tile instances (organized by rows) through functions that will help guiding
	 * the MovingCharacters of this game. This class will also be in charge of rendering the game map.
	 * @author Diogo
	 */
	public class MapHandler implements IRenderable
	{
		/**
		 * Os dados do mapa de bits do mapa do nível atual
		 */
		public var mapBitmapData:BitmapData;
		
		private var tileArray:Vector.<Vector.<Tile>>;
		
		private var mapCollection:Maps;
		private var _mapData:Array;
		
		private var _numColumns:uint;
		private var _numRows:uint;
		/**
		 * The size in pixels of each tile on the map
		 */
		public var tileSize:Number;
		
		private var tileRect:Rectangle;
		
		/**
		 * Constructs a MapHandler instance. After that, you can call the loadLevelData() function to
		 * load the data of a level so it can be rendered and used to guide the MovingCharacter instances
		 * of this game.
		 * @param	tileSize The size of each tile in pixels in this map
		 * @param	numHorizontalTiles Defines the number of columns that will be shown in this map
		 * @param	numVerticalTiles Defines the number of rows that will be shown in this map
		 */
		public function MapHandler(tileSize:Number, numHorizontalTiles:uint, numVerticalTiles:uint) 
		{
			this.tileSize = tileSize;
			this._numColumns = numHorizontalTiles;
			this._numRows = numVerticalTiles;
			mapBitmapData = new BitmapData(numColumns * tileSize, numRows * tileSize, false, 0);
			mapCollection = new Maps();
			tileArray = new Vector.<Vector.<Tile>>();
			tileRect = new Rectangle(0, 0, tileSize, tileSize);
		}
		
		/**
		 * Loads the data of a level so it can be rendered and used to guide the MovingCharacter instances that are
		 * have this map agregated with them.
		 * @param	level The level number to be loaded.
		 */
		public function loadLevelData(level:int):void 
		{
			_mapData = mapCollection.getMap(level);
			for (var r:int = 0; r < numRows; r++) 
			{
				var row:Vector.<Tile> = new Vector.<Tile>();
				for (var c:int = 0; c < numColumns; c++) 
				{
					row.push(new mapCollection.tileClasses[_mapData[r][c]]); //=> Não é uma prática lá muito boa...
					//var newTile:Tile = createMapTile(_mapData, x, y);
					mapBitmapData.copyPixels(row[c].bitmapData, tileRect, new Point(c*tileSize, r*tileSize));
				}
				tileArray.push(row);
				//trace(row.toString().replace(/\[object (\w*)\],/g, "$1\t")+"\n");
			}
		}
		
		
		  /////////////////////////////
		 // PUBLIC GETTER FUNCTIONS //
		/////////////////////////////
		
		/**
		 * Gets the Tile in the given position. If the coordinates given are out of the map bounds,
		 * it will be returned the tile positioned on the opposite bound (minus the distance in tiles
		 * from the other bound).
		 * @param	row The row where the Tile is
		 * @param	column The column where the Tile is
		 * @return The Tile instance in the given position
		 */
		public function getTile(row:int, column:int):Tile 
		{
			while (row < 0 || row >= _numRows)
				row = _numRows - Math.abs(row);
			while (column < 0 || column >= numColumns)
				column = _numColumns- Math.abs(column);
			return tileArray[row][column];
		}
		
		/**
		 * Gets the row specified by the position given.
		 * @param	row The Tile's row index
		 * @return A Vector of Tiles that made up the chosen row
		 */
		public function getRow(row:int):Vector.<Tile> 
		{
			return tileArray[row];
		}
		
		/**
		 * Populates a Vector of Tiles of the specified column
		 * @param	column The Tile's column index.
		 * @return A Vector of Tiles that made up the chosen column
		 */
		public function getColumn(column:int):Vector.<Tile> 
		{
			var result:Vector.<Tile> = new Vector.<Tile>();
			for (var i:int = 0; i < tileArray.length; i++) 
				result.push(tileArray[i][column]);
			return result;
		}
		
		/* INTERFACE com.tito97.pacman.IRenderable */
		
		public function Update():void 
		{
			
		}
		
		public function Render(renderer:BitmapData):void 
		{
			renderer.copyPixels(mapBitmapData, mapBitmapData.rect, new Point(0, 0));
		}
		
		
		  /////////////////////////////////
		 // PROPERTY GETTERS AND SETTERS //
		//////////////////////////////////
		
		/**
		 * The number of rows in this map
		 */
		public function get numRows():int { return _numRows; }
		
		/**
		 * The number of columns of this map
		 */
		public function get numColumns():int { return _numColumns; }
		
		
		/**
		 * The map's width in pixels
		 */
		public function get width():Number { return tileArray.length * tileSize; }
		
		/**
		 * The maps's height in pixels
		 */
		public function get height():Number { return tileArray[0].length * tileSize; }
		
		
		  ///////////////////////
		 // PRIVATE FUNCTIONS //
		///////////////////////
		
		private function createMapTile(mapData:Array, x:int, y:int):Tile 
		{
			var data:uint = mapData[y][x];
			var tileClass:Class = mapCollection.tileClasses[data];
			return new tileClass();
		}
		
	}

}