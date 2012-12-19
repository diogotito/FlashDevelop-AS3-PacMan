package com.tito97.pacman.entities 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Diogo
	 */
	public class MovingEvent extends Event 
	{
		
		public static const CHARACTER_ALIGNED:String = "characterAligned";
		
		public var target:MovingCharacter;
		
		
		public function MovingEvent(target:MovingCharacter, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.target = target;
		} 
		
		public override function clone():Event 
		{ 
			return new MovingEvent(target, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MovingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}