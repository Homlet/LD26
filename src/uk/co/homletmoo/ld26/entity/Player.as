package uk.co.homletmoo.ld26.entity 
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld26.InputDef;
	import uk.co.homletmoo.ld26.CollisionDef;
	import uk.co.homletmoo.ld26.Const;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Player extends Entity
	{
		private var m_velocity:Point;
		
		private var m_onGround:Boolean;
		private var m_jumping:Boolean;
		private var m_jumpTimer:Number;
		
		public function Player() 
		{			
			super( 0, 0, Image.createRect( 48, 48, 0xFF0000 ) );
			
			m_velocity = new Point( 0, 0 );
			
			m_onGround = true;
			m_jumping = false;
			m_jumpTimer = 1.0;
			
			
			type = "player";
			setHitbox( 48, 48 );
			
			
			FP.world.add( this );
		}
		
		override public function update():void
		{
			// Check for jumping
			if ( Input.pressed( InputDef.BUTTON ) )
				m_jumping = true;
			
			// Handle jumping
			if ( m_jumping && m_jumpTimer > 0.0 )
			{
				m_jumpTimer -= FP.elapsed;
				
				m_velocity.y += 0.1;
			} else if ( collide( CollisionDef.WORLD, x, y ) )
			{
				
			}
		}
		
		private function mf_gravity( iterations:uint )
		{
			for ( var i:uint = 0; i < iterations; i++ )
			{
				m_velocity.y += Const.GRAVITY;
			}
		}
	}

}
