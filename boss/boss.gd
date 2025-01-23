extends Area2D
signal on_boss_death

#Health
@onready var progress_bar = $ProgressBar
@onready var health_text = $HealthText

#Attack pattern
@onready var attack_pattern_1 = load("res://AttackPatterns/attack_pattern_1.tscn")
@onready var attack_pattern_2 = load("res://AttackPatterns/attack_pattern_2.tscn")
@onready var n = attack_pattern_1

#Projectile
@onready var fire_rate_timer = $FireRateTimer
@onready var attack_cooldown_timer = $AttackCooldownTimer

#Animation
@onready var animation = $BossAnimation
@onready var explosion_animation = $Explosion
@onready var up_position = $UpPosition
@onready var down_position = $DownPosition
@onready var movement_timer = $MovementTimer

var is_on_cooldown = false
var vary_attack = 0
var health : float = 5000
var speed = 1
var move_direction 
var is_dead = false
enum move {Up, Down}


func _ready():
	progress_bar.max_value = health
	fire_projectile(n)
	update_health(0)
	animation.play()
	movement_timer.start()
	move_direction = move.Down
	explosion_animation.hide()
	health_text.text = str(int(health))

func _physics_process(delta):
	if !is_dead:
		if move_direction == move.Down:
			position.y += speed
		if move_direction == move.Up:
			position.y -= speed

func fire_projectile(projectile):
	if is_on_cooldown:
		pass
	else:
		var projectile_attack = projectile.instantiate()
		projectile_attack.position = down_position.global_position
		get_parent().add_child(projectile_attack)
		
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
	progress_bar.value = health
	health_text.text = str(int(health))
	if health < 1:
		death()

func _on_timer_timeout():
	fire_projectile(n)

func increment_projectile_damage():
	Global.projectile_damage = Global.projectile_damage * 1.5

func _on_attack_cooldown_timer_timeout():
	is_on_cooldown = false
	fire_rate_timer.start()
	animation.play()

func start_cooldown():
	animation.pause()
	animation.frame = 1
	is_on_cooldown = true
	attack_cooldown_timer.start()

func death():
	is_dead = true
	animation.hide()
	on_boss_death.emit()
	explosion_animation.show()
	explosion_animation.play()
	fire_rate_timer.stop()
	attack_cooldown_timer.stop()
	movement_timer.stop()



func _on_movement_timer_timeout():
	match move_direction:
		move.Up:
			move_direction = move.Down
		move.Down:
			move_direction = move.Up
	movement_timer.start()


func _on_explosion_animation_finished():
	explosion_animation.hide()
