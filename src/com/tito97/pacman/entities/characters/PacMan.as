package com.tito97.pacman.entities.characters 
{
	import com.tito97.pacman.entities.MovingCharacter;
	import com.tito97.pacman.Game;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.utilities.Directions;
	import com.tito97.pacman.utilities.FPSCounter;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Represents the Pac-Man object, which should be controllable by the player.
	 * @author Diogo
	 */
	public class PacMan extends MovingCharacter 
	{
		/**
		 * The normal speed predefined for the Pac-Man
		 * ATENTION: This constant's value should be a divisor of Game.GRID_SIZE so that the Pac-Man can be
		 * perfectly aligned on every cell in the maps's grid.
		 */
		public static const SPEED:Number = 2;
		
		private const MOUTH_SPEED:Number = 4.5;
		
		private var _mouthOpening:Number = 0;
		private var _openingSpeed:Number = MOUTH_SPEED * 2;
		
		private var _nextDirection:uint;
		
		/**
		 * Constructs an instance for the Pac-Man object.
		 * After constructing it, the application should pass the direction that the player presses into the
		 * turnIntent() function so the Pac-Man can decide the best moment to turn on it.
		 * @param	startX The Pac-Man's starring column
		 * @param	startY The Pac-Man's starting row
		 * @param	map The map that will inidcate where the Pac-Man can be.
		 * @param	direction The Pac-Man's initial direction.
		 */
		public function PacMan(startX:Number, startY:Number, map:MapHandler, direction:uint) 
		{
			super(startX, startY, 20, 20, map, direction, SPEED);
			_nextDirection = direction;
			image_sprite = new Sprite();
			draw();
		}
		
		override public function Update():void 
		{
			move();
			animateMouth();
			draw();
			
			updateDebugInfo();
		}
		
		override public function Render(renderer:BitmapData):void 
		{
			var matrix:Matrix = new Matrix();
			matrix.rotate(Directions.getAngleFromDirection(direction));
			matrix.translate(x+width/2, y+height/2);
			renderer.draw(image_sprite, matrix);
		}
		
		/**
		 * Expresses the player's will to change the Pac-Man's direciton.
		 * This will be altered when the character is aligned with the grid by
		 * the Game.GRID_SIZE constant.
		 * NOTE: Nothing will happen if the player tries to turn the Pac-Man backwards!
		 * @param	direction The direction in which the player wants to turn the Pac-Man
		 * @throws Error This is thrown if the direction integer specified is out of the
		 * valid range [0;4]
		 */
		public function turnIntent(direction:uint):void 
		{
			if ( direction <= 4 )
			{
				if ( direction != Directions.getOpositeDirection(this.direction) ) 
				{
					_nextDirection = direction;
				}
			}
			else 
			{
				throw new Error("The value of \"direction\" is out of the valid range.");
			}
		}
		
		/**
		 * Moves the Pac-Man according to its direction
		 */
		private function move():void 
		{
			moveInDirection(direction, SPEED);
			makeWarp();
			
			if (this.m_isAligned && !this.getNextTile(_nextDirection).solid)
				this.direction = this._nextDirection;
			
			
			updateDebugInfo();
			
			//BUG: a variável _isAligned não está a ser atualizada devidamente, o que provoca problemas no WARP (private get _isAligned()?);
		}
		
		/**
		 * Animates the Pac-Man's mouth opening in degrees, according to the MOUTH_SPEED
		 * constant
		 */
		private function animateMouth():void 
		{
			if ( _mouthOpening + _openingSpeed > 90 )
			{
				_mouthOpening = 90;
				_openingSpeed = -MOUTH_SPEED * 2;
			}
			else if( _mouthOpening + _openingSpeed < -90 )
			{
				_mouthOpening = -90;
				_openingSpeed = MOUTH_SPEED * 2;
			}
			_mouthOpening += _openingSpeed;
		}
		
		/**
		 * Draws the Pac-Man's vectorial graphics in the image_sprite's graphics.
		 * These graphics will be affected by the _mouthOpening value.
		 */
		private function draw():void 
		{
			var dy:Number = 10 * Math.tan(_mouthOpening / 360 * Math.PI);
			image_sprite.graphics.clear();
			// Draw the yellow circular body
			image_sprite.graphics.beginFill(0xFFFF00);
			image_sprite.graphics.drawCircle(0, 0, 10);
			// Draw the triangular black mouth (probably the game's background color)
			// according to the _mouthOpening value (used to calculate dy).
			image_sprite.graphics.beginFill(0);
			image_sprite.graphics.moveTo(0, 0);
			image_sprite.graphics.lineTo(10, dy);
			image_sprite.graphics.lineTo(10, -dy);
			image_sprite.graphics.lineTo(0, 0);
			image_sprite.graphics.endFill();
		
		}
		
		/**
		 * Updates the debugging data to the live debugging field
		 */
		private function updateDebugInfo():void 
		{
			/*Game.textField.text =	"GAME object state:" + 
									"\n| FPS: " + FPSCounter.fpsString +
									"\n***" +
									"\nPAC-MAN object state:" +
									"\n| ROW: " + row + "; COL: " + column +
									"\n| x = " + x + "; y = " + y +
									"\n| Current Tile:\t.\t.\t.\t. " + currentTile + 
									"\n| Next Tile:\t.\t.\t.\t.\t. " + nextTile + 
									"\n| Current Direction:\t.\t.\t. " + Directions.getDirectionText(direction) + 
									"\n| Next Direction:\t.\t.\t. " + Directions.getDirectionText(_nextDirection) +
									"\n| Tile on next Direction:\t. " + getNextTile(_nextDirection) +
									"\n| is aligned? " + (_isAligned ? "Yes" : "No");*/
			Game.debugField.debugObjects["Pac-Man"] = {
				"1.POSITION: ":					new Point(x, y),
				"2.TILE: ": 					["ROW=" + row, " \tCOLUMN=" + column],
				"3.Current Tile: ":				currentTile,
				"4.Next Tile: ": 				nextTile,
				"5.Current Direction: ":		Directions.getDirectionText(direction),
				"6.Next Direction: ":			Directions.getDirectionText(_nextDirection),
				"7.Tile on next Direction: ":	getNextTile(_nextDirection),
				"8.is aligned? ":				(_isAligned ? "Yes" : "No")
			};
		
		}
		
	}

}