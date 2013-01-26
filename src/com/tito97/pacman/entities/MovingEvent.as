package com.tito97.pacman.entities 
{
	import flash.events.Event;
	
	/**
	 * This class defines events that inform about the MovingObjects' motion state (OK, not yet...)
	 * @author Diogo
	 */
	public class MovingEvent extends Event 
	{
		
		/**
		 * This event it dispatched when a MovingObject is aligned with the game map's grid.
		 */
		public static const CHARACTER_ALIGNED:String = "characterAligned";
		
		/**
		 * The MovingObject That has dispatched this event
		 */
		public var character:MovingCharacter;
		
		/**
		 * Creates a new MovingEvent to be dispatched
		 * @param	target The MovingObject that is causing this event
		 * @param	type The String that indicates this Event's type. You should use the static constants from this class.
		 * @param	bubbles Indicates whether this Event will bubble up to the event flow
		 * @param	cancelable Indicates whether the behavior associated with the event can be prevented.
		 */
		public function MovingEvent(target:MovingCharacter, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.character = target;
		} 
		
		public override function clone():Event 
		{ 
			return new MovingEvent(character, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MovingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}