package com.tito97.pacman 
{
	import com.tito97.pacman.Entities.*;
	import com.tito97.pacman.entities.characters.Ghost;
	import com.tito97.pacman.entities.characters.PacMan;
	import com.tito97.pacman.entities.characters.StupidGhost;
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
	 * ...
	 * @author Diogo
	 */
	public class Game 
	{
		public static const GRID_SIZE:Number = 20;
		
		public var bitmap:Bitmap;
		public static var Renderer:BitmapData
		
		public static var mapHandler:MapHandler;
		private var grid:GridDisplay;
		
		private var pacMan:PacMan;
		private var ghosts:Array;
		
		public static var debugField:DebugField;
		
		public function Game(width:Number, height:Number) 
		{
			Renderer = new BitmapData(width, height, false, 0);
			bitmap = new Bitmap(Renderer);
			
			mapHandler = new MapHandler(GRID_SIZE, 20, 20);
			mapHandler.loadLevelData(1);
			trace(mapHandler.height);
			
			grid = new GridDisplay(width, height, GRID_SIZE);
			
			pacMan = new PacMan(1, 1, mapHandler, Directions.RIGHT);
			ghosts = new Array(new StupidGhost(22, 6, mapHandler, Directions.LEFT));
			
			debugField = new DebugField(420, 20, 360, 380);
		}
		
		/* KeyboardEvent Listeners */
		
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
		
		public function Render():void
		{
			var gameRect:Rectangle = new Rectangle(0, 0, Renderer.width, Renderer.height);
			
			Renderer.lock();
			
			// Preenche a superfície de jogo com preto (a cor do fundo)
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0);
			
			// Desenha uma grelha auxiliar
			Renderer.copyPixels(grid.grid_bitmapData, gameRect, new Point(0, 0));
			
			// Desenha o mapa do nível
			Renderer.copyPixels(mapHandler.mapBitmapData, mapHandler.mapBitmapData.rect, new Point(0, 0));
			
			// Renderizar as personagens
			pacMan.Render();
			for each(var ghost:Ghost in ghosts) ghost.Render();
			
			// Desenha a caixa de texto
			debugField.Render(Renderer);
			
			Renderer.unlock();
		}
		
		public function Update():void 
		{
			pacMan.Update();
			for each(var ghost:Ghost in ghosts) ghost.Update();
			FPSCounter.Update();
			debugField.Update();
			updateDebugInfo();
		}
		
		private function updateDebugInfo():void 
		{
			debugField.debugObjects.Game = {
				"FPS: ": FPSCounter.fpsString
			}
		}
				
	}

}