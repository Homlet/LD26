package uk.co.homletmoo.ld26.world 
{
	import net.flashpunk.*;
	import uk.co.homletmoo.ld26.entity.Player;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class GameWorld extends World
	{
		private var m_player:Player;
		
		override public function begin():void
		{
			m_player = new Player();
		}
		
		override public function update():void
		{
			
		}
	}

}
