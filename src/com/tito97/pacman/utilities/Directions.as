package com.tito97.pacman.utilities 
{
	import flash.geom.Point;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Diogo
	 */
	public class Directions 
	{
		public static const UP:uint = 1;
		public static const DOWN:uint = 2;
		public static const LEFT:uint = 3;
		public static const RIGHT:uint = 4;
		
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
		
		public static function getRandomDirection():void 
		{
			
		}
	}

}