extends CharacterBody2D

class_name Player

signal captured(player_number, capture, pos)

@export var player_number: int = 1
@export var animation_speed: int = 4
@export var tile_size: int
@export var capture_speed_multiplier = 1
@export var capture_duration: float = 2.0 / capture_speed_multiplier
@export var capture_time: float
@export var capturing: bool = false
@export var moving: bool = false

@onready var movement_validation: RayCast2D = $MovementValidation
@onready var movement_tween: Node = $MovementTween

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func _unhandled_input(event):
	if !moving and !capturing:
		for dir in inputs.keys():
			if event.is_action_pressed(dir): move(dir)

func move(dir):
	if movement_validation.validate_movement(inputs[dir] * tile_size):
		moving = true
		movement_tween.move_time = 1.0/animation_speed
		#$AnimationPlayer.play(dir)
		movement_tween.run(self, position + inputs[dir] * tile_size)
		await movement_tween.tween.finished
		moving = false
		Debug.SetCellPosition(global_position, tile_size)
