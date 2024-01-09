extends Area2D
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

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

@onready var ray = $RayCast2d

func _unhandled_input(event):
	if !moving and !capturing:
		for dir in inputs.keys():
			if event.is_action_pressed(dir): move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		#$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
		Debug.SetCellPosition(global_position, tile_size)
