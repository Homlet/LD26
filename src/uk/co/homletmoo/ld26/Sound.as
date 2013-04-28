package uk.co.homletmoo.ld26 
{
	import net.flashpunk.*;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Sound 
	{
		[Embed (source = "res/end.mp3")] public static const END_RAW:Class;
		public static var END:Sfx;
		
		[Embed (source = "res/hit.mp3")] public static const HIT_RAW:Class;
		public static var HIT:Sfx;
		
		[Embed (source = "res/hurt.mp3")] public static const HURT_RAW:Class;
		public static var HURT:Sfx;
		
		[Embed (source = "res/jet.mp3")] public static const JET_RAW:Class;
		public static var JET:Sfx;
		
		[Embed (source = "res/jump.mp3")] public static const JUMP_RAW:Class;
		public static var JUMP:Sfx;
		
		[Embed (source = "res/menu_blip.mp3")] public static const MENU_BLIP_RAW:Class;
		public static var MENU_BLIP:Sfx;
		
		[Embed (source = "res/menu_enter.mp3")] public static const MENU_ENTER_RAW:Class;
		public static var MENU_ENTER:Sfx;
		
		
		public static function initialize():void
		{
			END = new Sfx( END_RAW );
			HIT = new Sfx( HIT_RAW );
			HURT = new Sfx( HURT_RAW );
			JET = new Sfx( JET_RAW );
			JUMP = new Sfx( JUMP_RAW );
			MENU_BLIP = new Sfx( MENU_BLIP_RAW );
			MENU_ENTER = new Sfx( MENU_ENTER_RAW );
		}
	}

}
