package uk.co.homletmoo.ld26.world 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.entity.RetryButton;
	import uk.co.homletmoo.ld26.Sound;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class EndWorld extends World
	{
		private var m_bg:Image;
		private var m_score:Text;
		private var m_tiles:Text;
		private var m_time:Text;
		private var m_button:RetryButton;
		
		private var m_timer:Number;
		private var m_scorePlayed:Boolean;
		private var m_tilesPlayed:Boolean;
		private var m_timePlayed:Boolean;
		private var m_buttonPlayed:Boolean;
		
		public function EndWorld() 
		{
			m_bg = new Image( Assets.END );
			m_bg.scale = Display.SCALE;
			
			m_score = new Text( "Score: " + GameWorld.globals.points.toString(), 0, 170 );
			m_score.size = 16 * Display.SCALE;
			m_score.color = 0xFFECECEC;
			m_score.smooth = false;
			m_score.x = Display.WIDTH / 2.0 - m_score.width / 2.0;
			
			m_tiles = new Text( "Tiles Minimalised: " + GameWorld.globals.tiles.toString(), 0, 235 );
			m_tiles.size = 16 * Display.SCALE;
			m_tiles.color = 0xFFECECEC;
			m_tiles.smooth = false;
			m_tiles.x = Display.WIDTH / 2.0 - m_tiles.width / 2.0;
			
			var minutes:int = Math.floor( GameWorld.globals.time / 60.0 );
			var seconds:int = GameWorld.globals.time % 60;
			var timeStamp:String = minutes.toString() + ":" + Assets.zeroPad( seconds, 2 );
			
			m_time = new Text( "Time Ran: " + timeStamp, 0, 310 );
			m_time.size = 16 * Display.SCALE;
			m_time.color = 0xFFECECEC;
			m_time.smooth = false;
			m_time.x = Display.WIDTH / 2.0 - m_time.width / 2.0;
			
			m_tiles.visible = m_score.visible = m_time.visible = false;
			
			m_button = new RetryButton( 385 );
			
			m_timer = 0.0;
			m_scorePlayed = false;
			m_tilesPlayed = false;
			m_buttonPlayed = false;
			
			add( m_button );
			addGraphic( m_bg );
			addGraphic( m_score, -10 );
			addGraphic( m_tiles, -10 );
			addGraphic( m_time, -10 );
		}
		
		override public function update():void
		{
			m_timer += FP.elapsed;
			
			if ( m_timer > 0.5 && !m_scorePlayed )
			{
				m_scorePlayed = true;
				
				Sound.MENU_BLIP.play( 0.7 );
				m_score.visible = true;
			}
			
			if ( m_timer > 1.0 && !m_tilesPlayed )
			{
				m_tilesPlayed = true;
				
				Sound.MENU_BLIP.play( 0.7 );
				m_tiles.visible = true;
			}
			
			if ( m_timer > 1.5 && !m_timePlayed )
			{
				m_timePlayed = true;
				
				Sound.MENU_BLIP.play( 0.7 );
				m_time.visible = true;
			}
			
			if ( m_timer > 2.0 && !m_buttonPlayed )
			{
				m_buttonPlayed = true;
				
				Sound.MENU_BLIP.play( 0.55 );
				m_button.show();
			}
			
			super.update();
		}
	}

}
