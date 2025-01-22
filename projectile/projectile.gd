extends Area2D
class_name PROJECTILE

@onready var player = $"../../../Player"

var is_spawn_animation_done = false
var damage = 10
@onready var initial_damage = Global.projectile_damage
var speed = 1.3

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = initial_damage
	var direction = rotation * PI
	set_rotation(direction)
	update_damage()
	print(Global.projectile_damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_spawn_animation_done == true:
		position.y += speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func update_damage():
	$Label.text = str(damage)


func _on_body_entered(body):
	if body is PLAYER:
		damage = damage - body.damage
		if damage < 1:
			damage = 0
		update_damage()
		body.damage -= initial_damage
		if body.damage < 1:
			body.damage = 1
	body.update_label()
	if damage < 1:
		queue_free()



func _on_timer_timeout():
	is_spawn_animation_done = true
