class_name PlayerCapture
extends State

@export var player: Player
@onready var capture = preload("res://scenes/capture.tscn")
@onready var capture_action = %CaptureAction

func Enter():
	if player:
		player.capturing = true
		player.capture_time = player.capture_duration
		Debug.SetCharacterState("Capturing")
		capture_action.modulate = Data.PLAYER_COLORS[player.player_number - 1]


func Exit():
	capture_action.hide()


func Physics_Update(delta: float):
	capture_action.show()
	if Input.is_action_just_released("capture"):
		player.capture_time = 3
		Transitioned.emit(self, "idle")
		
	if player.capture_time > 0:
		player.capture_time -= delta
		var expression = (player.capture_duration-player.capture_time)/player.capture_duration
		%Up.scale = Vector2(expression, 1)
		%Down.scale = Vector2(expression, 1)
		%Right.scale = Vector2(1, expression)
		%Left.scale = Vector2(1, expression)
	else:
		player.captured.emit(player.player_number, capture, player.position)
		player.capture_time = 3
		Transitioned.emit(self, "idle")

	Debug.SetCaptureTime(round(player.capture_time))
