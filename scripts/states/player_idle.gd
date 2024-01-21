class_name PlayerIdle
extends State

@export var player: Player

@onready var world: World = player.get_parent()
@onready var level: TileMap = world.get_level()

var cell_size: int = Data.cell_size_number
var can_capture: bool = false

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func Enter():
	player.capturing = false
	Debug.SetCharacterState("Idle")

func Physics_Update(_delta: float):
	for key in inputs.keys():
		if Input.is_action_pressed(key):
			if Input.is_action_pressed("shoot"):
				Transitioned.emit(self, "shoot")
			else:
				Transitioned.emit(self, "move")

	can_capture =	cell_is_already_captured() and current_cell_is_a_capturable_square()

	Debug.SetCanCapture(can_capture)

	if Input.is_action_pressed("capture") and can_capture:
		Transitioned.emit(self, "capture")

func cell_is_already_captured() -> bool:
	return not Data.get_captured_cells_for_player(player.player_number).has(Data.cell_coords(player.position))

func current_cell_is_a_capturable_square() -> bool:
	var return_value: bool
	var data = level.get_cell_tile_data(world.LEVEL_LAYER, player.position / Vector2(cell_size, cell_size)) 
	
	return_value = data.get_custom_data("capturable") if data else false
	return return_value
