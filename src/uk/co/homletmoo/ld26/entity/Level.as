package uk.co.homletmoo.ld26.entity 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Masklist;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.CollisionDef;
	import uk.co.homletmoo.ld26.entity.level.Section;
	import uk.co.homletmoo.ld26.Assets;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Level extends Entity
	{
		private var m_sections:Array;
		private var m_sectionPool:Array;
		
		private var m_playerPos:Point;
		
		public function Level() 
		{
			super( 0, 0 );
			
			m_sections = new Array();
			m_sectionPool = new Array();
			
			// Populate section pool
			m_sectionPool.push( mf_loadSectionDefinition( Assets.OGMO_001 ) );
			m_sectionPool.push( mf_loadSectionDefinition( Assets.OGMO_002 ) );
			m_sectionPool.push( mf_loadSectionDefinition( Assets.OGMO_003 ) );
			m_sectionPool.push( mf_loadSectionDefinition( Assets.OGMO_004 ) );
			
			m_playerPos = Player.START_POSITION;
			
			
			var section:Section = new Section( 0, m_sectionPool[0][0], m_sectionPool[0][1] );
			section.forceMinimalize( m_playerPos.x );
			m_sections[0] = section;
			
			FP.world.add( this );
		}
		
		override public function update():void
		{
			// Populate the section list
			for ( var i:int = -1; i <= 1; i++ )
			{
				var index:int = i + int( m_playerPos.x / Section.WIDTH );
				
				if ( index < 0 )
					continue;
				
				if ( m_sections[index] == null )
				{
					var random:int = Math.floor( Math.random() * m_sectionPool.length );
					var section:Section = new Section( index, m_sectionPool[random][0], m_sectionPool[random][1] );
					
					m_sections[index] = section;
				}
			}
			
			var delete_index:int = int( m_playerPos.x / Section.WIDTH ) - 2;
			
			if ( delete_index >= 0 && m_sections[delete_index] != null )
			{
				FP.world.remove( m_sections[delete_index] );
				m_sections[delete_index] = null;
			}
		}
		
		public function setPlayerPosition( x:int, y:int ):void
		{
			m_playerPos = new Point( x, y );
			
			var s:Section;
			for each ( s in m_sections )
			{
				if ( s != null )
					s.setPlayerPosition( x, y );
			}
		}
		
		private function mf_loadSectionDefinition( xml:Class ):Array
		{
			var rawData:ByteArray = new xml;
			var stringData:String = rawData.readUTFBytes( rawData.length );
			var xmlData:XML = new XML( stringData );
			
			var tiles:XMLList = xmlData.Tiles.tile;
			var grid:String = xmlData.Collision.*;
			
			var pair:Array = new Array();
			pair.push( tiles );
			pair.push( grid );
			
			return pair;
		}
	}

}
