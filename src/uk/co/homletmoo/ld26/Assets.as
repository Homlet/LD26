package uk.co.homletmoo.ld26 
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Assets 
	{
		[Embed (source = "res/HMV2.png")] public static const HM_LOGO_RAW:Class;
		public static const HM_LOGO:BitmapData = FP.getBitmap( HM_LOGO_RAW );
		
		[Embed (source = "res/flashpunk.png")] public static const FP_LOGO_RAW:Class;
		public static const FP_LOGO:BitmapData = FP.getBitmap( FP_LOGO_RAW );
	}

}
