package com.tito97.pacman.utilities
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Shape;
	
	/**
	 * [OPTIONAL CLASS]
	 * This class will show a grid to help in the alignment of visual objects while debugging
	 * @author Diogo
	 */
	public class GridDisplay 
	{
		/**
		 * Holds the bitmap data of the grid to be copied to the main renderer
		 */
		public var grid_bitmapData:BitmapData;
		
		private var grid_shape:Shape;
		
		private var cellSize:Number;
		private var height:Number;
		private var width:Number;
		
		/**
		 * The constructor for this class, which initializes the grid's bitmap data and draws the grid on it.
		 * @param	width - determines the width of the grid. Do not confuse this with the number of columns.
		 * @param	height - determines the height of the grid. Do not confuse this with the number of rows.
		 * @param	cellSize - determines the size (width and height) of each cell.
		 */
		public function GridDisplay(width:Number, height:Number, cellSize:Number)
		{
			this.width = width;
			this.height = height;
			this.cellSize = cellSize;
			
			grid_bitmapData = new BitmapData(width, height, false, 0);
			drawGrid();
		}
		
		/**
		 * Draws the grid on a Shape through vectorial commands and then renders it into the
		 * grid's bitmap data.
		 */
		private function drawGrid():void 
		{
			grid_shape = new Shape();
			grid_shape.graphics.lineStyle(1, 0x888888);
			
			for (var i:Number = 0, j:Number = 0;
				i <= height, j <= width;
				i += cellSize, j += cellSize)
			{
				// Draws a horizontal line
				grid_shape.graphics.moveTo(0, i);
				grid_shape.graphics.lineTo(width, i);
				// Draws a vertical line
				grid_shape.graphics.moveTo(j, 0);
				grid_shape.graphics.lineTo(j, height);
			}
			// Renders the vectors to a BitmapData instace to be passed in a copyPixels() call
			grid_bitmapData.draw(grid_shape);
		}
	
	}

}