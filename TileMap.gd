extends TileMap

enum {STONE, STONE_LAVA}

var map : Array = [
	[1,1,1,1],
	[1,0,0,1],
	[1,0,0,1],
	[1,1,1,1],
]

func _ready() -> void:
	for y in map.size():
		for x in map.size():
			self.set_cellv( Vector2(x, y), map[y][x])


#func _process(delta):
#	pass
