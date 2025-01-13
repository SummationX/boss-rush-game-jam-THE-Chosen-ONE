extends Area2D

var health = 1000

func on_projectile_hit(damage):
	health = health - damage


func _on_area_entered(area):
	if area is PROJECTILE:
		area.queue_free()
		on_projectile_hit(area.damage)
