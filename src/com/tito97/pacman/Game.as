package com.tito97.pacman 
{
	import com.tito97.pacman.entities.Ghost;
	import com.tito97.pacman.entities.characters.PacMan;
	import com.tito97.pacman.entities.characters.StupidGhost;
	import com.tito97.pacman.entities.Ghost;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.utilities.DebugField;
	import com.tito97.pacman.utilities.Directions;
	import com.tito97.pacman.utilities.FPSCounter;
	import com.tito97.pacman.utilities.GridDisplay;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	/**
	 * This is the Game's class
	 * @author Diogo
	 */
	public class Game 
	{
		public static const GRID_SIZE:Number = 20;
		
		/**
		 * The game's main renderer, where all the visual objects will be rendered and displayed on the screen
		 */
		public static var Renderer:BitmapData
		public var bitmap:Bitmap;
		
		/**
		 * Will hold the game levels and will give an encapsulated access the loaded one
		 */
		public static var mapHandler:MapHandler;
		
		/**
		 * A grid that facilitates the alignment of the visual objects in the game
		 */
		private var grid:GridDisplay;
		
		/**
		 * The game's PacMan instance that the player will control
		 */
		private var pacMan:PacMan;
		/**
		 * An Array that will contain all the Ghost instances
		 */ 
		private var ghosts:Array;
		
		/**
		 * An object that represents a text field that will help in a "live" debugging.
		 */
		public static var debugField:DebugField;
		
		/**
		 * The constructor of the game's instance
		 * @param	width - The game's width - should be equivalent to the stage's width
		 * @param	height - The game's height - should be equivalent to the stage's height
		 */
		public function Game(width:Number, height:Number) 
		{
			// Initializes the game's renderer
			Renderer = new BitmapData(width, height, false, 0);
			bitmap = new Bitmap(Renderer);
			
			// Initializes the game's MapHandler instance, loading its first level
			mapHandler = new MapHandler(GRID_SIZE, 20, 20);
			mapHandler.loadLevelData(1);
			
			grid = new GridDisplay(width, height, GRID_SIZE);
			
			pacMan = new PacMan(1, 1, mapHandler, Directions.RIGHT);
			ghosts = new Array(new StupidGhost(22, 6, mapHandler, Directions.LEFT));
			
			debugField = new DebugField(420, 20, 360, 380);
		}
		
		/**
		 * This function manages the player's keyboard input in order to control the Pac-Man
		 * You should call this function in a KeyboardEvent listener.
		 * @param	event The KeyBoardEvent from the player's input
		 */
		public function onKeyDown(event:KeyboardEvent):void 
		{
			switch (event.keyCode) 
			{
				case Keyboard.UP:
					pacMan.turnIntent(Directions.UP);
				break;
				case Keyboard.DOWN:
					pacMan.turnIntent(Directions.DOWN);
				break;
				case Keyboard.LEFT:
					pacMan.turnIntent(Directions.LEFT);
				break;
				case Keyboard.RIGHT:
					pacMan.turnIntent(Directions.RIGHT);
				break;
				case Keyboard.P:
					//AFAZER: Pausar o jogo
				break;
			}
		}
		
		/**
		 * This function will render all the visual objects of the game into its main renderer.
		 */
		public function Render():void
		{
			var gameRect:Rectangle = new Rectangle(0, 0, Renderer.width, Renderer.height);
			
			Renderer.lock();
			
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0);
			
			// [OPTIONAL] Renders the grid
			Renderer.copyPixels(grid.grid_bitmapData, gameRect, new Point(0, 0));
			
			Renderer.copyPixels(mapHandler.mapBitmapData, mapHandler.mapBitmapData.rect, new Point(0, 0));
			
			// Renders the main characters
			pacMan.Render(Renderer);
			for each(var ghost:Ghost in ghosts)
				ghost.Render(Renderer);
			
			// [OPTIONAL] Renders the debug field
			debugField.Render(Renderer);
			
			Renderer.unlock();
		}
		
		/**
		 * This function will update all the game's objects state.
		 * Should be called on each frame.
		 */
		public function Update():void 
		{
			pacMan.Update();
			for each(var ghost:Ghost in ghosts) ghost.Update();
			FPSCounter.Update();
			debugField.Update();
			updateDebugInfo();
		}
		
		/**
		 * [OPTIONAL] Adds the number of FPS to the debug field's debug data.
		 */
		private function updateDebugInfo():void 
		{
			debugField.debugObjects.Game = {
				"FPS: ": FPSCounter.fpsString
			}
		}
				
	}

}