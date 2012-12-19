package com.tito97.pacman.entities.characters 
{
	import avmplus.accessorXml;
	import com.tito97.pacman.entities.MovingCharacter;
	import com.tito97.pacman.Game;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.utilities.Directions;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Diogo
	 */
	public class Ghost extends MovingCharacter 
	{
		
		protected var color:uint;
		
		private var animatedLegs:Shape;
		
		private function get ghostGraphics():GhostGraphics { return GhostGraphics(image_sprite); }
		
		public function Ghost(startX:Number, startY:Number, width:Number, height:Number, color:uint, map:MapHandler, direction:uint = 0) 
		{
			super(startX, startY, width, height, map, direction);
			this.color = color;
			image_sprite = new GhostGraphics(color, direction);
			ghostGraphics.changeEyesDirection(Directions.RIGHT)
			trace(ghostGraphics.x);
		}
		
		override public function Update():void
		{
			ghostGraphics.updateAnimation();
		}
			
	}

}