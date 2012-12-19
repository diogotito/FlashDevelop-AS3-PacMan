package com.tito97.pacman.entities 
{
	import com.tito97.pacman.Game;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Diogo
	 */
	public class GameSprite 
	{
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		protected var image:BitmapData;
		protected var image_sprite:Sprite;
		
		public function GameSprite(x:Number, y:Number, width:Number, height:Number) 
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		public function Render():void {
			var matrix:Matrix = new Matrix();
			matrix.translate(x+image_sprite.x, y+image_sprite.y);
			Game.Renderer.draw(image_sprite, matrix);
		}
		
		public function Update():void { /* Fazer override desta funcção nas subclasses*/ }
		
	}

}