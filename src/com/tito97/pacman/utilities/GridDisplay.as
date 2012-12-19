package com.tito97.pacman.utilities
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Diogo
	 */
	public class GridDisplay 
	{
		public var grid_bitmapData:BitmapData;
		
		private var grid_shape:Shape;
		
		private var cellSize:Number;
		private var height:Number;
		private var width:Number;
		
		public function GridDisplay(width:Number, height:Number, cellSize:Number)
		{
			this.width = width;
			this.height = height;
			this.cellSize = cellSize;
			
			grid_bitmapData = new BitmapData(width, height, false, 0);
			drawGrid();
		}
		
		/**
		 * Draws the grid into the grid_sprite
		 */
		private function drawGrid():void 
		{
			grid_shape = new Shape();
			grid_shape.graphics.lineStyle(1, 0x888888);
			
			for (var i:Number = 0, j:Number = 0;
				i <= height, j <= width;
				i += cellSize, j += cellSize)
			{
				// Desenhar linha horizontal
				grid_shape.graphics.moveTo(0, i);
				grid_shape.graphics.lineTo(width, i);
				// Desenhar linha vertical
				grid_shape.graphics.moveTo(j, 0);
				grid_shape.graphics.lineTo(j, height);
			}
			// Renderizar a grelha desenhada acima para um mapa de bits,
			// de modo a que não tenhamos que renderizá-la em cada frame
			grid_bitmapData.draw(grid_shape);
		}
	
	}

}