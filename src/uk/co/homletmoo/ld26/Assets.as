package uk.co.homletmoo.ld26 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Assets 
	{
		public static function scaleGraphic( img:*, sf:uint ):BitmapData
		{
			var bit:BitmapData = FP.getBitmap( img );
			
			var width:int = ( bit.width * sf ) || 1;
			var height:int = ( bit.height * sf ) || 1;
			
			var result:BitmapData = new BitmapData( width, height, true, 0 );
			var matrix:Matrix = new Matrix();
			matrix.scale( sf, sf );
			result.draw( bit, matrix );
			
			return result;
		}
		
		public static function zeroPad( n:int, width:int ):String
		{
			var str:String = "" + n;
			
			while ( str.length < width )
				str = "0" + str;
			
			return str;
		}
		
		// Graphics
		[Embed (source = "res/HMV2.png")]
		public static const HM_LOGO_RAW:Class;
		public static const HM_LOGO:BitmapData = FP.getBitmap( HM_LOGO_RAW );
		
		[Embed (source = "res/flashpunk.png")]
		public static const FP_LOGO_RAW:Class;
		public static const FP_LOGO:BitmapData = FP.getBitmap( FP_LOGO_RAW );
		
		[Embed (source = "res/tileset.png")]
		public static const TILESET_RAW:Class;
		public static const TILESET:BitmapData = FP.getBitmap( TILESET_RAW );
		
		[Embed (source = "res/player.png")]
		public static const PLAYER_RAW:Class;
		public static const PLAYER:BitmapData = FP.getBitmap( PLAYER_RAW );
		
		[Embed (source = "res/poof.png")]
		public static const POOF_RAW:Class;
		public static const POOF:BitmapData = FP.getBitmap( POOF_RAW );
		
		[Embed (source = "res/blood.png")]
		public static const BLOOD_RAW:Class;
		public static const BLOOD:BitmapData = FP.getBitmap( BLOOD_RAW );
		
		[Embed (source = "res/health.png")]
		public static const HEALTH_RAW:Class;
		public static const HEALTH:BitmapData = FP.getBitmap( HEALTH_RAW );
		
		[Embed (source = "res/bg.png")]
		public static const BG_RAW:Class;
		public static const BG:BitmapData = FP.getBitmap( BG_RAW );
		
		[Embed (source = "res/end.png")]
		public static const END_RAW:Class;
		public static const END:BitmapData = FP.getBitmap( END_RAW );
		
		[Embed (source = "res/retry.png")]
		public static const RETRY_RAW:Class;
		public static const RETRY:BitmapData = FP.getBitmap( RETRY_RAW );
		
		[Embed (source = "res/heart.png")]
		public static const HEART_RAW:Class;
		public static const HEART:BitmapData = FP.getBitmap( HEART_RAW );
		
		[Embed (source = "res/play.png")]
		public static const PLAY_RAW:Class;
		public static const PLAY:BitmapData = FP.getBitmap( PLAY_RAW );
		
		[Embed (source = "res/title.png")]
		public static const MENU_RAW:Class;
		public static const MENU:BitmapData = FP.getBitmap( MENU_RAW );
		
		// OGMO
		[Embed (source = "ogmo/001.oel", mimeType = "application/octet-stream")]
		public static const OGMO_001:Class;
		[Embed (source = "ogmo/002.oel", mimeType = "application/octet-stream")]
		public static const OGMO_002:Class;
		[Embed (source = "ogmo/003.oel", mimeType = "application/octet-stream")]
		public static const OGMO_003:Class;
		[Embed (source = "ogmo/004.oel", mimeType = "application/octet-stream")]
		public static const OGMO_004:Class;
		[Embed (source = "ogmo/005.oel", mimeType = "application/octet-stream")]
		public static const OGMO_005:Class;
		[Embed (source = "ogmo/006.oel", mimeType = "application/octet-stream")]
		public static const OGMO_006:Class;
		[Embed (source = "ogmo/007.oel", mimeType = "application/octet-stream")]
		public static const OGMO_007:Class;
		[Embed (source = "ogmo/008.oel", mimeType = "application/octet-stream")]
		public static const OGMO_008:Class;
	}

}
