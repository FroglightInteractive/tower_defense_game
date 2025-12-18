class_name Level
extends Node2D

## The number of the level (Level 1, Level 2, etc)
@export var level_number: int
## The amount of enemies that will spawn in the level
@export var enemy_count: int
## The amount of health the level will have
@export var max_health: float

## The amount of enemies there are left in the level
var enemies_left: int
## The amount of health the level has left
var health_left: float


func _ready() -> void:
	enemies_left = enemy_count
	health_left = max_health


func _process(delta: float) -> void:
	# handle losing
	if health_left <= 0:
		lose_level()
	
	# handle enemy movement
	for node in $Path.get_children():
		if node.is_in_group("enemies") and node is PathFollow2D:
			node.progress_ratio += delta


func _on_end_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		health_left -= area.damage
		area.queue_free()


## Called when health_left <= 0; the level has been lost
func lose_level() -> void:
	print("lost level: " + str(level_number))
