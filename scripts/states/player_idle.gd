extends State
class_name PlayerIdle

@export var player: Player

func Enter():
	player.capturing = false
	Debug.SetCharacterState("Idle")

func Physics_Update(delta: float):
	if Input.is_action_pressed("capture") and can_capture():
		Transitioned.emit(self, "capture")

func can_capture():
	if player.moving: return false 
	return !Data.get_captured_cells_for_player(player.player_number).has(Data.cell_coords(player.position))
