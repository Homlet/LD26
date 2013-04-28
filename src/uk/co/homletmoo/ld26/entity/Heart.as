package uk.co.homletmoo.ld26.entity 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.CollisionDef;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.Sound;
	import uk.co.homletmoo.ld26.world.GameWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Heart extends Entity
	{
		private var m_image:Image;
		
		public function Heart( x:int, y:int ) 
		{
			super( x, y );
			
			m_image = new Image( Assets.HEART );
			m_image.scale = Display.SCALE;
			
			graphic = m_image;
			
			setHitbox( 33, 30, -6, -9 );
			
			FP.world.add( this );
		}
		
		override public function update():void
		{
			if ( collide( CollisionDef.PLAYER, x, y ) )
			{
				Sound.MENU_BLIP.play( 0.7 );
				
				if ( GameWorld.globals.health < 4 )
					GameWorld.globals.health++;
				
				GameWorld.globals.points += 200;
				
				FP.world.remove( this );
			}
		}
		
	}

}