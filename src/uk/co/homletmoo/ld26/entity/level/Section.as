package uk.co.homletmoo.ld26.entity.level 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import uk.co.homletmoo.ld26.Assets;
	import uk.co.homletmoo.ld26.CollisionDef;
	import uk.co.homletmoo.ld26.Display;
	import uk.co.homletmoo.ld26.entity.Player;
	import uk.co.homletmoo.ld26.ParticleDef;
	import uk.co.homletmoo.ld26.world.GameWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Section extends Entity
	{
		public static const WIDTH:int = 480 * Display.SCALE;
		public static const HEIGHT:int = 160 * Display.SCALE;
		
		public static const TILE_SIZE:int = 16 * Display.SCALE;
		
		private static function getTilemap( tileData:XMLList ):Tilemap
		{
			var tiles:Tilemap = new Tilemap(
				Assets.scaleGraphic( Assets.TILESET_RAW, Display.SCALE ),
				WIDTH, HEIGHT,
				TILE_SIZE, TILE_SIZE
			);
			
			var element:XML;
			for each ( element in tileData )
			{
				var x:int = element.@x;
				var y:int = element.@y;
				var id:int = element.@id;
				
				tiles.setTile( x, y, id );
			}
			
			return tiles;
		}
		
		private static function getGrid( gridData:String ):Grid
		{
			var grid:Grid = new Grid(
				WIDTH, HEIGHT,
				TILE_SIZE, TILE_SIZE
			);
			
			grid.loadFromString( gridData, "", "\n" );
			
			return grid;
		}
		
		
		private var m_tilemap:Tilemap;
		private var m_grid:Grid;
		
		private var m_playerPos:Point;
		
		private var m_emitter:Emitter;
		
		public function Section( offset:int, tilesData:XMLList, gridData:String )
		{
			super( offset * WIDTH, 0 );
			
			
			m_tilemap = getTilemap( tilesData );
			m_grid = getGrid( gridData );
			
			m_playerPos = Player.START_POSITION;
			
			m_emitter = new Emitter(
				Assets.scaleGraphic( Assets.POOF_RAW, Display.SCALE ),
				16 * Display.SCALE,
				16 * Display.SCALE
			);
			m_emitter.newType( ParticleDef.POOF, [0, 1, 2, 3] );
			m_emitter.setMotion( ParticleDef.POOF, 0, 1.0, 0.4, 360.0, 0.0, 0.8 );
			
			
			type = CollisionDef.WORLD;
			graphic = new Graphiclist( m_tilemap, m_emitter );
			mask = m_grid;
			
			FP.world.add( this );
		}
		
		override public function update():void
		{
			var offsetFromPlayer:int = m_playerPos.x + 48.0 - x;
			
			if ( offsetFromPlayer > 0 )
			{
				var x:int = offsetFromPlayer / TILE_SIZE;
				for ( var y:int = 0; y < HEIGHT / TILE_SIZE; y++ )
				{
					var index:uint = m_tilemap.getTile( x, y );
					var emit:Boolean = Math.floor( Math.random() * 1.2 ) == 0;
					
					if ( index == 0 || index == 3 )
					{
						m_tilemap.setTile( x, y, 6 );
						
						if ( emit )
							m_emitter.emit( ParticleDef.POOF, x * TILE_SIZE, y * TILE_SIZE );
						
						GameWorld.globals.points += 5;
						GameWorld.globals.tiles++;
						
						continue;
					}
					
					if ( index == 1 || index == 4 )
					{
						m_tilemap.setTile( x, y, 7 );
						
						if ( emit )
							m_emitter.emit( ParticleDef.POOF, x * TILE_SIZE, y * TILE_SIZE );
						
						GameWorld.globals.points += 5;
						GameWorld.globals.tiles++;
						
						continue;
					}
					
					if ( index == 2 || index == 5 )
					{
						m_tilemap.setTile( x, y, 8 );
						
						if ( emit )
							m_emitter.emit( ParticleDef.POOF, x * TILE_SIZE, y * TILE_SIZE );
						
						GameWorld.globals.points += 10;
						GameWorld.globals.tiles++;
						
						continue;
					}
				}
			}
		}
		
		public function forceMinimalize( playerX:int ):void
		{
			var offsetFromPlayer:int = playerX + 48.0 - x;
			
			if ( offsetFromPlayer > 0 )
			{
				for ( var x:int = 0; x <= offsetFromPlayer / TILE_SIZE; x++ )
					for ( var y:int = 0; y < HEIGHT / TILE_SIZE; y++ )
					{
						var index:uint = m_tilemap.getTile( x, y );
						
						if ( index == 0 || index == 3 )
						{
							m_tilemap.setTile( x, y, 6 );
							continue;
						}
						
						if ( index == 1 || index == 4 )
						{
							m_tilemap.setTile( x, y, 7 );
							continue;
						}
						
						if ( index == 2 || index == 5 )
						{
							m_tilemap.setTile( x, y, 8 );
							continue;
						}
					}
			}
		}
		
		public function setPlayerPosition( x:int, y:int ):void
		{
			m_playerPos = new Point( x, y );
		}
	}

}
