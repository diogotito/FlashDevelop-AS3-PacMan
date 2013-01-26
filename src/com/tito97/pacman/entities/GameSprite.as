package com.tito97.pacman.entities 
{
	import com.tito97.pacman.Game;
	import com.tito97.pacman.IRenderable;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	/**
	 * This is the base class for all the objects that can be displayed on the screen.
	 * @author Diogo
	 */
	public class GameSprite implements IRenderable
	{
		/**
		 * The position of the GameSprite on the X axis
		 */
		public var x:Number;
		/**
		 * The position of the GameSprite on the Y axis
		 */
		public var y:Number;
		/**
		 * The width of the GameSprite.
		 */
		public var width:Number;
		/**
		 * The heigth of the GameSprite.
		 */
		public var height:Number;
		
		protected var image:BitmapData;
		protected var image_sprite:Sprite;
		
		/**
		 * Constrtucts a GameSprite instance
		 * @param	x The position of the GameSprite on the X axis
		 * @param	y The position of the GameSprite on the Y axis
		 * @param	width The width of the GameSprite.
		 * @param	height The heigth of the GameSprite.
		 */
		public function GameSprite(x:Number, y:Number, width:Number, height:Number) 
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		/**
		 * This function will render the visual contents of this GameSprite into the given BitmapData.
		 * @param	renderer The BitmapData surface to render the visual contents from this GameSprite
		 */
		public function Render(renderer:BitmapData):void {
			var matrix:Matrix = new Matrix();
			matrix.translate(x + image_sprite.x, y + image_sprite.y);
			renderer.draw(image_sprite, matrix);
		}
		
		public function Update():void { /* [OVERRIDE] */ }
		
	}

}