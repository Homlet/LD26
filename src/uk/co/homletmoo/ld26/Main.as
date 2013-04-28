package uk.co.homletmoo.ld26
{
	import flash.display.Bitmap;
	import net.flashpunk.*;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld26.world.GameWorld;
	import uk.co.homletmoo.ld26.world.SplashWorld;
	
	[SWF (width = "1280", height = "480", backgroundColor = "#dddddd")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{
		public static var quake:Quake;
		
		public function Main()
		{
			super(
				Display.WIDTH,
				Display.HEIGHT,
				Display.FRAME_RATE,
				Display.FIXED_TIME
			);
			
			quake = new Quake();
			
	//		FP.console.enable();
			FP.console.toggleKey = Key.TAB;
			
	//		Input.mouseCursor = "hide";
		}
		
		override public function init():void
		{
			Sound.initialize();
			InputDef.initialize();
			
			FP.world = new GameWorld();
		}
		
		override public function update():void
		{
			quake.update();
			
			super.update();
		}
	}
	
}
