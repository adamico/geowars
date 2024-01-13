class_name Capture
extends Node2D

@onready var square: Polygon2D = $CaptureSquare
var player: Player

func _ready():
	square.color = Data.PLAYER_COLORS[player.player_number - 1]
