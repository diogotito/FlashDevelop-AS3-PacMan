package com.tito97.pacman
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	//TODO: reorganizar o sistema de coordenadas deste jogo de modo a que eu possa colocar os gráficos do mapa numa localzação diferente de (0,0), sem que isso altere as coordenadas da posição dos respetivos MovingObjects
	
	/**
	 * ...
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
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Criar uma nova instância do jogo
			game = new Game(stage.stageWidth, stage.stageHeight);
			
			// Adicionar o mapa de bits do jogo
			addChild(game.bitmap);
			
			// Criar o "loop" do jogo
			addEventListener(Event.ENTER_FRAME, Run);
			
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
			
			// Escutar os eventos de teclado necessários à jogabilidade do jogo:
			stage.addEventListener(KeyboardEvent.KEY_DOWN, game.onKeyDown);
		}
		
		CONFIG::debug
		{
			DEBUG::keyboard_loop
			private function KeyRun(e:KeyboardEvent):void 
			{
				for (var i:int = 0; i < 10; i++) Run(e);
				
			}
		}
		
		private function Run(e:Event):void 
		{
			game.Update();
			game.Render();
		}
		
	}
	
}