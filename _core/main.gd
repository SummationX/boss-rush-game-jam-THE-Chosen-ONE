extends Node2D

@onready var player = $Player
@onready var current_boss = $Boss
@onready var damage_title = $CanvasLayer/DamageTitle
@onready var state_texture = $CanvasLayer/StateTexture
@onready var power_bar = $CanvasLayer/ProgressBar

var current_state
enum state {Attack, Increment, Defend}

func _process(delta):
	power_bar.max_value = current_boss.health
	power_bar.value = player.damage


func _ready():
	current_state = state.Increment
	damage_title.text = "Incremental"
	

func _on_booster_on_sides_complete():
	if current_state == state.Increment:
		player.update_damage()
	if current_state == state.Defend:
		pass
	if current_state == state.Attack:
		if !current_boss.is_dead:
			current_boss.update_health(player.half_damage())

func _input(event):
	if Input.is_action_pressed("attack_mode"):
		current_state = state.Attack
		damage_title.text = "Attack/Half"
		player.set_collision_layer_value(1, true)
		player.set_collision_layer_value(2, false)
		state_texture.texture = load("res://_core/ui/assets/Sword.png")
	if Input.is_action_pressed("increment_mode"):
		current_state = state.Increment
		damage_title.text = "Incremental"
		player.set_collision_layer_value(1, true)
		player.set_collision_layer_value(2, false)
		state_texture.texture = load("res://_core/ui/assets/green arrow up.png")
	if Input.is_action_pressed("defend_mode"):
		current_state = state.Defend
		damage_title.text = "Defend"
		player.set_collision_layer_value(1, false)
		player.set_collision_layer_value(2, true)
		state_texture.texture = load("res://_core/ui/assets/shield.png")


func _on_boss_on_boss_death():
	get_tree().call_group("projectile", "queue_free")
