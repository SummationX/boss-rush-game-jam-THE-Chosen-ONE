extends CharacterBody2D
class_name PLAYER

var damage : float = 1.00
var speed = 0.5

func _ready():
	update_label()

func _physics_process(delta):
	position.x = lerp(position.x, get_global_mouse_position().x, speed)
	position.y = lerp(position.y, get_global_mouse_position().y, speed)

func update_label():
	$"../CanvasLayer/Numbers".text = str(int(damage))

func update_damage():
	var increment_damage
	if damage > 1000:
		increment_damage = 1.05
	elif damage > 100:
		increment_damage = 1.2
	elif damage > 10:
		increment_damage = 1.6
	else:
		increment_damage = 3.00

	damage = damage * increment_damage
	update_label()

func half_damage() -> float:
	damage = damage/2.00
	if damage < 1:
		damage = 1
	update_label()
	return damage
