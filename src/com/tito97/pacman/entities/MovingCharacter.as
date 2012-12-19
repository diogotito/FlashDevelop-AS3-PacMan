package com.tito97.pacman.entities 
{
	import com.tito97.pacman.Game;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.maps.tiles.Tile;
	import com.tito97.pacman.utilities.Directions;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Diogo
	 */
	
	//TODO: Evitar com que um MovingObject possa andar na faixa COLUMN=numColumns sem que ocorra "warp"
	
	public class MovingCharacter extends GameSprite 
	{
		protected var _direction:uint;
		protected var _map:MapHandler;
		protected var _isAligned:Boolean;
		
		public function MovingCharacter(xTile:int, yTile:int, width:Number, height:Number, map:MapHandler, direction:uint=0) 
		{
			super(xTile*map.tileSize, yTile*map.tileSize, width, height);
			this._direction = direction;
			this._map = map;
		}
		
		public function get direction():uint 
		{
			return _direction;
		}
		
		public function set direction(value:uint):void 
		{
			if (value <= 4) _direction = value;
		}
		
		public function get column():int { return getTileCoord(x); }
		
		public function get row():int { return getTileCoord(y); }
		
		public function get nextTile():Tile { return getNextTile(direction); }
				
		public function moveInDirection(direction:uint, speed:Number):void 
		{
			var speedCoords:Point = Directions.getSpeedCoords(direction, speed);
			this.x += speedCoords.x;
			this.y += speedCoords.y;
			
			this._isAligned = x % _map.tileSize == 0 && y % _map.tileSize == 0;
		}
		
		public function get currentTile():Tile
		{
			return _map.getTile(row, column);
		}
		
		public function get isAligned():Boolean 
		{
			return _isAligned;
		}
		
		public function getNextTile(direction:uint):Tile 
		{
			var offset:Point = Directions.getSpeedCoords(direction);
			return _map.getTile(this.row + offset.y, this.column + offset.x);
		}
		
		public function makeWarp():void 
		{
			var gameRect:Rectangle = new Rectangle(
				-this.width + 1,
				-this.height + 1,
				_map.width + this.width,
				_map.height + this.height
			);
			
			if (x < gameRect.left)		x = gameRect.right	- 1;
			if (x > gameRect.right)		x = gameRect.left	+ 1;
			if (y < gameRect.top)		y = gameRect.bottom	- 1;
			if (y > gameRect.bottom)	y = gameRect.top	+ 1;
		}
		
		protected function getTileCoord(n:Number):int 
		{
			return Math.floor(n / Game.GRID_SIZE);
		}
		
	}

}