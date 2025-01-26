extends Area2D

@onready var health_bar = $ProgressBar

var health = 500


func _ready():
	health_bar.max_value = health
	health_bar.value = health


func on_projectile_hit(damage):
	health = health - damage
	health_bar.value = health
	if health < 1:
		base_death()


func _on_area_entered(area):
	if area is PROJECTILE:
		area.queue_free()
		on_projectile_hit(area.damage)

func base_death():
	get_tree().change_scene_to_file("res://death_menu.tscn")
