extends Node2D
signal on_sides_complete

@onready var off_state = load("res://booster/booster-part.png")
@onready var on_state = load("res://booster/booster-part-green.png")

@onready var upside = $Center/Upside
@onready var leftside = $Center/Leftside
@onready var rightside = $Center/Rightside
@onready var downside = $Center/Downside

var leftside_is_on : bool
var upside_is_on : bool
var rightside_is_on : bool
var downside_is_on : bool
var sides_on = 0

func _ready():
	upside.texture = off_state # the off state is hard to manipulate in the 2d
	leftside.texture = off_state
	rightside.texture = off_state
	downside.texture = off_state


func _process(delta):
	pass

func leftside_update():
	if leftside_is_on == false:
		leftside_is_on = true
		leftside.texture = on_state
		check_side()

func upside_update():
	if upside_is_on == false:
		upside_is_on = true
		upside.texture = on_state
		check_side()

func rightside_update():
	if rightside_is_on == false:
		rightside_is_on = true
		rightside.texture = on_state
		check_side()

func downside_update():
	if downside_is_on == false:
		downside_is_on = true
		downside.texture = on_state
		check_side()

func check_side():
	sides_on += 1
	if sides_on == 4:
		emit_signal("on_sides_complete")
		reset_sides()

func reset_sides():
	downside_is_on = false
	upside_is_on = false
	leftside_is_on = false
	rightside_is_on = false
	downside.texture = off_state
	upside.texture = off_state
	leftside.texture = off_state
	rightside.texture = off_state
	sides_on = 0

func _on_area_2d_body_entered_left_side(body):
	if body is PLAYER:
		leftside_update()

func _on_area_2d_body_entered_up_side(body):
	if body is PLAYER:
		upside_update()

func _on_area_2d_body_entered_right_side(body):
	if body is PLAYER:
		rightside_update()

func _on_area_2d_body_entered_down_side(body):
	if body is PLAYER:
		downside_update()
