extends State
class_name PlayerIdle

@export var player: Player

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
		
	if Input.is_action_pressed("capture") and can_capture():
		Transitioned.emit(self, "capture")

func can_capture():
	return !Data.get_captured_cells_for_player(player.player_number).has(Data.cell_coords(player.position))
