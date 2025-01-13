extends CharacterBody2D
class_name PLAYER

var damage = 1
var speed = 0.5

func _ready():
	update_label()

func _physics_process(delta):
	position.x = lerp(position.x, get_global_mouse_position().x, speed)
	position.y = lerp(position.y, get_global_mouse_position().y, speed)

func update_label():
	$"../CanvasLayer/Numbers".text = str(damage)

func update_damage():
	var increment_damage
	if damage > 1000:
		increment_damage = 1.05
	elif damage > 100:
		increment_damage = 1.1
	elif damage > 10:
		increment_damage = 1.5
	else:
		increment_damage = 2

	damage = damage * increment_damage
	print(str(increment_damage))
	update_label()
