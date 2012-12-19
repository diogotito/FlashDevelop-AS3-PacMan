package com.tito97.pacman.entities.characters 
{
	import com.tito97.pacman.entities.MovingCharacter;
	import com.tito97.pacman.Game;
	import com.tito97.pacman.maps.MapHandler;
	import com.tito97.pacman.utilities.Directions;
	import com.tito97.pacman.utilities.FPSCounter;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Diogo
	 */
	public class PacMan extends MovingCharacter 
	{
		
		public static const SPEED:Number = 2;
		
		private const MOUTH_SPEED:Number = 4.5;
		
		private var _mouthOpening:Number = 0;
		private var _openingSpeed:Number = MOUTH_SPEED * 2;
		
		private var _nextDirection:uint;
		
		public function PacMan(startX:Number, startY:Number, map:MapHandler, direction:uint) 
		{
			super(startX, startY, 20, 20, map, direction);
			_nextDirection = direction;
			image_sprite = new Sprite();
			draw();
		}
		
		override public function Render():void 
		{
			var matrix:Matrix = new Matrix();
			matrix.rotate(Directions.getAngleFromDirection(direction));
			matrix.translate(x+width/2, y+height/2);
			Game.Renderer.draw(image_sprite, matrix);
		}
		
		/**
		 * Expressa a vontade do jogador de alterar a direção do Pac-Man.
		 * A mesma será alterada quando o Pac-Man estiver alinhado com a grelha
		 * especificada pela constante Game.GRID_SIZE.
		 * @param	direction
		 * A direção para qual o jogador quererá virar o Pac-Man.
		 * Um erro será disparado se o valor da direção estiver fora do intervalo válido
		 * (0-4).
		 * Nada acontecerá se o jogador tentar virar o Pac-Man para trás (180º), pois isso
		 * tiraria parte da piada deste jogo.
		 */
		public function turnIntent(direction:uint):void 
		{
			if ( direction <= 4 )
			{
				if ( direction != Directions.getOpositeDirection(this.direction) ) 
				{
					_nextDirection = direction;
				}
			}
			else 
			{
				throw new Error("O valor de \"direction\" está fora do intervalo válido.");
			}
		}
		
		override public function Update():void 
		{
			move();
			animateMouth();
			draw();
			
			updateDebugInfo();
		}
		
		/**
		 * Mover o Pac-Man de acordo com a sua direção atual
		 */
		private function move():void 
		{
			moveInDirection(direction, SPEED);
			makeWarp();
			if (this._isAligned && !this.getNextTile(_nextDirection).solid)
				this.direction = this._nextDirection;
			
			
			updateDebugInfo();}

		/**
		 * Alterar a abertura da sua boca em função do dobro da velocidade do Pac-Man
		 */
		private function animateMouth():void 
		{
			if ( _mouthOpening + _openingSpeed > 90 )
			{
				_mouthOpening = 90;
				_openingSpeed = -MOUTH_SPEED * 2;
			}
			else if( _mouthOpening + _openingSpeed < -90 )
			{
				_mouthOpening = -90;
				_openingSpeed = MOUTH_SPEED * 2;
			}
			_mouthOpening += _openingSpeed;
		}
		
		/**
		 * Desenha os gráficos vectoriais do Pac-Man
		 */
		private function draw():void 
		{
			var dy:Number = 10 * Math.tan(_mouthOpening / 360 * Math.PI);
			image_sprite.graphics.clear();
			// Desenhar o corpo circular amarelo
			image_sprite.graphics.beginFill(0xFFFF00);
			image_sprite.graphics.drawCircle(0, 0, 10);
			// Desenhar a boca triangular preta (da cor do funcdo) de acordo com
			// um determinado ângulo, usando trigonometria.
			image_sprite.graphics.beginFill(0);
			image_sprite.graphics.moveTo(0, 0);
			image_sprite.graphics.lineTo(10, dy);
			image_sprite.graphics.lineTo(10, -dy);
			image_sprite.graphics.lineTo(0, 0);
			image_sprite.graphics.endFill();
		
		}
		
		private function updateDebugInfo():void 
		{
			/*Game.textField.text =	"GAME object state:" + 
									"\n| FPS: " + FPSCounter.fpsString +
									"\n***" +
									"\nPAC-MAN object state:" +
									"\n| ROW: " + row + "; COL: " + column +
									"\n| x = " + x + "; y = " + y +
									"\n| Current Tile:\t.\t.\t.\t. " + currentTile + 
									"\n| Next Tile:\t.\t.\t.\t.\t. " + nextTile + 
									"\n| Current Direction:\t.\t.\t. " + Directions.getDirectionText(direction) + 
									"\n| Next Direction:\t.\t.\t. " + Directions.getDirectionText(_nextDirection) +
									"\n| Tile on next Direction:\t. " + getNextTile(_nextDirection) +
									"\n| is aligned? " + (_isAligned ? "Yes" : "No");*/
			Game.debugField.debugObjects["Pac-Man"] = {
				"1.POSITION: ": new Point(x, y),
				"2.TILE: ": ["ROW=" + row, "COLUMN=" + column],
				"3.Current Tile: ": currentTile,
				"4.Next Tile: ": nextTile,
				"5.Current Direction: ": Directions.getDirectionText(direction),
				"6.Next Direction: ": Directions.getDirectionText(_nextDirection),
				"7.Tile on next Direction: ": getNextTile(_nextDirection),
				"8.is aligned? ": (_isAligned ? "Yes" : "No")
			};
		
		}
		
	}

}