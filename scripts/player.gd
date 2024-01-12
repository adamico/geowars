class_name Player
extends CharacterBody2D
## A brief description of the class's role and functionality.
##
## The description of the script, what it can do,
## and any further detail.

signal captured(player_number, capture, pos)

@export var player_number := 1
@export var animation_speed := 4
@export var capture_speed_multiplier := 1

var capture_duration: float = 2.0 / capture_speed_multiplier
var capture_time: float
var capturing := false
var moving := false