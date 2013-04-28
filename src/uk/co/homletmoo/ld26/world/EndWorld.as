package uk.co.homletmoo.ld26.world 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class EndWorld extends World
	{
		private var m_bg:Image;
		
		private var m_timer:Number;
		
		public function EndWorld() 
		{
			m_bg = new Image( Assets.END );
			m_bg.scale = Display.SCALE;
			
			m_timer = 0.0;
			
			addGraphic( m_bg );
		}
		
		override public function update():void
		{
			m_timer += FP.elapsed;
			
			super.update();
		}
	}

}
