package uk.co.homletmoo.ld26 
{
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class InputDef 
	{
		public static const BUTTON:String = "b";
		public static const PAUSE:String = "p";
		public static const MUTE:String = "m";
		
		public static function initialize():void
		{
			Input.define( BUTTON, Key.X, Key.C, Key.SPACE, Key.UP );
			Input.define( PAUSE, Key.P, Key.ESCAPE );
			Input.define( MUTE, Key.M );
		}
		
	}

}
