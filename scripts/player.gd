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
