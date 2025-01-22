extends Area2D

@onready var attack_pattern_1 = load("res://AttackPatterns/attack_pattern_1.tscn")
@onready var attack_pattern_2 = load("res://AttackPatterns/attack_pattern_2.tscn")
@onready var n = attack_pattern_1

@onready var fire_rate_timer = $FireRateTimer
@onready var progress_bar = $ProgressBar
@onready var attack_cooldown_timer = $AttackCooldownTimer

var is_on_cooldown = false
var vary_attack = 0
var health : float = 5000


func _ready():
	progress_bar.max_value = health
	fire_projectile(n)
	update_health(0)


func fire_projectile(projectile):
	var projectile_attack = projectile.instantiate()
	if is_on_cooldown:
		pass
	else:
		add_child(projectile_attack)
		if vary_attack == 3 and n == attack_pattern_1:
			n = attack_pattern_2
			vary_attack = 0
			increment_projectile_damage()
			start_cooldown()
		elif vary_attack == 3 and n == attack_pattern_2:
			n = attack_pattern_1
			vary_attack = 0
			start_cooldown()
		else:
			fire_rate_timer.start()
			vary_attack += 1


func update_health(damage):
	health = health - damage
	$ProgressBar.value = health
	if health < 1:
		death()

func _on_timer_timeout():
	fire_projectile(n)

func increment_projectile_damage():
	Global.projectile_damage = Global.projectile_damage * 1.5

func _on_attack_cooldown_timer_timeout():
	is_on_cooldown = false
	fire_rate_timer.start()

func start_cooldown():
	is_on_cooldown = true
	attack_cooldown_timer.start()
	
func death():
	pass
