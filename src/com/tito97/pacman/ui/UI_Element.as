package com.tito97.pacman.ui 
{
	import com.tito97.pacman.IRenderable;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Esta é a class base de todos os elementos da interface do utilizador
	 * Esta class deverá ser extendida por elementos como o mostrador de pontuação, 
	 * a caixa de depuração, os botões do menú, o menú de pausa, etc.
	 * @author Diogo
	 */
	public class UI_Element implements IRenderable
	{
		/**
		 * Determines whether this element has a visible border
		 */
		public var border:Boolean;
		/**
		 * Determines the border's color
		 */
		public var border_color:uint;
		/**
		 * Determines the border's size in pixels
		 */
		public var borderSize:Number;
		
		/**
		 * Determines the position of this element on the X axis
		 */
		public var x:Number;
		/**
		 * Determines the position of this element on the Y axis
		 */
		public var y:Number;
		/**
		 * Determines the width of this element
		 */
		public var width:int;
		/**
		 * Determines the height of this element
		 */
		public var height:int;
		
		/**
		 * Determines whether this element has an opaque background
		 */
		public var opaqueBackground:Boolean = false;
		/**
		 * Determines the color of the opaque background that will fill this element when the
		 * opaqueBackground property is set to true
		 */
		public var bg_color:uint;
		
		/**
		 * Determines whether this element will be rendered on the next frame.
		 */
		public var visible:Boolean;
		
		/**
		 * The BitmapData that will graphically represent this element
		 */
		public var image:BitmapData;
		
		/**
		 * Constructs an UI_Element instance
		 * @private This class isn't meant to be instantiated directly. Use one its subclasses instead
		 * @param	x Determines the position of this element on the X axis
		 * @param	y Determines the position of this element on the Y axis
		 * @param	width Determines the width of this element
		 * @param	height Determines the height of this element
		 * @param	opaqueBackground Determines whether this element has an opaque background
		 * @param	bg_color Determines the color of the opaque background that will fill this element when the
		 * opaqueBackground property is set to true
		 * @param	border Determines whether this element has a visible border
		 * @param	border_color Determines the color of the border
		 * @param	borderSize Determines the size o the border in pixels
		 */
		public function UI_Element (x:Number = 0, y:Number = 0, width:int = 10, height:int = 10,
									opaqueBackground:Boolean = true, bg_color:uint = 0x888888,
									border:Boolean=false, border_color:uint=0xFFFFFF, borderSize:Number = 1)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.opaqueBackground = opaqueBackground;
			this.bg_color = bg_color;
			this.border = border;
			this.border_color = border_color;
			this.borderSize = borderSize;
			this.visible = true;
			
			if (opaqueBackground)
				image = new BitmapData(width, height, false, bg_color);
			else
				image = new BitmapData(width, height, true, bg_color);
		}
		
		/* INTERFACE com.tito97.pacman.IRenderable */
		
		public function Render(Renderer:BitmapData):void
		{
			if (!visible)
				return;
 
			//if (opaqueBackground)
				//image.fillRect(new Rectangle(0, 0, width, height), bg_color);
			
			if (border) 
			{
				image.fillRect(new Rectangle(0, 0, width, borderSize), border_color);
				image.fillRect(new Rectangle(width-borderSize, 0, borderSize, height), border_color);
				image.fillRect(new Rectangle(0, height-borderSize, width, borderSize), border_color);
				image.fillRect(new Rectangle(0, 0, borderSize, height), border_color);
			}
			
			renderGraphics();
			
			Renderer.copyPixels(image, new Rectangle(0, 0, width, height), new Point(x, y));
		}
		
		/**
		 * Override this function to define the behaviour on how the rest of the graphics should be rendered.
		 * These do not include the background and the border of this element.
		 */
		protected function renderGraphics():void 
		{
			
		}
		
		public function Update():void
		{
			
		}	
			
	}

}