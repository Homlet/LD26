package uk.co.homletmoo.ld26.entity 
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.entity.level.Section;
	import uk.co.homletmoo.ld26.InputDef;
	import uk.co.homletmoo.ld26.CollisionDef;
	import uk.co.homletmoo.ld26.Const;
	import uk.co.homletmoo.ld26.Main;
	import uk.co.homletmoo.ld26.Sound;
	import uk.co.homletmoo.ld26.world.EndWorld;
	import uk.co.homletmoo.ld26.world.GameWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Player extends Entity
	{
		public static const START_MAX_VELOCITY_X:Number = 300;
		public static const END_MAX_VELOCITY_X:Number = 700;
		public static const MAX_VELOCITY_TRANSITION:Number = 0.05;
		public static const JUMP_SPEED:Number = 700;
		public static const ACCELERATION:Number = 50;
		
		public static const START_POSITION:Point = new Point( 300, Display.HEIGHT - Section.TILE_SIZE * 4 );
		
		public static const GRACE_LENGTH:Number = 3.0;
		public static const JUMP_LENGTH:Number = 1.0;
		public static const LEDGE_LENGTH:Number = 0.2;
		
		public static const ANIM_WALKING:String = "w";
		public static const ANIM_JUMPING:String = "j";
		public static const ANIM_HURT:String = "h";
		public static const ANIM_FALLING:String = "f";
		public static const ANIM_DEATH:String = "d";
		
		
		private var m_graphic:Spritemap;
		
		private var m_velocity:Point;
		private var m_maxVelocityX:Number;
		
		private var m_inKnockback:Boolean;
		private var m_graceTimer:Number;
		
		private var m_onGround:Boolean;
		private var m_jumped:Boolean;
		private var m_jumpTimer:Number;
		private var m_ledgeTimer:Number;
		
		private var m_deathTimer:Number;
		
		public function Player() 
		{
			super( START_POSITION.x, START_POSITION.y );
			
			m_graphic = new Spritemap( Assets.PLAYER, 10, 16 );
			m_graphic.scale = 4;
			m_graphic.add( ANIM_WALKING, [1, 0, 1, 3, 2, 3], 10.0 );
			m_graphic.add( ANIM_JUMPING, [4, 5], 5.0 );
			m_graphic.add( ANIM_HURT, [6] );
			m_graphic.add( ANIM_FALLING, [7] );
			m_graphic.add( ANIM_DEATH, [8, 9, 10, 11, 12], 2, false );
			m_graphic.play( ANIM_WALKING );
			
			m_velocity = new Point( 0, 0 );
			m_maxVelocityX = START_MAX_VELOCITY_X;
			
			m_inKnockback = false;
			m_graceTimer = 0.0;
			
			m_onGround = false;
			m_jumped = false;
			m_jumpTimer = JUMP_LENGTH;
			m_ledgeTimer = LEDGE_LENGTH;
			
			m_deathTimer = 0.0;
			
			graphic = m_graphic;
			
			type = CollisionDef.PLAYER;
			layer = -20;
			setHitbox( 40, 64 );
			
			
			FP.world.add( this );
		}
		
		override public function update():void
		{
			if ( GameWorld.globals.health <= 0 )
			{
				m_deathTimer += FP.elapsed;
				
				m_graphic.alpha = 1.0;
				m_graphic.play( ANIM_DEATH );
				
				if ( m_deathTimer % 0.5 <= 0.1 && m_deathTimer > 0.1 )
				{
					Sound.HIT.play();
				}
				
				if ( m_graphic.complete )
				{
					Sound.END.play();
					FP.world = new EndWorld();
				}
				
				return;
			}
			
			// Check if the player is on the ground
			if ( collide( CollisionDef.WORLD, x, y + 1 ) )
			{
				m_onGround = true;
				m_velocity.y = 0.0;
				m_jumped = false;
				m_jumpTimer = 1.0;
				m_ledgeTimer = LEDGE_LENGTH;
			} else
			{
				m_onGround = false;
				m_ledgeTimer -= FP.elapsed;
			}
			
			// Check if the player has hit a wall
			if ( collide( CollisionDef.WORLD, x + 1, y ) )
			{				
				m_inKnockback = true;
				
				m_velocity.x = -JUMP_SPEED;
				m_velocity.y = -JUMP_SPEED * 1.5;
				
				if ( m_graceTimer <= 0.0 )
				{
					m_graceTimer = GRACE_LENGTH;
					GameWorld.globals.health -= 1;
					Main.quake.start();
					
					Sound.HURT.play();
				} else
					Sound.HIT.play();
			}
			
			// Accelerate to full x speed
			if ( m_velocity.x < m_maxVelocityX )
			{
				m_velocity.x += ACCELERATION;
			}
			
			// Handle grace period
			if ( m_graceTimer > 0.0 )
			{
				if ( m_onGround )
					m_inKnockback = false;
				
				m_graceTimer -= FP.elapsed;
				m_graphic.alpha = 0.5;
			} else
			{
				m_inKnockback = false;
				m_graphic.alpha = 1.0;
			}
			
			// Handle jumping
			if ( Input.pressed( InputDef.BUTTON ) && m_ledgeTimer > 0.0 )
			{
				m_jumped = true;
				
				m_velocity.y = -JUMP_SPEED;
				
				Sound.JUMP.play();
				Sound.JET.play( 0.4 );
			}
			
			// Decrement jump timer if jumping
			if ( Input.check( InputDef.BUTTON ) && m_jumped )
			{
				m_jumpTimer -= FP.elapsed;
			}
			
			// Apply light gravity for jumping
			mf_gravity( 1 );
			
			// Apply more gravity if player is not jumping, or if the jump is finished, or if the player is hurt
			if ( !Input.check( InputDef.BUTTON ) || m_jumpTimer <= 0.0 || m_inKnockback )
				mf_gravity( 2 );
			
			// Limit y-axis speed to stop knockback and jumping combining
			if ( m_velocity.y < -JUMP_SPEED * 1.5 )
				m_velocity.y = -JUMP_SPEED * 1.5;
			
			// Make the maximum speed higher
			if ( m_maxVelocityX <= END_MAX_VELOCITY_X )
				m_maxVelocityX += MAX_VELOCITY_TRANSITION;
			
			moveBy( m_velocity.x * FP.elapsed, m_velocity.y * FP.elapsed, CollisionDef.WORLD, true );
			
			if ( m_onGround )
				m_graphic.play( ANIM_WALKING );	
			else
			{
				if ( m_inKnockback || !m_jumped )
					m_graphic.play( ANIM_HURT );
				else if ( m_jumpTimer > 0.0 && Input.check( InputDef.BUTTON ) )
					m_graphic.play( ANIM_JUMPING );	
				else
					m_graphic.play( ANIM_FALLING );
			}
		}
		
		private function mf_gravity( iterations:uint ):void
		{
			for ( var i:uint = 0; i < iterations; i++ )
			{
				m_velocity.y += Const.GRAVITY;
			}
		}
	}

}
