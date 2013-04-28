package uk.co.homletmoo.ld26 
{
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class InputDef 
	{
		public static const BUTTON:String = " ";
		
		public static function initialize():void
		{
			net.flashpunk.utils.Input.define( BUTTON, Key.X, Key.C, Key.SPACE, Key.UP );
		}
		
	}

}
