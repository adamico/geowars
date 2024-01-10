extends State
class_name PlayerShoot

@export var player: Player

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func Enter():
	Debug.SetCharacterState("Shooting")
	
func Update(_delta):
	for key in inputs.keys():
		if Input.is_action_pressed(key):
			shoot(key)
	if Input.is_action_just_released("shoot"):
		Transitioned.emit(self, "idle")
		
func shoot(dir):
	pass
