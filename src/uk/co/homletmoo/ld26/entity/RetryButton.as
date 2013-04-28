package uk.co.homletmoo.ld26.entity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.Sound;
	import uk.co.homletmoo.ld26.world.GameWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class RetryButton extends Entity
	{
		public static const RELEASE:String = "r";
		public static const HOVER:String = "h";
		public static const DOWN:String = "d";
		
		
		private var m_graphic:Spritemap;
		private var m_rect:Rectangle;
		
		private var m_pressed:Boolean;
		
		public function RetryButton( y:int ) 
		{
			super( 0, y );
			
			layer = -10;
			
			m_graphic = new Spritemap( Assets.RETRY, 64, 16 );
			m_graphic.scale = Display.SCALE;
			m_graphic.add( RELEASE, [0] );
			m_graphic.add( HOVER, [1] );
			m_graphic.add( DOWN, [2] );
			m_graphic.play( RELEASE );
			m_graphic.x = Display.WIDTH / 2.0 - m_graphic.scaledWidth / 2.0;
			m_graphic.visible = false;
			
			graphic = m_graphic;
			
			m_pressed = false;
			
			m_rect = new Rectangle();
		}
		
		override public function update():void
		{
			var mouse:Point = new Point( Input.mouseFlashX, Input.mouseFlashY );
			
			if ( m_rect.containsPoint( mouse ) )
			{
				if ( Input.mouseDown )
				{
					m_pressed = true;
					
					m_graphic.play( DOWN );
				} else
				{
					if ( m_pressed )
					{
						Sound.MENU_ENTER.play();
						FP.world = new GameWorld();
					}
					
					m_graphic.play( HOVER );
				}
			} else
			{
				m_graphic.play( RELEASE );
			}
		}
		
		public function show():void
		{
			m_graphic.visible = true;
			
			m_rect = new Rectangle( m_graphic.x, y, 64 * Display.SCALE, 16 * Display.SCALE );
		}
	}

}