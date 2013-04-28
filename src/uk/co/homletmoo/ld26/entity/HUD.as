package uk.co.homletmoo.ld26.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.ParticleDef;
	import uk.co.homletmoo.ld26.world.GameWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class HUD extends Entity
	{
		private var m_oldHealth:int;
		
		private var m_health:Spritemap;
		private var m_emitter:Emitter;
		private var m_emitterEntity:Entity;
		private var m_score:Text;
		private var m_time:Text;
		
		public function HUD()
		{
			super( 0, 0 );
			
			m_oldHealth = 4;
			
			m_health = new Spritemap( Assets.HEALTH, 48, 10 );
			m_health.scale = Display.SCALE;
			m_health.scrollX = m_health.scrollY = 0;
			m_health.x = m_health.y = 3;
			m_health.add( "", [4, 3, 2, 1, 0] );
			m_health.play( "", true, GameWorld.globals.health );
			
			m_emitter = new Emitter(
				Assets.scaleGraphic( Assets.POOF_RAW, Display.SCALE ),
				16 * Display.SCALE,
				16 * Display.SCALE
			);
			m_emitter.scrollX = m_emitter.scrollY = 0;
			m_emitter.newType( ParticleDef.POOF, [0, 1, 2, 3] );
			m_emitter.setMotion( ParticleDef.POOF, 0, 1.0, 1.0, 360.0 );
			
			m_emitterEntity = new Entity( 0, 0, m_emitter );
			
			m_score = new Text( GameWorld.globals.points.toString(), 3, 33 );
			m_score.scale = Display.SCALE
			m_score.color = 0xFFECECEC;
			m_score.scrollX = m_score.scrollY = 0;
			m_score.size = 8;
			m_score.smooth = false;
			
			var minutes:int = Math.floor( GameWorld.globals.time / 60.0 );
			var seconds:int = GameWorld.globals.time % 60;
			var timeStamp:String = minutes.toString() + ":" + Assets.zeroPad( seconds, 2 );
			
			m_time = new Text( timeStamp, 0, 3 );
			m_time.scale = Display.SCALE;
			m_time.color = 0xFFECECEC;
			m_time.scrollX = m_time.scrollY = 0;
			m_time.size = 24;
			m_time.smooth = false;
			m_time.x = Display.WIDTH - m_time.scaledWidth - 3;
			
			graphic = new Graphiclist( m_health, m_score, m_time );
			
			FP.world.add( this );
			FP.world.add( m_emitterEntity );
		}
		
		override public function update():void
		{
			var newHealth:int = GameWorld.globals.health;
			
			if ( newHealth < m_oldHealth )
				m_emitter.emit( ParticleDef.POOF, 36 * newHealth - 4, -4 );
			else if ( newHealth > m_oldHealth )
				m_emitter.emit( ParticleDef.POOF, 36 * m_oldHealth - 4, -4 );
			
			m_oldHealth = newHealth;
			
			m_health.play( "", true, newHealth );
			m_score.text = GameWorld.globals.points.toString();
			
			var minutes:int = Math.floor( GameWorld.globals.time / 60.0 );
			var seconds:int = GameWorld.globals.time % 60;
			var timeStamp:String = minutes.toString() + ":" + Assets.zeroPad( seconds, 2 );
			m_time.text = timeStamp;
			m_time.x = Display.WIDTH - m_time.scaledWidth - 3;
		}
	}

}