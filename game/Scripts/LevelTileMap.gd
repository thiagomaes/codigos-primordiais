class_name LevelTileMap extends TileMap

func _ready():
	LevelManager.ChangeTilemapBounds( GetTilemapBounds() )

func GetTilemapBounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	var rect = get_used_rect()
	var tile_size = tile_set.tile_size
	bounds.append( Vector2(rect.position) * Vector2(tile_size) )
	bounds.append( Vector2(rect.end) * Vector2(tile_size) )
	return bounds
