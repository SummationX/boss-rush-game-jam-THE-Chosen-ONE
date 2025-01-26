extends Control


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://_core/main.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://_core/ui/main_menu.tscn")
