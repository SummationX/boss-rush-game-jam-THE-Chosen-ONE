extends Area2D

@onready var attack_pattern_1 = load("res://AttackPatterns/attack_pattern_1.tscn")
@onready var attack_pattern_2 = load("res://AttackPatterns/attack_pattern_2.tscn")

@onready var n = attack_pattern_1
var vary_attack = 0

func _ready():
	fire_projectile(n)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func fire_projectile(projectile):
	var projectile_attack = projectile.instantiate()
	add_child(projectile_attack)
	$Timer.start()
	vary_attack += 1
	if vary_attack == 3 and n == attack_pattern_1:
		n = attack_pattern_2
		vary_attack = 0
	elif vary_attack == 3 and n ==attack_pattern_2:
		n = attack_pattern_1
		vary_attack = 0
	


func _on_timer_timeout():
	fire_projectile(n)
