package uk.co.homletmoo.ld26.world
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.Sound;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class SplashWorld extends World 
	{
		public static const SCREENS:Number = 2;
		
		protected var m_logos:Entity;
		protected var m_fpStrip:Spritemap;
		protected var m_hmImage:Image;
		
		protected var m_fade:Entity;
		protected var m_fadeTween:NumTween = new NumTween( finish );
		protected var m_fadeImg:Image = Image.createRect( FP.width, FP.height, 0 );
		
		protected var m_screenIterator:uint = 0;
		
		override public function begin():void
		{				
			m_fpStrip = new Spritemap( Assets.FP_LOGO, 100, 100 );
			m_fpStrip.scale = Display.SCALE;
			m_fpStrip.y = FP.height - m_fpStrip.scaledHeight;
			m_fpStrip.add( "run", [0, 1, 2, 3, 4], 8, true );
			m_fpStrip.play( "run" );
			
			m_hmImage = new Image( Assets.HM_LOGO );
			m_hmImage.scale = Display.SCALE * 2;
			m_hmImage.x = ( FP.width / 2 ) - ( m_hmImage.scaledWidth / 2 );
			m_hmImage.y = ( FP.height / 2 ) - ( m_hmImage.scaledHeight / 2 );
			m_hmImage.visible = false;
			
			m_logos = new Entity( 0, 0, new Graphiclist( m_fpStrip, m_hmImage ) );
			
			m_fade = new Entity( 0, 0, m_fadeImg );
			fadeIn();
			
			add( m_logos );
			add( m_fade );
			addTween( m_fadeTween );
		}
		
		override public function update():void
		{
			m_fadeImg.alpha = m_fadeTween.value;
			
			super.update();
		}
		
		private function fadeIn():void
		{			
			switch ( m_screenIterator )
			{
			case 0:
				m_fadeTween.tween( 1, 0, 1, Ease.sineIn );
			break;
			
			case 1:
				m_fadeTween.tween( 1, 0, 1, Ease.sineIn );
				
				m_fpStrip.visible = false;
				m_hmImage.visible = true;
			break;
			}
		}
		
		private function fadeOut():void
		{
			m_fadeTween.tween( 0, 1, 3, Ease.quartIn );
		}
		
		public function finish():void
		{
			if ( m_fadeTween.value == 0 )
				fadeOut()
			else if ( m_screenIterator++ < SCREENS - 1 )
				fadeIn()
			else
				FP.world = new GameWorld();
		}
		
	}

}
