package com.tito97.pacman.utilities 
{
	import flash.geom.Point;
	import flash.ui.Keyboard;
	/**
	 * A class that offers static tools to work with the several motion directions that the MovingCharacters
	 * can take.
	 * @private PS:	By now, these directions are represented by unsigned integers from 0 to 4, but I'm planning
	 * 				to recreate this class so these directions can be treated like objects (just like the"structs"
	 * 				in C#, for example). I think I'll have to make use of the prototype valueOf() function, but I
	 * 				don't have any idea on how to achieve this in ActionScript 3.
	 * @author Diogo
	 */
	public class Directions 
	{
		public static const UP:uint = 1;
		public static const DOWN:uint = 2;
		public static const LEFT:uint = 3;
		public static const RIGHT:uint = 4;
		
		/**
		 * Returns the opposite direction from the given one
		 * @param	direction The direction in which to return its opposite one
		 * @return The opposite direction from the given one
		 */
		public static function getOpositeDirection(direction:uint):uint
		{
			switch (direction) 
			{
				case UP:
					return DOWN;
				break;
				case DOWN:
					return UP;
				break;
				case LEFT:
					return RIGHT;
				break;
				case RIGHT:
					return LEFT;
				break;
				default:
					return 0;
				break;
			}
		}
		
		/**
		 * Gets the text that represents the given direction (the first letter is capitalized)
		 * @param	direction The direction number to return its text
		 * @return The text representatation of the given direction
		 */
		public static function getDirectionText(direction:uint):String
		{
			switch (direction) 
			{
				case UP:
					return "Up";
				break;
				case DOWN:
					return "Down";
				break;
				case LEFT:
					return "Left";
				break;
				case RIGHT:
					return "Right";
				break;
				default:
					return "";
				break;
			}
		}
		
		/**
		 * Calculates the rotation value (in radians) of the given direction.
		 * @param	direction
		 * @return The rotation value in radians of the given direction
		 */
		public static function getAngleFromDirection(direction:uint):Number
		{
			switch (direction) 
			{
				case UP:
					return Math.PI * 1.5;
				break;
				case DOWN:
					return Math.PI * .5;
				break;
				case LEFT:
					return Math.PI;
				break;
				case RIGHT:
					return 0;
				break;
				default:
					return 0;
				break;
			}
		}
		
		/**
		 * Returns the speed coordinates of the given direction with a certain lenght
		 * @param	direction The direction number to get the speed coordinates
		 * @param	speed The lenght (in pixels) of the speed vector.
		 * @return A Point object that stores the speed coordinates in the respective properties.
		 */
		public static function getSpeedCoords(direction:uint, speed:Number = 1):Point 
		{
			switch (direction) 
			{
				case UP:
					return new Point(0, -speed);
				break;
				case DOWN:
					return new Point(0, speed);
				break;
				case LEFT:
					return new Point( -speed, 0);
				break;
				case RIGHT:
					return new Point( speed, 0);
				break;
				default:
					return new Point(0, 0);
				break;
			}
		}
		
		/**
		 * Returns the direction associated with the keyCode of a KeyboardEvent
		 * @param	keyCode The representation of the key pressed by the player
		 * @return The representation of the direction associated with that key
		 */
		public static function getDirectionByKeyCode(keyCode:uint):uint
		{
			switch(keyCode)
			{
				case Keyboard.UP:
					return Directions.UP;
				break;
				case Keyboard.DOWN:
					return Directions.DOWN;
				break;
				case Keyboard.LEFT:
					return Directions.LEFT;
				break;
				case Keyboard.RIGHT:
					return Directions.RIGHT;
				break;
				default:
					return 0;
				break;
			}
		}
		
		/**
		 * Returns a random direction
		 * @param	includeStop A Boolean that indicates whether it should be possible to return the
		 * 0 direction number (stopped).
		 * be returned
		 * @return The random direction calculated
		 */
		public static function getRandomDirection(includeStop:Boolean = false):uint 
		{
			return includeStop ? 
				Math.floor( Math.random() * 5 - 1 ) :
				Math.floor( Math.random() * 4 );
		}
	}

}