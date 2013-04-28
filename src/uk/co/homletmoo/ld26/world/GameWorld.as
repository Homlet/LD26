package uk.co.homletmoo.ld26.world 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.entity.HUD;
	import uk.co.homletmoo.ld26.entity.Player;
	import uk.co.homletmoo.ld26.entity.Level;
	import uk.co.homletmoo.ld26.Globals;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class GameWorld extends World
	{
		public static var globals:Globals;
		
		private var m_player:Player;
		private var m_level:Level;
		private var m_HUD:HUD;
		
		private var m_bg:Spritemap;
		private var m_fader:Image;
		
		override public function begin():void
		{
			globals = new Globals();
			
			m_player = new Player();
			m_level = new Level();
			m_HUD = new HUD();
			
			m_bg = new Spritemap( Assets.BG, 333, 160 );
			m_bg.x = Display.WIDTH - 333 * Display.SCALE;
			m_bg.scrollX = 0;
			m_bg.scrollY = 0;
			m_bg.scale = Display.SCALE;
			m_bg.add( "CYCLE", [0, 1, 2, 3], 1.5 );
			m_bg.play( "CYCLE" );
			
			m_fader = Image.createRect( Display.WIDTH, Display.HEIGHT, 0xFF000000, 0 );
			m_fader.scrollX = m_fader.scrollY = 0;
			
			addGraphic( m_bg, 10 );
			addGraphic( m_fader, -10 );
		}
		
		override public function update():void
		{
			if ( globals.health <= 0 )
			{
				m_bg.play( "CYCLE", true, 0 );
				m_fader.alpha += 0.05;
			}
			
			super.update();
			
			m_level.setPlayerPosition( m_player.x, m_player.y );
			
			FP.camera.x = m_player.x - Player.START_POSITION.x;
			
			if ( m_player.y < Display.HEIGHT / 5.0 )
				FP.camera.y = m_player.y - Display.HEIGHT / 5.0;
			else
				FP.camera.y = 0;
		}
	}

}
