package uk.co.homletmoo.ld26.world 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.entity.HUD;
	import uk.co.homletmoo.ld26.entity.Player;
	import uk.co.homletmoo.ld26.entity.Level;
	import uk.co.homletmoo.ld26.Globals;
	import uk.co.homletmoo.ld26.InputDef;
	import uk.co.homletmoo.ld26.Sound;
	
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
		
		private var m_paused:Boolean;
		private var m_previousAlpha:Number;
		private var m_introCompleted:Boolean;
		private var m_muted:Boolean;
		
		override public function begin():void
		{
			FP.screen.color = 0xFF202020;
			
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
			
			m_paused = false;
			m_previousAlpha = 0.0;
			m_introCompleted = false;
			m_muted = false;
			
			Sound.MUSIC.play();
			
			addGraphic( m_bg, 10 );
			addGraphic( m_fader, -10 );
		}
		
		override public function update():void
		{
			if ( Input.pressed( InputDef.MUTE ) )
			{
				if ( !m_muted )
				{
					if ( !m_paused )
						stopMusic();
					
					m_muted = true;
				} else
				{
					if ( !m_paused )
						startMusic();
					
					m_muted = false;
				}
			}
			
			if ( Input.pressed( InputDef.PAUSE ) )
			{
				if ( m_paused )
				{
					m_fader.alpha = m_previousAlpha;
					
					Sound.MENU_BLIP.play();				
					
					if ( !m_muted )
						startMusic();
					
					m_paused = false;
				} else
				{
					m_previousAlpha = m_fader.alpha;
					m_fader.alpha = 0.5;
					
					Sound.MENU_BLIP.play();
					
					if ( !m_muted )
						stopMusic();
					
					m_paused = true;
				}	
			}
			
			if ( m_paused )
				return;
			
			if ( globals.health <= 0 )
			{
				Sound.MUSIC.stop();
				Sound.LOOP.stop();
				
				m_bg.play( "CYCLE", true, 0 );
				m_fader.alpha += 0.05;
			} else
				globals.time += FP.elapsed;
			
			super.update();
			
			m_level.setPlayerPosition( m_player.x, m_player.y );
			
			FP.camera.x = m_player.x - Player.START_POSITION.x;
			
			if ( m_player.y < Display.HEIGHT / 5.0 )
				FP.camera.y = m_player.y - Display.HEIGHT / 5.0;
			else
				FP.camera.y = 0;
		}
		
		
		public function stopMusic():void
		{
			if ( Sound.MUSIC.playing )
			{
				Sound.MUSIC.stop();
			} else
			{
				Sound.LOOP.stop();
				
				m_introCompleted = true;
			}
		}
		
		public function startMusic():void
		{
			if ( m_introCompleted )
				Sound.LOOP.resume();
			else
				Sound.MUSIC.resume();
		}
	}

}
