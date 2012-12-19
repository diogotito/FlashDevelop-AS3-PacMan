package com.tito97.pacman.ui 
{
	import com.tito97.pacman.IRenderable;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Diogo
	 */
	public class UI_Element implements IRenderable
	{
		public var border:Boolean;
		public var border_color:uint;
		public var borderSize:Number;
		
		public var x:Number;
		public var y:Number;
		public var width:int;
		public var height:int;
 
		public var opaqueBackground:Boolean = false;
		public var bg_color:uint;
 
		public var visible:Boolean;
 
		public var image:BitmapData;
 
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
		
		protected function renderGraphics():void 
		{
			
		}
		
		public function Update():void
		{
			
		}	
			
	}

}