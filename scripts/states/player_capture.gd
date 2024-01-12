class_name PlayerCapture
extends State

@export var player: Player
@onready var Capture = preload("res://scenes/capture.tscn")

func Enter():
	if player:
		player.capturing = true
		player.capture_time = player.capture_duration
		Debug.SetCharacterState("Capturing")


func Exit():
	%CaptureAction.hide()


func Physics_Update(delta: float):
	%CaptureAction.show()
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
		player.captured.emit(player.player_number, Capture, player.position)
		player.capture_time = 3
		Transitioned.emit(self, "idle")

	Debug.SetCaptureTime(round(player.capture_time))
