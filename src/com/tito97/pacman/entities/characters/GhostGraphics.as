package com.tito97.pacman.entities.characters 
{
	import com.tito97.pacman.Game;
	import com.tito97.pacman.utilities.Directions;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Diogo
	 */
	public class GhostGraphics extends Sprite 
	{
		
		private const LEG_WIDTH:Number = 5;
		private const LEG_SPEED:Number = .5;
		
		public var color:uint;
		private var _direction:uint;
		
		private var animatedLegs:Shape;
		
		public function GhostGraphics(color:uint, direction:uint) 
		{
			this.color = color;
			this._direction = direction;
			
			x = Game.GRID_SIZE/2;
			y = Game.GRID_SIZE/2;
			
			drawGraphics();
		}
		
		public function changeEyesDirection(direction:uint):void 
		{
			this._direction = direction;
			drawGraphics();
		}
		
		private function drawGraphics():void 
		{
			var upperBody:Shape = new Shape();
			upperBody.graphics.beginFill(color);
			upperBody.graphics.drawCircle(0, 0, 10);
			upperBody.graphics.beginFill(color);
			upperBody.graphics.drawRect( -10, 0, 20, 7.5);
			
			// Desnhar os dois olhos do fantasma (o íris vai ser da cor do mesmo)
			var pupilDirection:Point = Directions.getSpeedCoords(_direction, 2);
			trace(_direction, pupilDirection);
			var leftEye:Shape = new Shape;
			leftEye.x = -7;
			leftEye.y = -5;
			leftEye.graphics.beginFill(0xFFFFFF);
			leftEye.graphics.drawEllipse(0, 0, 6, 7);
			leftEye.graphics.beginFill(0x3333FF);
			leftEye.graphics.drawEllipse(1.5+pupilDirection.x, 1.5+pupilDirection.y, 3, 4);
			var rightEye:Shape = new Shape();
			rightEye.graphics.copyFrom(leftEye.graphics);
			rightEye.x = 1;
			rightEye.y = -5;
			
			// Desenhar as "pernas" animadas do fantasma
			var lowerBody:Shape = new Shape();
			lowerBody.x = -10;
			lowerBody.y = 7.5;
			lowerBody.opaqueBackground = 0;
			lowerBody.graphics.beginFill(color);
			lowerBody.graphics.moveTo( -LEG_WIDTH, 0);
			for (var i:int = -1; i < 4; i++)
			{
				lowerBody.graphics.lineTo(LEG_WIDTH * i, 0);
				lowerBody.graphics.lineTo(LEG_WIDTH * i + LEG_WIDTH/2, LEG_WIDTH/2);
			}
			lowerBody.graphics.lineTo(20, 0);
			
			// Adicionar as "pernas" do fantasma a um DispplayObjectContainer com uma mask
			// de modo a que só as devidas partes sejam mostradas
			var bottomContainer:Sprite = new Sprite();
			bottomContainer.mask = new Shape();
			Shape(bottomContainer.mask).graphics.beginFill(0);
			Shape(bottomContainer.mask).graphics.drawRect( -10, 7.5, 20, 2.5);
			animatedLegs = bottomContainer.addChild(lowerBody) as Shape;
			
			this.addChild(upperBody);
			this.addChild(leftEye);
			this.addChild(rightEye);
			this.addChild(bottomContainer);
		}
		
		public function updateAnimation():void 
		{
			animatedLegs.x += LEG_SPEED;
			if (animatedLegs.x > -LEG_WIDTH)
			animatedLegs.x = -LEG_WIDTH*2 + LEG_SPEED;
		}
		
	}

}