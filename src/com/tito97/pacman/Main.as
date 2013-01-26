package com.tito97.pacman
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	//TODO: reorganizar o sistema de coordenadas deste jogo de modo a que eu possa colocar os gráficos do mapa numa localzação diferente de (0,0), sem que isso altere as coordenadas da posição dos respetivos MovingObjects
	
	/**
	 * This is the document class, which is going to contain the stage and a Game instance.
	 * It also listens to some input events to call the respective Game object functions.
	 * @author Diogo
	 */
	public class Main extends Sprite 
	{
		private var game:Game;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		/**
		 * The program's entry point
		 * @param	e An optional Event argument in case this function is called by an event listener
		 */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// :::ENTRY POINT:::
			
			// Creates a new Game instance
			game = new Game(stage.stageWidth, stage.stageHeight);
			
			// Adds the game's bitmap, where the graphics are rendered on every frame
			addChild(game.bitmap);
			
			// Creates the game main loop
			addEventListener(Event.ENTER_FRAME, Run);
			
			// This defines the program's behaviour in case we are debugging the game
			// with a special debugging mode, defined in the project's compiler constants.
			CONFIG::debug
			{
				DEBUG::keyboard_loop
				{
					removeEventListener(Event.ENTER_FRAME, Run);
					stage.addEventListener(MouseEvent.CLICK, Run);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyRun);
					game.Render();
				}
			}
			
			// Listens to the keyboard input and passes it to the game's onKeyDown Function
			stage.addEventListener(KeyboardEvent.KEY_DOWN, game.onKeyDown);
		}
		
		CONFIG::debug
		{
			DEBUG::keyboard_loop
			/**
			 * In the "keyboard_loop=true" mode, each key press will call the game's main
			 * routine to update it and finally render its respective bitmap.
			 * @param	e
			 */
			private function KeyRun(e:KeyboardEvent):void 
			{
				for (var i:int = 0; i < 10; i++)
					game.Update();
				game.Render();
			}
		}
		
		private function Run(e:Event):void 
		{
			game.Update();
			game.Render();
		}
		
	}
	
}