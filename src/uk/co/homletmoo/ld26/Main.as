package uk.co.homletmoo.ld26
{
	import flash.display.Bitmap;
	import net.flashpunk.*;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld26.world.SplashWorld;
	
	[SWF (width = "640", height = "480", backgroundColor = "#dddddd")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{		
		public function Main()
		{
			super(
				Display.WIDTH,
				Display.HEIGHT,
				Display.FRAME_RATE,
				Display.FIXED_TIME
			);
			
	//		FP.console.enable();
			FP.console.toggleKey = Key.TAB;
			
	//		Input.mouseCursor = "hide";
		}
		
		override public function init():void
		{
			Sound.initialize();
			InputDef.initialize();
			
			FP.world = new SplashWorld();
		}
		
	}
	
}
