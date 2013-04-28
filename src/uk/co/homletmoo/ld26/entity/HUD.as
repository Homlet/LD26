package uk.co.homletmoo.ld26.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.world.GameWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class HUD extends Entity
	{		
		private var m_health:Spritemap;
		private var m_score:Text;
		
		public function HUD()
		{
			super();
			
			m_health = new Spritemap( Assets.HEALTH, 48, 10 );
			m_health.scale = Display.SCALE;
			m_health.scrollX = m_health.scrollY = 0;
			m_health.x = m_health.y = 3;
			m_health.add( "", [4, 3, 2, 1, 0] );
			m_health.play( "", true, GameWorld.globals.health );
			
			m_score = new Text( GameWorld.globals.points.toString(), 3, 33 );
			m_score.scale = Display.SCALE
			m_score.color = 0xFFECECEC;
			m_score.scrollX = m_score.scrollY = 0;
			m_score.size = 8;
			m_score.smooth = false;
			
			graphic = new Graphiclist( m_health, m_score );
			
			FP.world.add( this );
		}
		
		override public function update():void
		{
			m_health.play( "", true, GameWorld.globals.health );
			m_score.text = GameWorld.globals.points.toString();
		}
	}

}