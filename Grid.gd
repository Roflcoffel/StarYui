extends TileMap

onready var _ground_tiles : TileMap = $YSort/Ground_Tiles
onready var _object_tiles : TileMap = $YSort/Object_Tiles

onready var _player : Sprite = $YSort/Player
var player_cord : Vector2 = Vector2( 0, 0 )

onready var tile_size : Vector2 = self.cell_size

#Ground Layer
enum g_tile {STONE, STONE_LAVA}

var ground_layer : Array = [
	[0,1,0,1,0,0,0,1,0,0],
	[0,0,1,0,0,0,0,1,0,0],
	[0,0,1,1,0,1,0,1,0,0],
	[0,0,1,1,0,0,0,0,0,0]
]

#Object Layer
enum o_tile {NONE, BLOCK, PLAYER}

var object_layer : Array = [
	[2,0,0,1,0,0,0,1,0,1],
	[0,0,0,1,0,0,0,1,0,1],
	[1,0,0,0,0,0,0,1,0,1],
	[1,0,0,0,0,0,0,0,0,1]
]

func _ready() -> void:
	draw_map()

func draw_map() -> void:
	#Ground Layer
	for y in ground_layer.size():
		for x in ground_layer[y].size():
			_ground_tiles.set_cell( x, y, ground_layer[y][x])
			
	#Object Layer
	for y in object_layer.size():
		for x in object_layer[y].size():
			if object_layer[y][x] == o_tile.NONE:
				#Empty Slots
				continue
			
			if object_layer[y][x] == o_tile.PLAYER:
				##Half tile size maybe, origin is at the center.
				
				_player.position.x = x * tile_size.x/2
				_player.position.y = y * tile_size.y
				
				#print("Cart Position:", _player.position)
				
				_player.position = to_isometric(_player.position)
				
				#print("Iso Position:", _player.position)
				
				continue
			
			_object_tiles.set_cell( x, y, object_layer[y][x])
			
func _input(event) -> void:
	if not event is InputEventMouseButton:
		return
	
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	
	#NOTE: event.position gives top left as (0,0)
	var mouse_pos : Vector2 = get_global_mouse_position()
	
	#Move player to mouse_cord
	var mouse_cord : Vector2 = world_to_map(mouse_pos)
	
	#Move Player
	object_layer[mouse_cord.y][mouse_cord.x] = 2
	
	#Remove Old Pos from layer and update player cord
	object_layer[player_cord.y][player_cord.x] = 0
	player_cord = mouse_cord
	
	#Update Map
	draw_map()
	
func to_isometric(cart : Vector2) -> Vector2:
	return Vector2(cart.x - cart.y, (cart.x + cart.y) / 2)
	
func to_cartesian(iso : Vector2) -> Vector2:
	return Vector2((2 * iso.y + iso.x) / 2, (2 * iso.y - iso.x) / 2)