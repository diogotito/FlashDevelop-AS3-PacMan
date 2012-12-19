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
	 * ...
	 * @author Diogo
	 */
	public class MapHandler implements IRenderable
	{
		
		public var mapBitmapData:BitmapData;
		public var tileArray:Vector.<Vector.<Tile>>;
		
		private var mapCollection:Maps;
		private var _mapData:Array;
		
		private var _numColumns:uint;
		private var _numRows:uint;
		public var tileSize:Number;
		
		private var tileRect:Rectangle;
		
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
		
		public function getTile(row:int, column:int):Tile 
		{
			while (row < 0 || row >= _numRows)
				row = _numRows - Math.abs(row);
			while (column < 0 || column >= numColumns)
				column = _numColumns- Math.abs(column);
			return tileArray[row][column];
		}
		
		public function getRow(row:int):Vector.<Tile> 
		{
			return tileArray[row];
		}
		
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
		
		public function get numRows():int { return _numRows; }
		
		public function get numColumns():int { return _numColumns; }
		
		public function get width():Number { return tileArray.length * tileSize; }
		
		public function get height():Number { return tileArray[0].length * tileSize; }
		
		private function createMapTile(mapData:Array, x:int, y:int):Tile 
		{
			var data:uint = mapData[y][x];
			var tileClass:Class = mapCollection.tileClasses[data];
			return new tileClass();
		}
		
	}

}