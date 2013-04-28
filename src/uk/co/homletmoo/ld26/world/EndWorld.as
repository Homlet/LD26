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
		private var m_button:RetryButton;
		
		private var m_timer:Number;
		private var m_scorePlayed:Boolean;
		private var m_tilesPlayed:Boolean;
		private var m_buttonPlayed:Boolean;
		
		public function EndWorld() 
		{
			m_bg = new Image( Assets.END );
			m_bg.scale = Display.SCALE;
			
			m_score = new Text( "Score: " + GameWorld.globals.points.toString(), 0, 180 );
			m_score.size = 16 * Display.SCALE;
			m_score.color = 0xFFECECEC;
			m_score.smooth = false;
			m_score.x = Display.WIDTH / 2.0 - m_score.width / 2.0;
			
			m_tiles = new Text( "Tiles Minimalised: " + GameWorld.globals.tiles.toString(), 0, 250 );
			m_tiles.size = 16 * Display.SCALE;
			m_tiles.color = 0xFFECECEC;
			m_tiles.smooth = false;
			m_tiles.x = Display.WIDTH / 2.0 - m_tiles.width / 2.0;
			
			m_tiles.visible = m_score.visible = false;
			
			m_button = new RetryButton( 350 );
			
			m_timer = 0.0;
			m_scorePlayed = false;
			m_tilesPlayed = false;
			m_buttonPlayed = false;
			
			add( m_button );
			addGraphic( m_bg );
			addGraphic( m_score, -10 );
			addGraphic( m_tiles, -10 );
		}
		
		override public function update():void
		{
			m_timer += FP.elapsed;
			
			if ( m_timer > 0.5 && !m_scorePlayed )
			{
				m_scorePlayed = true;
				
				Sound.MENU_BLIP.play();
				m_score.visible = true;
			}
			
			if ( m_timer > 1.0 && !m_tilesPlayed )
			{
				m_tilesPlayed = true;
				
				Sound.MENU_BLIP.play();
				m_tiles.visible = true;
			}
			
			if ( m_timer > 1.5 && !m_buttonPlayed )
			{
				m_buttonPlayed = true;
				
				Sound.MENU_BLIP.play();
				m_button.show();
			}
			
			super.update();
		}
	}

}
