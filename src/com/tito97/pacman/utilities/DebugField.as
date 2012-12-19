package com.tito97.pacman.utilities 
{
	import com.tito97.pacman.Game;
	import com.tito97.pacman.ui.UI_Element;
	import flash.display.BitmapData;
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Diogo
	 */
	public class DebugField extends UI_Element 
	{
		static private const END_TEXT:String = "***End***";
		static private const CHARS_PER_LINE:Number = 50; // Na verdade é 49
		
		private var textField:TextField;
		private var headerText:String = getHeaderText("WTF_DEBUG_CONSOLE", ":");
		
		public var debugObjects:Object;
		
		public function DebugField(x:Number, y:Number, width:Number, height:Number) 
		{
			super(x, y, width, height, true, 0, true, 0xCCCCCC, 1);
			debugObjects = {};
			textField = new TextField();
			textField.width = width - borderSize*2-2;
			textField.height = height - borderSize*2-2;
			textField.defaultTextFormat = new TextFormat("Consolas");
			textField.opaqueBackground = 0;
			textField.textColor = 0xFFFFFF;
			textField.text = "";
		}
		
		public function get text():String 
		{
			return textField.text.substr(textField.text.indexOf(END_TEXT)+END_TEXT.length);
		}
		
		public function set text(value:String):void 
		{
			textField.text = headerText + objectInfo + value;
		}
		
		override public function Update():void 
		{
			super.Update();
			this.text = this.text;
		}
		
		override protected function renderGraphics():void 
		{
			image.draw(textField, new Matrix(1,0,0,1, borderSize+1, borderSize+1));
		}
		
		private function getHeaderText(header:String,filler:String):String
		{
			var fillerStr:String = "";
			if (CHARS_PER_LINE > header.length)
				for (var i:int = 0; i < Math.floor((CHARS_PER_LINE - header.length) / 2) + 1; i+=filler.length)
					fillerStr += filler;
			return fillerStr + header + fillerStr;
		}
		
		private function get objectInfo():String
		{
			var str:String = ""
			for (var obj:String in debugObjects) {
				var arr:Array = new Array();
				str += "\n" + obj + "'s state:";
				for (var name:String in debugObjects[obj])
					arr.push( { label: name, value: debugObjects[obj][name] } );
				arr.sortOn("label");
				for each (var prop:Object in arr)
					str += "\n|- " + prop.label.substr(prop.label.indexOf(".") + 1) + prop.value;
				str += "\n" + getHeaderText("", "_");
			}
			return str + "\n" + END_TEXT;
		}
		
	}
	
}