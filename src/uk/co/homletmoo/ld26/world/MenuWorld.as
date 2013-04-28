package uk.co.homletmoo.ld26.world 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.entity.PlayButton;
	import uk.co.homletmoo.ld26.Sound;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class MenuWorld extends World
	{
		private var m_bg:Image;
		private var m_button:PlayButton;
		
		private var m_timer:Number;
		private var m_currentBG:int;
		
		private var m_colors:Array;
		
		public function MenuWorld() 
		{
			m_bg = new Image( Assets.MENU );
			m_bg.scale = Display.SCALE;
			
			m_button = new PlayButton( 360 );
			
			m_timer = 0.0;
			m_currentBG = 0;
			
			m_colors = new Array();
			m_colors[0] = 0xFFFF0000;
			m_colors[1] = 0xFFFFC300;
			m_colors[2] = 0xFF5818FF;
			m_colors[3] = 0xFF71FF00;
			
			FP.screen.color = m_colors[0];
			
			add( m_button );
			addGraphic( m_bg );
		}
		
		override public function update():void
		{
			m_timer += FP.elapsed;
			
			if ( m_timer > 0.5 )
			{
				m_timer = 0;
				
				if ( m_currentBG < 3 )
					m_currentBG++;
				else
					m_currentBG = 0;
				
				FP.screen.color = m_colors[m_currentBG];
			}
			
			super.update();
		}
	}

}
