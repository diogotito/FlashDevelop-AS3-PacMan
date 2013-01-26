package com.tito97.pacman.entities 
{
	import com.tito97.pacman.entities.MovingCharacter;
	import com.tito97.pacman.Game;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.utilities.Directions;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	/**
	 * This class defines the behaviour of the ghosts in this game. They will try to chase Pac-Man until he's touched.
	 * @author Diogo
	 */
	public class Ghost extends MovingCharacter 
	{
		
		/**
		 * The ghost color
		 */
		protected var color:uint;
		
		//private function get ghostGraphics():GhostGraphics { return GhostGraphics(image_sprite); }
		protected var ghostGraphics:GhostGraphics;
		
		/**
		 * Constructs a Ghost instance
		 * @param	startX The starting column for this instance
		 * @param	startY The starting row for this instance
		 * @param	width The width of this ghost
		 * @param	height The height of this Ghost
		 * @param	color The color of this Ghost
		 * @param	map The map that will guide this Ghost
		 * @param	direction The initial direction for this Ghost
		 */
		public function Ghost(startX:Number, startY:Number, width:Number, height:Number, color:uint, map:MapHandler, direction:uint = 0) 
		{
			super(startX, startY, width, height, map, direction);
			this.color = color;
			image_sprite = new GhostGraphics(color, direction);
			ghostGraphics = GhostGraphics(image_sprite);
			ghostGraphics.changeEyesDirection(Directions.RIGHT)
			trace(ghostGraphics.x);
		}
		
		override public function Update():void
		{
			ghostGraphics.updateAnimation();
		}
			
	}

}