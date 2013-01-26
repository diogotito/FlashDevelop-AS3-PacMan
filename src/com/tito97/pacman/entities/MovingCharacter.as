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
	 * Represents all the GameSprites that will have the hability to move in the game map.
	 * The game characters (Pac-Man, ghosts) may all extend this class.
	 * @author Diogo
	 */
	public class MovingCharacter extends GameSprite 
	{
		protected var _speed:Number;
		protected var _direction:uint;
		protected var _map:MapHandler;
		protected var _isAligned:Boolean;
		
		/**
		 * Constructs an instance of a MovingObject with the properties given
		 * @param	xTile The initial column for this instance
		 * @param	yTile The initial row for this instance
		 * @param	width The width of this character
		 * @param	height The height of this character
		 * @param	map The map that will guide this MovingObject
		 * @param	direction The initial direction for this MovingObject. The default value is 0 (the instance will remain stopped)
		 * @param	speed The initial direction for this MovingObject. The default value is 0 (this will stop this instance)
		 */
		public function MovingCharacter(xTile:int, yTile:int, width:Number, height:Number, map:MapHandler, direction:uint = 0, speed:Number = 0) 
		{
			super(xTile*map.tileSize, yTile*map.tileSize, width, height);
			this._speed = speed;
			this._direction = direction;
			this._map = map;
		}
		
		/**
		 * Determines the direction in which this character is moving
		 */
		public function get direction():uint 
		{
			return _direction;
		}
		public function set direction(value:uint):void 
		{
			if (value <= 4) _direction = value;
		}
		
		/**
		 * Returns this MovingCharacter's current column
		 */
		public function get column():int { return getTileCoord(x); }
		
		/**
		 * Returns this MovingCharacter's current row
		 */
		public function get row():int { return getTileCoord(y); }
		
		/**
		 * Returns the next tile where this instance is moving to
		 */
		public function get nextTile():Tile { return getNextTile(direction); }
		
		/**
		 * Move este MovingObject da acordo com a dada direção com a respetiva velocidade.
		 * Este método não alterará o valor da propriedade direction.
		 * @param	direction A direção para a qual o MovingObject se vai mover.
		 * @param	speed O número de pixels que o MovingObject se moverá na direção dada.
		 */
		/**
		 * Moves this MovingObject according with the given direction and speed.
		 * This method will be called by the public Update() function, which will pass this instance's
		 * current direction and speed to the this function.
		 * This method won't change the value of this instance's speed and direction.
		 * @param	direction
		 * @param	speed
		 */
		public function moveInDirection(direction:uint, speed:Number):void 
		{
			var speedCoords:Point = Directions.getSpeedCoords(direction, speed);
			this.x += speedCoords.x;
			this.y += speedCoords.y;
			
			this._isAligned = x % _map.tileSize == 0 && y % _map.tileSize == 0;
		}
		
		/**
		 * Returns the Tile which is below this instance's registry point
		 */
		public function get currentTile():Tile
		{
			return _map.getTile(row, column);
		}
		
		/**
		 * Returns a boolean value that indicates whether this MovingObject is aligned with the map tile grid.
		 */
		public function get isAligned():Boolean 
		{
			return _isAligned;
		}
		
		/**
		 * Indicates the speed of this MovingObject's motion.
		 * This property is always positive. If you set a negative value for this property, the
		 * direction of this instance will be reversed and the positive value will be stored instead.
		 */
		public function get speed():Number 
		{
			return _speed;
		}
		public function set speed(value:Number):void 
		{
			if (value > 0) 
			{
				_speed = value;
			}
			else if (value < 0) 
			{
				_speed = -value;
				_direction = Directions.getOpositeDirection(_direction);
			}
			else 
			{
				_direction = _speed = 0;
			}
		}

		/**
		 * Returns the tile next to this MovingObject instance according to the given direction .
		 * @param	direction The direction to get the next tile
		 * @return The tile which is next to this MovingObject according to rhe given direction.
		 */
		public function getNextTile(direction:uint):Tile 
		{
			var offset:Point = Directions.getSpeedCoords(direction);
			return _map.getTile(this.row + offset.y, this.column + offset.x);
		}
		
		/**
		 * Tests whether this MovingObject instance is out of the map, and, in that case, 
		 * moves it to the opposite bound from the one where it has left.
		 */
		public function makeWarp():void 
		{
			/*var gameRect:Rectangle = new Rectangle(
				-this.width + 1,
				-this.height + 1,
				_map.width + this.width - 2,
				_map.height + this.height - 2
			);
			
			if (x < gameRect.left)		x = gameRect.right	- 1;
			if (x > gameRect.right)		x = gameRect.left	+ 1;
			if (y < gameRect.top)		y = gameRect.bottom	- 0;
			if (y > gameRect.bottom)	y = gameRect.top	+ 1;*/
			
			if ( x <= -width && _direction == Directions.LEFT)
			{
				x = _map.width - _speed;
			}
			else if ( x >= _map.width && _direction == Directions.RIGHT)
			{
				x = -width + _speed;
			}	
				
			if ( y <= -height && _direction == Directions.UP) 
			{
				y = _map.height - _speed;
			}
			else if (y >= _map.height && _direction == Directions.DOWN)
			{
				y = -height + _speed;
			}
			
			
			//FIXME: Aperfeiçoar isto: Nota-se no modo keyboard_debug que o movimento de "warp" corta a perfeição da velocidade (pacMan.aligned em cada 20 frames)
		}
		
		/**
		 * Converts coordinates form the flash cooedinate system to our "tile" coordinate system.
		 * @param	n The flash coordinate number to convert
		 * @return The converted number corresponding with the tile which that number referred to
		 */
		protected function getTileCoord(n:Number):int 
		{
			return Math.floor(n / Game.GRID_SIZE);
		}
		
		protected function get m_isAligned():Boolean
		{
			return x % _map.tileSize == 0 && y % _map.tileSize == 0;
		}
		
	}

}