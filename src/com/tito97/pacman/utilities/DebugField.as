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
	 * [OPTIONAL CLASS]
	 * A UI element, composed by a text field, that was made to show debug data about many objects
	 * that submited them in the debugObjects associative array, in order to make a live debug.
	 * @author Diogo
	 */
	public class DebugField extends UI_Element 
	{
		// The text which is showed at the end of the debugObjects data.
		static private const END_TEXT:String = "***End***";
		// The number of characters that fit can fit on the longest textfield's line.
		// Useful to make some text effetcs like the one used by the getHeaderText().
		static private const CHARS_PER_LINE:Number = 49;
		
		// An instance of the TextField object that composes this class
		private var textField:TextField;
		// The text field's header text
		private var headerText:String = getHeaderText("DEBUG_CONSOLE", ":");
		
		/**
		 * The object i which the debugging data will be inserted and updated on each frame
		 */
		public var debugObjects:Object;
		
		/**
		 * The constructor function for this class. It also initialises the instance's text field.
		 * @param	x The text field's position on the x axis
		 * @param	y The text field's position on the y axis
		 * @param	width The width of the text field
		 * @param	height The height of the text field
		 */
		public function DebugField(x:Number, y:Number, width:Number, height:Number) 
		{
			// Calls the superclass's constructor in order to give this UI element an opaqur black background
			// with a white thin stroke.
			super(x, y, width, height, true, 0, true, 0xCCCCCC, 1);
			
			debugObjects = { };
			
			// Constructs and decorates the text field as it should be
			textField = new TextField();
			textField.width = width - borderSize*2-2;
			textField.height = height - borderSize*2-2;
			textField.defaultTextFormat = new TextFormat("Consolas");
			textField.opaqueBackground = 0;
			textField.textColor = 0xFFFFFF;
			
			// sets the text field's text "empty", in order to call this instance's text setter function for the
			// first time, initializing this element's content.
			textField.text = "";
		}
		
		/**
		 * Returns the text field's content BUT the header and the debugging text associated to the debugObjects.
		 */
		public function get text():String 
		{
			return textField.text.substr(textField.text.indexOf(END_TEXT)+END_TEXT.length);
		}
		/**
		 * Defines the text field's content after the debugObjects data
		 */
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
		
		/**
		 * Returns a header text to ocupy the first line in the text field
		 * @param	header The header's main text
		 * @param	filler The character(s) that will fill the header line around the main text
		 * @return A String that is made up by the header text surrounded by the filler chracter(s),
		 * whose length equals the CHARS_PER_LINE value.
		 */ 
		private function getHeaderText(header:String,filler:String):String
		{
			var fillerStr:String = "";
			if (CHARS_PER_LINE > header.length)
				for (var i:int = 0; i < Math.floor((CHARS_PER_LINE - header.length) / 2) + 1; i+=filler.length)
					fillerStr += filler;
			return fillerStr + header + fillerStr;
		}
		
		/**
		 * A private getter function that returns a formated String with the text that will show
		 * the debugging data from the several objects from this game.
		 */
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